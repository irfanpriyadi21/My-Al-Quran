import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:my_quran/Componen/Widget/TextDataWidget.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/model_jadwal_sholat.dart';
import 'package:my_quran/Model/model_kota_sholat.dart';
import 'package:my_quran/Provider/Shalat/shalat_api.dart';
import 'package:provider/provider.dart';

class JadwalShalatPage extends StatefulWidget {
  const JadwalShalatPage({super.key});

  @override
  State<JadwalShalatPage> createState() => _JadwalShalatPageState();
}

class _JadwalShalatPageState extends State<JadwalShalatPage> {
  Timer? _countdownTimer;
  DateTime _currentTime = DateTime.now();

  String _formatIndonesianDate(DateTime date) {
    try {
      return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date);
    } catch (_) {
      const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
      const months = [
        'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
      ];
      final dayName = days[date.weekday - 1];
      final monthName = months[date.month - 1];
      return '$dayName, ${date.day} $monthName ${date.year}';
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ShalatApi>(context, listen: false);
      if (provider.jadwalToday == null) {
        provider.initLocationAndSchedule();
      }
    });

    // Update real-time clock & countdown every second
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  // Menghitung waktu shalat berikutnya dan sisa waktu (countdown)
  Map<String, dynamic> _getNextPrayerInfo(ModelJadwalSholat? jadwal) {
    if (jadwal == null) {
      return {'name': 'Memuat...', 'time': '--:--', 'countdown': '--:--:--', 'isToday': true};
    }

    final now = _currentTime;
    final prayerTimes = [
      {'name': 'Imsak', 'time': jadwal.imsak},
      {'name': 'Subuh', 'time': jadwal.subuh},
      {'name': 'Terbit', 'time': jadwal.terbit},
      {'name': 'Dhuha', 'time': jadwal.dhuha},
      {'name': 'Dzuhur', 'time': jadwal.dzuhur},
      {'name': 'Ashar', 'time': jadwal.ashar},
      {'name': 'Maghrib', 'time': jadwal.maghrib},
      {'name': 'Isya', 'time': jadwal.isya},
    ];

    for (var prayer in prayerTimes) {
      final timeStr = prayer['time'] as String;
      final parts = timeStr.split(':');
      if (parts.length == 2) {
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = int.tryParse(parts[1]) ?? 0;
        final prayerDateTime = DateTime(now.year, now.month, now.day, hour, minute);

        if (prayerDateTime.isAfter(now)) {
          final diff = prayerDateTime.difference(now);
          final h = diff.inHours.toString().padLeft(2, '0');
          final m = (diff.inMinutes % 60).toString().padLeft(2, '0');
          final s = (diff.inSeconds % 60).toString().padLeft(2, '0');
          return {
            'name': prayer['name'],
            'time': timeStr,
            'countdown': "-$h:$m:$s",
            'isToday': true,
          };
        }
      }
    }

    // Jika semua waktu shalat hari ini sudah lewat, menuju Subuh besok
    return {
      'name': 'Subuh',
      'time': jadwal.subuh,
      'countdown': 'Menuju Esok Hari',
      'isToday': false,
    };
  }

  void _showCitySearchModal(BuildContext context, ShalatApi provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
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

  Future<void> _pickDate(BuildContext context, ShalatApi provider) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: provider.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: mainColor,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      provider.selectDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextData(
          text: "Jadwal Shalat",
          size: 20,
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month_rounded, color: mainColor),
            tooltip: "Pilih Tanggal",
            onPressed: () {
              final provider = Provider.of<ShalatApi>(context, listen: false);
              _pickDate(context, provider);
            },
          ),
        ],
      ),
      body: Consumer<ShalatApi>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.jadwalToday == null) {
            return Center(
              child: CircularProgressIndicator(color: mainColor),
            );
          }

          if (provider.errorMessage.isNotEmpty && provider.jadwalToday == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_off_rounded,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      provider.errorMessage,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => provider.initLocationAndSchedule(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Coba Lagi"),
                    ),
                  ],
                ),
              ),
            );
          }

          final jadwal = provider.jadwalToday;
          final nextPrayer = _getNextPrayerInfo(jadwal);
          final hijri = HijriCalendar.fromDate(provider.selectedDate);
          final dateFormatted = _formatIndonesianDate(provider.selectedDate);

          return RefreshIndicator(
            color: mainColor,
            onRefresh: () => provider.getJadwal(
              provider.selectedKota?.id ?? "1301",
              provider.selectedDate,
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              children: [
                // Location Bar
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: mainColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
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
                            "Lokasi Saat Ini",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Text(
                            provider.selectedKota?.lokasi ?? "KOTA JAKARTA",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
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
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: mainColor.withValues(alpha: 0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.edit_location_alt_rounded, size: 14, color: mainColor),
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

                // Hero Countdown Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffC58AF9),
                        Color(0xff7B3FE4),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff7B3FE4).withValues(alpha: 0.3),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Background Quran / Mosque Illustration
                      Positioned(
                        right: -25,
                        bottom: -20,
                        child: Opacity(
                          opacity: 0.25,
                          child: Image.asset(
                            "assets/image/alQuran.png",
                            width: 140,
                            height: 140,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.mosque,
                              size: 100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_filled_rounded,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      DateFormat('HH:mm:ss').format(_currentTime),
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} H",
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          Text(
                            "Menuju ${nextPrayer['name']}",
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "${nextPrayer['time']}",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "${nextPrayer['countdown']}",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xff7B3FE4),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Text(
                            dateFormatted,
                            style: GoogleFonts.poppins(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Date Navigation Selector
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left_rounded, size: 28),
                        color: mainColor,
                        onPressed: () {
                          provider.selectDate(
                            provider.selectedDate.subtract(const Duration(days: 1)),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () => _pickDate(context, provider),
                        child: Column(
                          children: [
                            Text(
                              dateFormatted,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            if (DateFormat('yyyy-MM-dd').format(provider.selectedDate) ==
                                DateFormat('yyyy-MM-dd').format(DateTime.now()))
                              Text(
                                "Hari Ini",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: mainColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right_rounded, size: 28),
                        color: mainColor,
                        onPressed: () {
                          provider.selectDate(
                            provider.selectedDate.add(const Duration(days: 1)),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // List of Prayer Times (8 items)
                if (jadwal != null) ...[
                  _buildPrayerCard("Imsak", jadwal.imsak, Icons.nightlight_outlined, nextPrayer['name'] == 'Imsak'),
                  _buildPrayerCard("Subuh", jadwal.subuh, Icons.wb_twilight_rounded, nextPrayer['name'] == 'Subuh'),
                  _buildPrayerCard("Terbit", jadwal.terbit, Icons.wb_sunny_outlined, nextPrayer['name'] == 'Terbit'),
                  _buildPrayerCard("Dhuha", jadwal.dhuha, Icons.wb_sunny_rounded, nextPrayer['name'] == 'Dhuha'),
                  _buildPrayerCard("Dzuhur", jadwal.dzuhur, Icons.light_mode_rounded, nextPrayer['name'] == 'Dzuhur'),
                  _buildPrayerCard("Ashar", jadwal.ashar, Icons.wb_cloudy_rounded, nextPrayer['name'] == 'Ashar'),
                  _buildPrayerCard("Maghrib", jadwal.maghrib, Icons.nights_stay_outlined, nextPrayer['name'] == 'Maghrib'),
                  _buildPrayerCard("Isya", jadwal.isya, Icons.bedtime_rounded, nextPrayer['name'] == 'Isya'),
                ],

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPrayerCard(String name, String time, IconData icon, bool isNext) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isNext ? mainColor.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isNext ? mainColor : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isNext ? mainColor : mainColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isNext ? Colors.white : mainColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Row(
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: isNext ? FontWeight.bold : FontWeight.w600,
                      color: isNext ? mainColor : Colors.black87,
                    ),
                  ),
                  if (isNext) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Berikutnya",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isNext ? mainColor : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// BottomSheet Widget for Searching and Selecting Indonesian Cities
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
        return Padding(
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
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              Text(
                "Pilih Kota / Kabupaten",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Tersedia 500+ Kota & Kabupaten di seluruh Indonesia",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),

              const SizedBox(height: 14),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: _searchController,
                  autofocus: false,
                  onChanged: (val) {
                    setState(() {
                      _query = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Cari kota (contoh: Jakarta, Bandung, Surabaya)...",
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                    ),
                    prefixIcon: Icon(Icons.search_rounded, color: mainColor),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                        ),
                      )
                    : ListView.separated(
                        controller: scrollController,
                        itemCount: filtered.length,
                        separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF0F0F0)),
                        itemBuilder: (context, index) {
                          final kota = filtered[index];
                          final isSelected = widget.currentSelected?.id == kota.id;

                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            leading: Icon(
                              Icons.location_city_rounded,
                              color: isSelected ? mainColor : Colors.grey.shade400,
                              size: 20,
                            ),
                            title: Text(
                              kota.lokasi,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? mainColor : Colors.black87,
                              ),
                            ),
                            trailing: isSelected
                                ? Icon(Icons.check_circle_rounded, color: mainColor, size: 20)
                                : null,
                            onTap: () => widget.onSelect(kota),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
