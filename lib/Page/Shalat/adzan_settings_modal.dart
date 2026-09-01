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
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;
    final bottomInset = mediaQuery.viewInsets.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            bottomPadding + bottomInset + 12,
          ),
          child: Consumer<AdzanAlarmService>(
            builder: (context, adzanService, child) {
              return Column(
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
                  const SizedBox(height: 14),

                  // Title Header (Pinned at top)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Pengaturan Alarm Adzan",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                  const SizedBox(height: 8),

                  // Scrollable Body
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Master Switch Card
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF282438)
                                  : const Color(0xFFF9F6FF),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: mainColor.withValues(
                                  alpha: isDark ? 0.3 : 0.15,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: mainColor.withValues(alpha: 0.15),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Aktifkan Semua Alarm",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black87,
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

                          const SizedBox(height: 10),

                          // Vibration Switch Card
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF242424)
                                  : const Color(0xFFF7F8FA),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark
                                    ? Colors.white10
                                    : Colors.grey.shade200,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF00C853,
                                    ).withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.vibration_rounded,
                                    color: Color(0xFF00C853),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Getar Saat Adzan",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        "Perangkat bergetar saat adzan berkumandang",
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
                                  value: adzanService.isVibrationEnabled,
                                  activeTrackColor: const Color(0xFF00C853),
                                  onChanged: (val) {
                                    adzanService.toggleVibration(val);
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18),

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

                          // Audio Options List
                          ...AdzanAlarmService.adzanOptions.map((option) {
                            final isSelected =
                                option.id == adzanService.selectedAdzanId;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Material(
                                color: isSelected
                                    ? mainColor.withValues(
                                        alpha: isDark ? 0.18 : 0.08,
                                      )
                                    : (isDark
                                          ? const Color(0xFF242424)
                                          : const Color(0xFFF7F8FA)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  side: BorderSide(
                                    color: isSelected
                                        ? mainColor
                                        : Colors.transparent,
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
                                          : (isDark
                                                ? Colors.white
                                                : Colors.black87),
                                    ),
                                  ),
                                  subtitle: Text(
                                    option.description,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: isDark
                                          ? Colors.white60
                                          : Colors.black54,
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

                          // Test Buttons Section (Vertical Stack to guarantee zero overflow on any screen width)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: adzanService.isPlaying
                                    ? const Color(0xFFE53935)
                                    : mainColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                ),
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
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Icon(
                                      adzanService.isPlaying
                                          ? Icons.stop_rounded
                                          : Icons.volume_up_rounded,
                                      size: 18,
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

                          const SizedBox(height: 10),

                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF00C853),
                                side: const BorderSide(
                                  color: Color(0xFF00C853),
                                  width: 1.5,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () async {
                                await adzanService.testAlarmNotification();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Notifikasi uji coba alarm & getaran telah dikirim!",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                        ),
                                      ),
                                      backgroundColor: const Color(0xFF00C853),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.vibration_rounded,
                                size: 18,
                              ),
                              label: Text(
                                "Uji Coba Alarm & Getaran Notifikasi",
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
                            children: adzanService.prayerAlarms.keys.map((
                              prayer,
                            ) {
                              final isActive = adzanService.isAlarmActiveFor(
                                prayer,
                              );
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
                                        ? mainColor.withValues(
                                            alpha: isDark ? 0.22 : 0.1,
                                          )
                                        : (isDark
                                              ? const Color(0xFF242424)
                                              : Colors.grey.shade100),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isActive
                                          ? mainColor
                                          : Colors.transparent,
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
                                        color: isActive
                                            ? mainColor
                                            : Colors.grey,
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

                          const SizedBox(height: 20),

                          // Tips Android Settings Info Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1E1C2B)
                                  : const Color(0xFFF3EFFF),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: mainColor.withValues(
                                  alpha: isDark ? 0.3 : 0.2,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.lightbulb_rounded,
                                      color: Color(0xFFFFB300),
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Tips Agar Alarm Selalu Bunyi Tepat Waktu",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? Colors.white
                                              : const Color(0xFF240F4F),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "• Pastikan volume Alarm & Notifikasi HP aktif serta tidak dalam mode Hening.\n"
                                  "• Beri izin 'Alarm & Pengingat' (Alarms & Reminders) di Pengaturan Aplikasi.\n"
                                  "• Nonaktifkan 'Penghemat Baterai' untuk aplikasi My Al-Quran agar sistem Android tidak menonaktifkan alarm di latar belakang.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                    height: 1.45,
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

