import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Provider/Shalat/AdzanAlarmService.dart';
import 'package:provider/provider.dart';

class AdzanPlayerDialog extends StatelessWidget {
  final String prayerName;
  final String prayerTime;

  const AdzanPlayerDialog({
    super.key,
    required this.prayerName,
    required this.prayerTime,
  });

  static void show(
    BuildContext context, {
    required String prayerName,
    required String prayerTime,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          AdzanPlayerDialog(prayerName: prayerName, prayerTime: prayerTime),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return Material(
      color: cardColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle Bar
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
              const SizedBox(height: 18),

              // Mosque Banner & Animation
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xffC58AF9), Color(0xff7B3FE4)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff7B3FE4).withOpacity(0.3),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.mosque_rounded,
                        size: 42,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Waktu Shalat $prayerName Telah Tiba",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Pukul $prayerTime WIB",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Soundwave / Playing indicator
                    Consumer<AdzanAlarmService>(
                      builder: (context, adzanService, child) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (adzanService.isLoading)
                                const SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              else
                                Icon(
                                  adzanService.isPlaying
                                      ? Icons.volume_up_rounded
                                      : Icons.volume_off_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              const SizedBox(width: 8),
                              Text(
                                adzanService.isLoading
                                    ? "Memuat Audio Adzan..."
                                    : (adzanService.isPlaying
                                        ? "Adzan Sedang Berkumandang..."
                                        : "Adzan Telah Selesai"),
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Controls: Stop Adzan Button
              Consumer<AdzanAlarmService>(
                builder: (context, adzanService, child) {
                  return Row(
                    children: [
                      if (adzanService.isPlaying || adzanService.isLoading)
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE53935),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              adzanService.stopAdzan();
                            },
                            icon: const Icon(Icons.stop_rounded),
                            label: Text(
                              "Hentikan Adzan",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: mainColor,
                              side: const BorderSide(color: mainColor),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              adzanService.playAdzan(prayerName: prayerName);
                            },
                            icon: const Icon(Icons.replay_rounded),
                            label: Text(
                              "Putar Ulang Adzan",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? const Color(0xFF2C2C2C)
                              : Colors.grey.shade200,
                          foregroundColor: isDark
                              ? Colors.white
                              : Colors.black87,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          adzanService.stopAdzan();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Tutup",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),

              // Doa Setelah Adzan Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF252136)
                      : const Color(0xFFF9F6FF),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: mainColor.withOpacity(isDark ? 0.3 : 0.15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 16,
                          color: mainColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Doa Setelah Adzan",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF240F4F),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Arabic
                    Text(
                      "اللَّهُمَّ رَبَّ هَذِهِ الدَّعْوَةِ التَّامَّةِ وَالصَّلَاةِ الْقَائِمَةِ، آتِ مُحَمَّدًا الْوَسِيلَةَ وَالْفَضِيلَةَ، وَابْعَثْهُ مَقَامًا مَحْمُودًا الَّذِي وَعَدْتَهُ",
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.amiri(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.9,
                        color: isDark ? Colors.white : const Color(0xFF240F4F),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Latin
                    Text(
                      "Allahumma Rabba hadzihid da'watit tammah, wash-shalaatil qaa-imah, aati Muhammadanil wasiilata wal fadhiilah, wab'atshu maqaamam mahmuudanilladzii wa'adtah.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: isDark ? const Color(0xFFD0A8FF) : mainColor,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Translation
                    Text(
                      "\"Ya Allah, Tuhan pemilik seruan yang sempurna dan shalat yang didirikan ini, berikanlah kepada Nabi Muhammad wasilah dan keutamaan, serta tempatkanlah beliau pada tempat terpuji yang telah Engkau janjikan.\"",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDark ? Colors.white70 : Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
