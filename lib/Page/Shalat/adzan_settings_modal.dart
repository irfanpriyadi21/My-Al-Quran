import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Provider/Shalat/AdzanAlarmService.dart';
import 'package:provider/provider.dart';

class AdzanSettingsModal extends StatelessWidget {
  const AdzanSettingsModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AdzanSettingsModal(),
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
        child: Consumer<AdzanAlarmService>(
          builder: (context, adzanService, child) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle Bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pengaturan Alarm Adzan",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: isDark ? Colors.white60 : Colors.grey,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Master Switch Card
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF282438)
                          : const Color(0xFFF9F6FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: mainColor.withOpacity(isDark ? 0.3 : 0.15),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: mainColor.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_active_rounded,
                            color: mainColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Aktifkan Semua Alarm",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              Text(
                                "Bunyikan adzan saat waktu shalat",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch.adaptive(
                          value: adzanService.isMasterAlarmEnabled,
                          activeTrackColor: mainColor,
                          onChanged: (val) {
                            adzanService.toggleMasterAlarm(val);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Audio Selection Header
                  Text(
                    "Pilihan Suara Adzan",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Audio Options
                  ...AdzanAlarmService.adzanOptions.map((option) {
                    final isSelected =
                        option.id == adzanService.selectedAdzanId;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: isSelected
                            ? mainColor.withOpacity(isDark ? 0.18 : 0.08)
                            : (isDark
                                  ? const Color(0xFF242424)
                                  : const Color(0xFFF7F8FA)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                            color: isSelected ? mainColor : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 2,
                          ),
                          tileColor: Colors.transparent,
                          leading: Icon(
                            isSelected
                                ? Icons.radio_button_checked_rounded
                                : Icons.radio_button_off_rounded,
                            color: isSelected ? mainColor : Colors.grey,
                          ),
                          title: Text(
                            option.name,
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
                          subtitle: Text(
                            option.description,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                          onTap: () {
                            adzanService.selectAdzanAudio(option.id);
                          },
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 14),

                  // Test Audio Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: adzanService.isPlaying
                            ? const Color(0xFFE53935)
                            : mainColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: adzanService.isLoading
                          ? null
                          : () {
                              if (adzanService.isPlaying) {
                                adzanService.stopAdzan();
                              } else {
                                adzanService.playAdzan(
                                  prayerName: "Uji Coba Suara",
                                );
                              }
                            },
                      icon: adzanService.isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.2,
                                color: Colors.white,
                              ),
                            )
                          : Icon(
                              adzanService.isPlaying
                                  ? Icons.stop_rounded
                                  : Icons.volume_up_rounded,
                            ),
                      label: Text(
                        adzanService.isLoading
                            ? "Memuat Audio Adzan..."
                            : (adzanService.isPlaying
                                  ? "Hentikan Uji Coba Suara"
                                  : "Uji Coba Suara Adzan"),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Alarm per-Waktu Shalat Section
                  Text(
                    "Alarm per Waktu Shalat",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: adzanService.prayerAlarms.keys.map((prayer) {
                      final isActive = adzanService.isAlarmActiveFor(prayer);
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          adzanService.togglePrayerAlarm(prayer);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? mainColor.withOpacity(isDark ? 0.22 : 0.1)
                                : (isDark
                                      ? const Color(0xFF242424)
                                      : Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isActive ? mainColor : Colors.transparent,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isActive
                                    ? Icons.notifications_active_rounded
                                    : Icons.notifications_off_outlined,
                                size: 16,
                                color: isActive ? mainColor : Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                prayer,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: isActive
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: isActive
                                      ? mainColor
                                      : (isDark
                                            ? Colors.white70
                                            : Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
