import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Page/AsmaulHusna/asmaul_husna_page.dart';
import 'package:my_quran/Page/Kalender/kalender_hijriah_page.dart';
import 'package:my_quran/Page/Profile/profile.dart';
import 'package:my_quran/Page/Quotes/quotes_islami_page.dart';
import 'package:my_quran/Page/Shalat/adzan_settings_modal.dart';
import 'package:my_quran/Page/Shalat/tuntunan_sholat_page.dart';
import 'package:my_quran/Page/Sholawat/sholawat_page.dart';
import 'package:my_quran/Page/Tajwid/tajwid_page.dart';
import 'package:my_quran/Page/YasinTahlil/yasin_tahlil_page.dart';

class MenuLainnyaModal extends StatelessWidget {
  const MenuLainnyaModal({super.key});

  static void show(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => const MenuLainnyaModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hijri = HijriCalendar.now();

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Header Title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: mainColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.grid_view_rounded,
                    color: mainColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Menu Lainnya",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      "Fitur tambahan & perlengkapan ibadah",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Hijri Calendar Quick Banner (Clickable)
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(18),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const KalenderHijriahPage()),
                  );
                },
                child: Ink(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB176F2), mainColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: mainColor.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
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
                                Text(
                                  "Kalender Hijriyah Hari Ini",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: Colors.white.withValues(alpha: 0.85),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white70,
                                  size: 14,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} H",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Feature Items List
            _buildFeatureTile(
              context: context,
              icon: Icons.calendar_month_rounded,
              iconColor: const Color(0xFF673AB7),
              title: "Kalender Hijriah",
              subtitle: "Kalender lengkap, hari besar Islam, & jadwal puasa",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KalenderHijriahPage()),
                );
              },
              isDark: isDark,
            ),

            const SizedBox(height: 10),

            _buildFeatureTile(
              context: context,
              icon: Icons.menu_book_rounded,
              iconColor: const Color(0xFF00897B),
              title: "Tuntunan Sholat",
              subtitle: "Panduan sholat fardhu, sunnah, wudhu, & dzikir",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TuntunanSholatPage()),
                );
              },
              isDark: isDark,
            ),

            const SizedBox(height: 10),

            _buildFeatureTile(
              context: context,
              icon: Icons.record_voice_over_rounded,
              iconColor: const Color(0xFF3F51B5),
              title: "Panduan Ilmu Tajwid",
              subtitle: "Hukum nun mati, mim, mad, qalqalah, & waqaf",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TajwidPage()),
                );
              },
              isDark: isDark,
            ),

            const SizedBox(height: 10),

            _buildFeatureTile(
              context: context,
              icon: Icons.book_outlined,
              iconColor: const Color(0xFFE91E63),
              title: "Yasin & Tahlil",
              subtitle: "Surat Yasin (83 ayat), susunan tahlil, & doa arwah",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const YasinTahlilPage()),
                );
              },
              isDark: isDark,
            ),

            const SizedBox(height: 10),

            _buildFeatureTile(
              context: context,
              icon: Icons.favorite_rounded,
              iconColor: const Color(0xFFFF5722),
              title: "Kumpulan Shalawat",
              subtitle: "Nariyah, Thibbil Qulub, Munjiyat, Jibril, Fatih, dll",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SholawatPage()),
                );
              },
              isDark: isDark,
            ),

            const SizedBox(height: 10),

            _buildFeatureTile(
              context: context,
              icon: Icons.format_quote_rounded,
              iconColor: const Color(0xFF8E24AA),
              title: "Kata-Kata Mutiara Islami",
              subtitle: "Quotes bijak, motivasi hijrah, & mutiara sahabat nabi",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuotesIslamiPage()),
                );
              },
              isDark: isDark,
            ),

            const SizedBox(height: 10),

            _buildFeatureTile(
              context: context,
              icon: Icons.notifications_active_rounded,
              iconColor: const Color(0xFFFF9800),
              title: "Pengaturan Notifikasi Adzan",
              subtitle: "Atur alarm waktu shalat 5 waktu & suara adzan",
              onTap: () {
                Navigator.pop(context);
                AdzanSettingsModal.show(context);
              },
              isDark: isDark,
            ),

            const SizedBox(height: 10),

            _buildFeatureTile(
              context: context,
              icon: Icons.auto_stories_rounded,
              iconColor: const Color(0xFF00C853),
              title: "99 Asmaul Husna",
              subtitle: "Lengkap 99 nama Allah, terjemahan, & dzikir",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AsmaulHusnaPage()),
                );
              },
              isDark: isDark,
            ),

            const SizedBox(height: 10),

            _buildFeatureTile(
              context: context,
              icon: Icons.calculate_rounded,
              iconColor: const Color(0xFF00B0FF),
              title: "Kalkulator Zakat",
              subtitle: "Hitung zakat maal, emas, & penghasilan",
              onTap: () {
                Navigator.pop(context);
                _showZakatCalculatorModal(context);
              },
              isDark: isDark,
            ),

            const SizedBox(height: 10),

            _buildFeatureTile(
              context: context,
              icon: Icons.person_rounded,
              iconColor: const Color(0xFF9C27B0),
              title: "Profil & Pengaturan",
              subtitle: "Kelola akun, mode tema, & kebijakan privasi",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    final cardBg = isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA);

    return Material(
      color: cardBg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: isDark ? Colors.white60 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: isDark ? Colors.white38 : Colors.grey.shade400,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Zakat Calculator Simple Modal ---
  void _showZakatCalculatorModal(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        double totalZakat = 0;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
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
                    "Kalkulator Zakat Maal (2.5%)",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Nisab zakat setara 85 gram emas per tahun.",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: isDark ? Colors.white60 : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      labelText: "Total Harta / Simpanan (Rp)",
                      labelStyle: GoogleFonts.poppins(fontSize: 12),
                      prefixText: "Rp ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (val) {
                      final amount = double.tryParse(val.replaceAll('.', '').replaceAll(',', '')) ?? 0;
                      setModalState(() {
                        totalZakat = amount * 0.025;
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Kewajiban Zakat (2.5%):",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: isDark ? Colors.white70 : Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          "Rp ${totalZakat.toStringAsFixed(0)}",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
