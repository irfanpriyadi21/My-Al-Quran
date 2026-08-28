import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../Model/ModelListAyat.dart';
import '../../Provider/Surah/QuranAudioProvider.dart';
import '../../Provider/Surah/quran_settings_provider.dart';
import '../colors.dart';
import 'VerseSharedCard.dart';

class VerseTile extends StatefulWidget {
  final int number;
  final String arabic;
  final String translation;
  final String latin;
  final String audioUrl;
  final String surah;
  final int surahId;
  final int index;
  final List<Ayat> ayatList;

  const VerseTile({
    super.key,
    required this.number,
    required this.arabic,
    required this.translation,
    required this.latin,
    required this.audioUrl,
    required this.surah,
    this.surahId = 0,
    this.index = 0,
    this.ayatList = const [],
  });

  @override
  State<VerseTile> createState() => _VerseTileState();
}

class _VerseTileState extends State<VerseTile> {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> shareVerseAsImage() async {
    try {
      final image = await screenshotController.captureFromWidget(
        VerseShareCard(
          arabic: widget.arabic,
          latin: widget.latin,
          translation: widget.translation,
          number: widget.number,
          surah: widget.surah,
        ),
      );
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/verse_${widget.number}.png';
      final file = File(filePath);
      await file.writeAsBytes(image);

      await Share.shareXFiles([XFile(file.path)], text: widget.translation);
    } catch (e) {
      debugPrint("Error sharing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer2<QuranAudioProvider, QuranSettingsProvider>(
      builder: (context, audioProvider, quranSettings, child) {
        final isPlaying = audioProvider.isAyatPlaying(
          widget.surahId,
          widget.number,
        );
        final isActive = audioProvider.isAyatActive(
          widget.surahId,
          widget.number,
        );
        final isBuffering = isActive && audioProvider.isLoading;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isActive
                ? (isDark
                    ? mainColor.withOpacity(0.1)
                    : mainColor.withOpacity(0.04))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive
                  ? mainColor.withOpacity(0.5)
                  : (isDark
                      ? Colors.white.withOpacity(0.06)
                      : Colors.transparent),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP BAR
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? mainColor.withOpacity(0.15)
                      : (isDark
                          ? const Color(0xFF252525)
                          : Colors.grey[200]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: mainColor,
                      child: Text(
                        "${widget.number}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        // SHARE BUTTON
                        GestureDetector(
                          onTap: shareVerseAsImage,
                          child: const Icon(
                            Icons.share_outlined,
                            color: mainColor,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // PLAY / PAUSE BUTTON
                        GestureDetector(
                          onTap: () {
                            if (isActive) {
                              audioProvider.togglePlayPause();
                            } else {
                              audioProvider.playAyat(
                                surahId: widget.surahId,
                                surahName: widget.surah,
                                ayatList: widget.ayatList,
                                index: widget.index,
                              );
                            }
                          },
                          child: isBuffering
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    color: mainColor,
                                  ),
                                )
                              : Icon(
                                  isPlaying
                                      ? Icons.pause_circle_filled_rounded
                                      : (isActive
                                          ? Icons.play_circle_fill_rounded
                                          : Icons.play_arrow_outlined),
                                  color: mainColor,
                                  size: 24,
                                ),
                        ),

                        const SizedBox(width: 16),
                        const Icon(
                          Icons.bookmark_border,
                          color: mainColor,
                          size: 22,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ARABIC TEXT (Using selected font & size from QuranSettingsProvider)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.arabic,
                  textAlign: TextAlign.right,
                  style: quranSettings.getArabicTextStyle(
                    color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                  ),
                ),
              ),

              // LATIN TRANSLITERATION (Conditional based on user setting)
              if (quranSettings.showLatin) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.latin,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: isDark ? const Color(0xFFD0A8FF) : Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],

              // INDONESIAN TRANSLATION (Conditional based on user setting)
              if (quranSettings.showTranslation) ...[
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.translation,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: isDark ? Colors.white70 : Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 6),
            ],
          ),
        );
      },
    );
  }
}
