import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:my_quran/Componen/Widget/TextDataWidget.dart';
import 'package:my_quran/Componen/Widget/qibla_compass_widget.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/model_kota_sholat.dart';
import 'package:my_quran/Provider/Shalat/shalat_api.dart';
import 'package:my_quran/Utils/qibla_calculator.dart';
import 'package:provider/provider.dart';

class KiblatPage extends StatefulWidget {
  const KiblatPage({super.key});

  @override
  State<KiblatPage> createState() => _KiblatPageState();
}

class _KiblatPageState extends State<KiblatPage> {
  double _currentHeading = 0.0;
  bool _hasCompassSensor = true;
  bool _isAutoCompassActive = true;
  bool _hasVibrated = false;
  StreamSubscription<CompassEvent>? _compassSubscription;
  final NumberFormat _numberFormat = NumberFormat('#,###', 'id_ID');

  @override
  void initState() {
    super.initState();
    _startCompassStream();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final shalatProvider = Provider.of<ShalatApi>(context, listen: false);
      if (shalatProvider.selectedKota == null) {
        shalatProvider.initLocationAndSchedule();
      }
    });
  }

  void _startCompassStream() {
    try {
      final stream = FlutterCompass.events;
      if (stream == null) {
        setState(() {
          _hasCompassSensor = false;
          _isAutoCompassActive = false;
        });
        return;
      }

      _compassSubscription = stream.listen(
        (CompassEvent event) {
          if (!mounted) return;
          final heading = event.heading;
          if (heading != null && _isAutoCompassActive) {
            setState(() {
              _currentHeading = (heading + 360) % 360;
              _hasCompassSensor = true;
            });

            // Trigger gentle haptic feedback when aligned
            final shalatProvider = Provider.of<ShalatApi>(
              context,
              listen: false,
            );
            final cityName =
                shalatProvider.selectedKota?.lokasi ?? "KOTA JAKARTA";
            final coords = QiblaCalculator.getCityCoordinates(cityName);
            final qiblaAngle = QiblaCalculator.calculateQibla(
              coords["lat"]!,
              coords["lng"]!,
            );
            final diff = (qiblaAngle - _currentHeading + 360) % 360;

            if (diff < 3 || diff > 357) {
              if (!_hasVibrated) {
                HapticFeedback.lightImpact();
                _hasVibrated = true;
              }
            } else {
              _hasVibrated = false;
            }
          }
        },
        onError: (_) {
          if (mounted) {
            setState(() {
              _hasCompassSensor = false;
              _isAutoCompassActive = false;
            });
          }
        },
      );
    } catch (_) {
      setState(() {
        _hasCompassSensor = false;
        _isAutoCompassActive = false;
      });
    }
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }

  void _showCitySearchModal(BuildContext context, ShalatApi provider) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return _CitySearchModal(
          initialList: provider.listKota,
          currentSelected: provider.selectedKota,
          onSelect: (kota) {
            provider.selectCity(kota);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextData(
          text: "Arah Kiblat",
          size: 20,
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Consumer<ShalatApi>(
        builder: (context, provider, child) {
          final cityName = provider.selectedKota?.lokasi ?? "KOTA JAKARTA";
          final coords = QiblaCalculator.getCityCoordinates(cityName);
          final double lat = coords["lat"]!;
          final double lng = coords["lng"]!;

          final double qiblaAngle = QiblaCalculator.calculateQibla(lat, lng);
          final double distanceKm = QiblaCalculator.calculateDistance(lat, lng);
          final String directionName = QiblaCalculator.getDirectionName(
            qiblaAngle,
          );

          final double relativeQiblaAngle =
              (qiblaAngle - _currentHeading + 360) % 360;
          final bool isAligned =
              (relativeQiblaAngle < 3 || relativeQiblaAngle > 357);

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            children: [
              // 1. Location Bar
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: mainColor.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: mainColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lokasi Anda",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: isDark
                                ? Colors.white60
                                : Colors.grey.shade500,
                          ),
                        ),
                        Text(
                          cityName,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _showCitySearchModal(context, provider),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: mainColor.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.2)
                                : Colors.black.withOpacity(0.03),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.edit_location_alt_rounded,
                            size: 14,
                            color: mainColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Ubah",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 2. Hero Info Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isAligned
                        ? [const Color(0xFF00C853), const Color(0xFF00897B)]
                        : [const Color(0xffC58AF9), const Color(0xff7B3FE4)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          (isAligned
                                  ? const Color(0xFF00C853)
                                  : const Color(0xff7B3FE4))
                              .withOpacity(0.3),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isAligned
                                    ? Icons.check_circle_rounded
                                    : Icons.explore_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              TextData(
                                text: isAligned
                                    ? "Tepat Menghadap Kiblat!"
                                    : "Arah Kiblat Presisi",
                                size: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "${qiblaAngle.toStringAsFixed(1)}°",
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  directionName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "~${_numberFormat.format(distanceKm.round())} km ke Ka'bah di Makkah",
                            style: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: 0.9,
                      child: Image.asset(
                        "assets/image/Qibla.png",
                        width: 70,
                        height: 70,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.mosque,
                              size: 60,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 3. Visual Live Qibla Compass Card
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.25)
                          : Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Sensor Status Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _isAutoCompassActive
                            ? (isDark
                                  ? const Color(0xFF1B381E)
                                  : const Color(0xFFE8F5E9))
                            : (isDark
                                  ? const Color(0xFF2A2A2A)
                                  : Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isAutoCompassActive
                                ? Icons.sensors_rounded
                                : Icons.touch_app_rounded,
                            size: 14,
                            color: _isAutoCompassActive
                                ? (isDark
                                      ? const Color(0xFF81C784)
                                      : const Color(0xFF2E7D32))
                                : (isDark
                                      ? Colors.white60
                                      : Colors.grey.shade700),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _isAutoCompassActive
                                ? "Sensor Kompas Otomatis"
                                : "Mode Manual / Simulasi",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _isAutoCompassActive
                                  ? (isDark
                                        ? const Color(0xFF81C784)
                                        : const Color(0xFF2E7D32))
                                  : (isDark
                                        ? Colors.white60
                                        : Colors.grey.shade700),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Putar ponsel Anda hingga jarum mengarah ke Ka'bah",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),

                    // Compass Widget with Live Angle
                    QiblaCompassWidget(
                      qiblaAngle: qiblaAngle,
                      currentHeading: _currentHeading,
                      size: 260,
                    ),

                    const SizedBox(height: 24),

                    // Manual Rotation Controls (Active when manual mode or no sensor)
                    if (!_isAutoCompassActive || !_hasCompassSensor) ...[
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Orientasi Perangkat: ${_currentHeading.round()}°",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (_hasCompassSensor)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isAutoCompassActive = true;
                                    });
                                  },
                                  child: const Text(
                                    "Aktifkan Sensor",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: mainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: mainColor,
                              inactiveTrackColor: mainColor.withOpacity(0.15),
                              thumbColor: mainColor,
                              overlayColor: mainColor.withOpacity(0.1),
                            ),
                            child: Slider(
                              value: _currentHeading,
                              min: 0.0,
                              max: 359.0,
                              onChanged: (val) {
                                setState(() {
                                  _currentHeading = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.compass_calibration_rounded,
                            size: 14,
                            color: isDark
                                ? Colors.white60
                                : Colors.grey.shade500,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Hadap Ponsel: ${_currentHeading.round()}° ${QiblaCalculator.getDirectionName(_currentHeading)}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? Colors.white70
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // 4. Instructions & Best Accuracy Tips
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.2)
                          : Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: mainColor,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Petunjuk Akurasi Kompas",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildTipItem(
                      Icons.phone_android_rounded,
                      "Pegang ponsel secara mendatar (horizontal) sejajar dengan permukaan lantai/tanah.",
                      isDark,
                    ),
                    const SizedBox(height: 8),
                    _buildTipItem(
                      Icons.all_inclusive_rounded,
                      "Bila kompas kurang akurat, gerakkan ponsel membentuk angka 8 di udara untuk kalibrasi sensor.",
                      isDark,
                    ),
                    const SizedBox(height: 8),
                    _buildTipItem(
                      Icons.sensors_off_rounded,
                      "Jauhkan ponsel dari medan magnetik, casing magnetik tebal, atau benda logam besar.",
                      isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTipItem(IconData icon, String text, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: isDark ? Colors.white60 : Colors.grey.shade600,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.black54,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

// BottomSheet Modal for Searching Indonesian Cities
class _CitySearchModal extends StatefulWidget {
  final List<ModelKotaSholat> initialList;
  final ModelKotaSholat? currentSelected;
  final ValueChanged<ModelKotaSholat> onSelect;

  const _CitySearchModal({
    required this.initialList,
    required this.currentSelected,
    required this.onSelect,
  });

  @override
  State<_CitySearchModal> createState() => _CitySearchModalState();
}

class _CitySearchModalState extends State<_CitySearchModal> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filtered = widget.initialList.where((k) {
      if (_query.isEmpty) return true;
      return k.lokasi.toLowerCase().contains(_query.toLowerCase().trim());
    }).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Material(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Modal Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                Text(
                  "Pilih Kota / Lokasi",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Pilih kota Anda untuk menghitung sudut arah kiblat presisi",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isDark ? Colors.white60 : Colors.black45,
                  ),
                ),

                const SizedBox(height: 14),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFF7F8FA),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: _searchController,
                    autofocus: false,
                    style: GoogleFonts.poppins(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 13,
                    ),
                    onChanged: (val) {
                      setState(() {
                        _query = val;
                      });
                    },
                    decoration: InputDecoration(
                      hintText:
                          "Cari kota (contoh: Jakarta, Bandung, Surabaya)...",
                      hintStyle: GoogleFonts.poppins(
                        color: isDark ? Colors.white38 : Colors.grey.shade400,
                        fontSize: 13,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: mainColor,
                      ),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _query = '';
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // City List
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Text(
                            "Kota tidak ditemukan",
                            style: GoogleFonts.poppins(
                              color: isDark
                                  ? Colors.white60
                                  : Colors.grey.shade500,
                              fontSize: 13,
                            ),
                          ),
                        )
                      : ListView.separated(
                          controller: scrollController,
                          itemCount: filtered.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            color: isDark
                                ? Colors.white12
                                : const Color(0xFFF0F0F0),
                          ),
                          itemBuilder: (context, index) {
                            final kota = filtered[index];
                            final isSelected =
                                widget.currentSelected?.id == kota.id;

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              leading: Icon(
                                Icons.location_city_rounded,
                                color: isSelected
                                    ? mainColor
                                    : (isDark
                                          ? Colors.white60
                                          : Colors.grey.shade400),
                                size: 20,
                              ),
                              title: Text(
                                kota.lokasi,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? mainColor
                                      : (isDark ? Colors.white : Colors.black87),
                                ),
                              ),
                              trailing: isSelected
                                  ? const Icon(
                                      Icons.check_circle_rounded,
                                      color: mainColor,
                                      size: 20,
                                    )
                                  : null,
                              onTap: () => widget.onSelect(kota),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
