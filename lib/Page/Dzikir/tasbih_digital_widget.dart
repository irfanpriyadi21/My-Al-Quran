import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/model_dzikir.dart';
import 'package:my_quran/Page/Dzikir/dzikir_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbihDigitalWidget extends StatefulWidget {
  const TasbihDigitalWidget({super.key});

  @override
  State<TasbihDigitalWidget> createState() => _TasbihDigitalWidgetState();
}

class _TasbihDigitalWidgetState extends State<TasbihDigitalWidget>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  int _target = 33; // 0 means unlimited
  int _totalAllTime = 0;
  bool _isVibrate = true;

  late ModelTasbihPreset _selectedPreset;
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _selectedPreset = DzikirData.listTasbihPreset.first;
    _target = _selectedPreset.defaultTarget;

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _totalAllTime = prefs.getInt('tasbih_total_count') ?? 0;
      _counter = prefs.getInt('tasbih_current_counter') ?? 0;
      _isVibrate = prefs.getBool('tasbih_vibrate') ?? true;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tasbih_total_count', _totalAllTime);
    await prefs.setInt('tasbih_current_counter', _counter);
    await prefs.setBool('tasbih_vibrate', _isVibrate);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _increment() {
    _animController.forward().then((_) => _animController.reverse());

    if (_isVibrate) {
      HapticFeedback.lightImpact();
    }

    setState(() {
      _counter++;
      _totalAllTime++;
    });

    _savePreferences();

    // Check if target reached
    if (_target > 0 && _counter == _target) {
      if (_isVibrate) {
        HapticFeedback.mediumImpact();
        Future.delayed(const Duration(milliseconds: 150), () {
          HapticFeedback.heavyImpact();
        });
      }
      _showTargetReachedDialog();
    }
  }

  void _showTargetReachedDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(Icons.stars_rounded, color: Color(0xFF00C853), size: 28),
              const SizedBox(width: 8),
              Text(
                "Target Tercapai!",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          content: Text(
            "Alhamdulillah, Anda telah menyelesaikan $_target bacaan ${_selectedPreset.title}.",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _resetCounter(askConfirm: false);
              },
              child: const Text("Ulangi (Reset Sesi)"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Lanjutkan"),
            ),
          ],
        );
      },
    );
  }

  void _resetCounter({bool askConfirm = true}) {
    if (!askConfirm) {
      setState(() {
        _counter = 0;
      });
      _savePreferences();
      return;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Reset Hitungan",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pilih jenis hitungan yang ingin Anda reset ke angka 0:",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hitungan Sesi Saat Ini:",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                    ),
                    Text(
                      "$_counter",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Keseluruhan Dzikir:",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                    ),
                    Text(
                      "$_totalAllTime",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF00C853),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Batal",
                style: TextStyle(color: isDark ? Colors.white60 : Colors.grey),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: mainColor,
                side: const BorderSide(color: mainColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _counter = 0;
                });
                _savePreferences();
              },
              child: const Text("Reset Sesi Ini"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _counter = 0;
                  _totalAllTime = 0;
                });
                _savePreferences();
              },
              child: const Text("Reset Semua"),
            ),
          ],
        );
      },
    );
  }

  void _resetTotalOnly() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Reset Total Keseluruhan?",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          content: Text(
            "Total riwayat keseluruhan dzikir ($_totalAllTime) akan direset ke angka 0.",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Batal",
                style: TextStyle(color: isDark ? Colors.white60 : Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _totalAllTime = 0;
                });
                _savePreferences();
              },
              child: const Text("Reset Total"),
            ),
          ],
        );
      },
    );
  }

  void _showPresetSelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                "Pilih Lafadz Dzikir",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: DzikirData.listTasbihPreset.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: isDark ? Colors.white12 : const Color(0xFFF0F0F0),
                  ),
                  itemBuilder: (context, index) {
                    final item = DzikirData.listTasbihPreset[index];
                    final isSelected = item.id == _selectedPreset.id;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      title: Text(
                        item.title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? mainColor : (isDark ? Colors.white : Colors.black87),
                        ),
                      ),
                      subtitle: Text(
                        item.latin,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                      ),
                      trailing: Text(
                        item.arabic,
                        style: GoogleFonts.amiri(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? mainColor : (isDark ? Colors.white70 : const Color(0xFF240F4F)),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedPreset = item;
                          _target = item.defaultTarget;
                          _counter = 0;
                        });
                        Navigator.pop(context);
                      },
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    final double progress = (_target > 0) ? (_counter / _target).clamp(0.0, 1.0) : 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        children: [
          // 1. Top Card: Selected Dzikir Readout
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black.withOpacity(0.25) : Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: mainColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _selectedPreset.title,
                        style: GoogleFonts.poppins(
                          color: mainColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _showPresetSelector,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF7F8FA),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: mainColor.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.swap_horiz_rounded, size: 14, color: mainColor),
                            const SizedBox(width: 4),
                            Text(
                              "Ganti",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Arabic Text
                Text(
                  _selectedPreset.arabic,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.amiri(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF240F4F),
                    height: 1.8,
                  ),
                ),
                const SizedBox(height: 6),

                // Latin & Meaning
                Text(
                  _selectedPreset.latin,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: isDark ? const Color(0xFFD0A8FF) : mainColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "\"${_selectedPreset.translation}\"",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 2. Control Bar: Target Switcher, Vibration Toggle, & Reset
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Target Selector Chips
              Row(
                children: [33, 99, 100, 0].map((t) {
                  final isSelected = _target == t;
                  final label = t == 0 ? "∞" : "$t";
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _target = t;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? mainColor
                            : (isDark ? const Color(0xFF242424) : Colors.white),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? mainColor : (isDark ? Colors.white12 : Colors.grey.shade300),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Action Buttons: Vibrate Toggle & Reset
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _isVibrate ? Icons.vibration_rounded : Icons.smartphone_rounded,
                      color: _isVibrate ? mainColor : Colors.grey,
                      size: 22,
                    ),
                    tooltip: _isVibrate ? "Getar Aktif" : "Getar Nonaktif",
                    onPressed: () {
                      setState(() {
                        _isVibrate = !_isVibrate;
                      });
                      _savePreferences();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh_rounded, color: Color(0xFFE53935), size: 22),
                    tooltip: "Reset Hitungan",
                    onPressed: () => _resetCounter(askConfirm: true),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // 3. Huge Interactive Tap Counter Ring
          GestureDetector(
            onTap: _increment,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withOpacity(isDark ? 0.25 : 0.18),
                      blurRadius: 28,
                      spreadRadius: 6,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular Progress Ring
                    SizedBox(
                      width: 230,
                      height: 230,
                      child: CircularProgressIndicator(
                        value: _target > 0 ? progress : 1.0,
                        strokeWidth: 8,
                        backgroundColor: isDark
                            ? const Color(0xFF2C2C2C)
                            : const Color(0xFFEDE7F6),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _target > 0 && progress >= 1.0
                              ? const Color(0xFF00C853)
                              : mainColor,
                        ),
                      ),
                    ),

                    // Counter Text & Tap Prompt
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$_counter",
                          style: GoogleFonts.poppins(
                            fontSize: 54,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                            height: 1.1,
                          ),
                        ),
                        if (_target > 0)
                          Text(
                            "dari $_target",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: isDark ? Colors.white60 : Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        else
                          Text(
                            "Tanpa Batas",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: isDark ? Colors.white60 : Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color: mainColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.touch_app_rounded, size: 14, color: mainColor),
                              const SizedBox(width: 4),
                              Text(
                                "Ketuk Layar",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // 4. Lifetime Total Session Counter with dedicated reset
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black.withOpacity(0.2) : Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.history_rounded, size: 20, color: mainColor),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Keseluruhan Dzikir",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: isDark ? Colors.white70 : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Tersimpan di perangkat",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: isDark ? Colors.white38 : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "$_totalAllTime",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_totalAllTime > 0)
                      InkWell(
                        onTap: _resetTotalOnly,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE53935).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.restart_alt_rounded,
                            color: Color(0xFFE53935),
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
