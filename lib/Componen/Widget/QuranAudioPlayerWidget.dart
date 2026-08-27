import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Model/ModelListAyat.dart';
import '../../Provider/Surah/QuranAudioProvider.dart';
import '../colors.dart';

class QuranAudioPlayerWidget extends StatelessWidget {
  const QuranAudioPlayerWidget({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void _showFullPlayerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const QuranAudioFullSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return Consumer<QuranAudioProvider>(
      builder: (context, audioProvider, child) {
        if (!audioProvider.isPlayerVisible ||
            audioProvider.currentAyat == null) {
          return const SizedBox.shrink();
        }

        final currentAyat = audioProvider.currentAyat!;
        final position = audioProvider.position;
        final duration = audioProvider.duration;

        double progress = 0.0;
        if (duration.inMilliseconds > 0) {
          progress = (position.inMilliseconds / duration.inMilliseconds).clamp(
            0.0,
            1.0,
          );
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: mainColor.withOpacity(isDark ? 0.25 : 0.18),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: mainColor.withOpacity(isDark ? 0.35 : 0.2),
              width: 1.2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // MINI PROGRESS BAR
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: isDark
                      ? const Color(0xFF2C2C2C)
                      : Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(mainColor),
                  minHeight: 3.5,
                ),

                // PLAYER BODY
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      // PLAY / PAUSE / BUFFERING BUTTON
                      GestureDetector(
                        onTap: () => audioProvider.togglePlayPause(),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xffC58AF9), Color(0xff7B3FE4)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: mainColor.withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: audioProvider.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.2,
                                    ),
                                  )
                                : Icon(
                                    audioProvider.isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // SURAH & AYAT INFO (TAP TO OPEN FULL SHEET)
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _showFullPlayerSheet(context),
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      "QS. ${audioProvider.currentSurahName} : ${currentAyat.nomorAyat}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF2D2D2D),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: mainColor.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      "${audioProvider.playbackSpeed}x",
                                      style: GoogleFonts.poppins(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? const Color(0xFFD0A8FF)
                                            : mainColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      audioProvider.selectedQoriName,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${_formatDuration(position)} / ${_formatDuration(duration)}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: isDark
                                          ? Colors.white54
                                          : Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // PREVIOUS BUTTON
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.skip_previous_rounded,
                          color: audioProvider.hasPrevious
                              ? mainColor
                              : (isDark
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade400),
                          size: 24,
                        ),
                        onPressed: audioProvider.hasPrevious
                            ? () => audioProvider.previousAyat()
                            : null,
                      ),

                      // NEXT BUTTON
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.skip_next_rounded,
                          color: audioProvider.hasNext
                              ? mainColor
                              : (isDark
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade400),
                          size: 24,
                        ),
                        onPressed: audioProvider.hasNext
                            ? () => audioProvider.nextAyat()
                            : null,
                      ),

                      // EXPAND FULL SHEET
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          color: mainColor,
                          size: 24,
                        ),
                        onPressed: () => _showFullPlayerSheet(context),
                      ),

                      // CLOSE / STOP BUTTON
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.close_rounded,
                          color: isDark ? Colors.white70 : Colors.grey.shade500,
                          size: 20,
                        ),
                        onPressed: () => audioProvider.closePlayer(),
                      ),
                    ],
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

// FULL PLAYER BOTTOM SHEET
class QuranAudioFullSheet extends StatelessWidget {
  const QuranAudioFullSheet({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<QuranAudioProvider>(
      builder: (context, audioProvider, child) {
        final currentAyat = audioProvider.currentAyat;
        if (currentAyat == null) {
          return const SizedBox.shrink();
        }

        final position = audioProvider.position;
        final duration = audioProvider.duration;

        double sliderValue = position.inMilliseconds.toDouble();
        double maxSliderValue = duration.inMilliseconds > 0
            ? duration.inMilliseconds.toDouble()
            : 1.0;
        if (sliderValue > maxSliderValue) {
          sliderValue = maxSliderValue;
        }

        return Material(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.78,
            child: Column(
              children: [
                // DRAG HANDLE
                const SizedBox(height: 12),
                Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 28,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        "Pemutar Audio Ayat",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          size: 24,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        onPressed: () {
                          audioProvider.closePlayer();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),

                Divider(
                  height: 1,
                  color: isDark ? Colors.white12 : Colors.grey.shade200,
                ),

                // SCROLLABLE CONTENT
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Column(
                      children: [
                        // SURAH & AYAT HERO CARD
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                              colors: [Color(0xffC58AF9), Color(0xff7B3FE4)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: mainColor.withOpacity(0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Surat ${audioProvider.currentSurahName}",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Ayat Ke-${currentAyat.nomorAyat}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              // ARABIC TEXT SNIPPET
                              Text(
                                currentAyat.teksArab ?? '',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.amiri(
                                  fontSize: 24,
                                  height: 1.8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              // TRANSLATION SNIPPET
                              Text(
                                currentAyat.teksIndonesia ?? '',
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // EQUALIZER / WAVE ANIMATION INDICATOR
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildWaveBar(
                              audioProvider.isPlaying,
                              16,
                              200,
                              isDark,
                            ),
                            const SizedBox(width: 4),
                            _buildWaveBar(
                              audioProvider.isPlaying,
                              28,
                              400,
                              isDark,
                            ),
                            const SizedBox(width: 4),
                            _buildWaveBar(
                              audioProvider.isPlaying,
                              20,
                              150,
                              isDark,
                            ),
                            const SizedBox(width: 4),
                            _buildWaveBar(
                              audioProvider.isPlaying,
                              34,
                              500,
                              isDark,
                            ),
                            const SizedBox(width: 4),
                            _buildWaveBar(
                              audioProvider.isPlaying,
                              18,
                              300,
                              isDark,
                            ),
                            const SizedBox(width: 4),
                            _buildWaveBar(
                              audioProvider.isPlaying,
                              26,
                              250,
                              isDark,
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // DURATION SLIDER
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 7,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 14,
                            ),
                            activeTrackColor: mainColor,
                            inactiveTrackColor: isDark
                                ? const Color(0xFF2C2C2C)
                                : Colors.grey.shade200,
                            thumbColor: mainColor,
                          ),
                          child: Slider(
                            value: sliderValue,
                            min: 0.0,
                            max: maxSliderValue,
                            onChanged: (value) {
                              audioProvider.seek(
                                Duration(milliseconds: value.toInt()),
                              );
                            },
                          ),
                        ),

                        // TIME LABELS
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(position),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                _formatDuration(duration),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // PLAYBACK CONTROLS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // AUTO PLAY NEXT TOGGLE
                            IconButton(
                              icon: Icon(
                                audioProvider.autoPlayNext
                                    ? Icons.repeat_one_on_rounded
                                    : Icons.repeat_rounded,
                                color: audioProvider.autoPlayNext
                                    ? mainColor
                                    : (isDark
                                          ? Colors.grey.shade600
                                          : Colors.grey.shade400),
                                size: 26,
                              ),
                              tooltip: "Auto-play ayat berikutnya",
                              onPressed: () => audioProvider.toggleAutoPlay(),
                            ),

                            // PREVIOUS BUTTON
                            IconButton(
                              icon: Icon(
                                Icons.skip_previous_rounded,
                                color: audioProvider.hasPrevious
                                    ? mainColor
                                    : (isDark
                                          ? Colors.grey.shade700
                                          : Colors.grey.shade300),
                                size: 38,
                              ),
                              onPressed: audioProvider.hasPrevious
                                  ? () => audioProvider.previousAyat()
                                  : null,
                            ),

                            // PLAY / PAUSE / BUFFERING MAIN BUTTON
                            GestureDetector(
                              onTap: () => audioProvider.togglePlayPause(),
                              child: Container(
                                width: 68,
                                height: 68,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xffC58AF9),
                                      Color(0xff7B3FE4),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: mainColor.withOpacity(0.4),
                                      blurRadius: 14,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: audioProvider.isLoading
                                      ? const SizedBox(
                                          width: 28,
                                          height: 28,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : Icon(
                                          audioProvider.isPlaying
                                              ? Icons.pause_rounded
                                              : Icons.play_arrow_rounded,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                ),
                              ),
                            ),

                            // NEXT BUTTON
                            IconButton(
                              icon: Icon(
                                Icons.skip_next_rounded,
                                color: audioProvider.hasNext
                                    ? mainColor
                                    : (isDark
                                          ? Colors.grey.shade700
                                          : Colors.grey.shade300),
                                size: 38,
                              ),
                              onPressed: audioProvider.hasNext
                                  ? () => audioProvider.nextAyat()
                                  : null,
                            ),

                            // SPEED SELECTOR
                            PopupMenuButton<double>(
                              initialValue: audioProvider.playbackSpeed,
                              tooltip: "Kecepatan audio",
                              onSelected: (speed) =>
                                  audioProvider.setPlaybackSpeed(speed),
                              icon: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: mainColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "${audioProvider.playbackSpeed}x",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? const Color(0xFFD0A8FF)
                                        : mainColor,
                                  ),
                                ),
                              ),
                              itemBuilder: (context) =>
                                  [0.75, 1.0, 1.25, 1.5, 2.0].map((speed) {
                                    return PopupMenuItem<double>(
                                      value: speed,
                                      child: Text("${speed}x"),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // QORI / RECITER SELECTION
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pilihan Qori / Pelafal:",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF333333),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // QORI CHIPS
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: audioProvider.qoriList.entries.map((entry) {
                            final isSelected =
                                audioProvider.selectedQori == entry.key;
                            return ChoiceChip(
                              label: Text(entry.value),
                              selected: isSelected,
                              selectedColor: mainColor,
                              backgroundColor: isDark
                                  ? const Color(0xFF2C2C2C)
                                  : Colors.grey.shade100,
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark
                                          ? Colors.white70
                                          : Colors.black87),
                              ),
                              side: BorderSide(
                                color: isSelected
                                    ? mainColor
                                    : (isDark
                                          ? Colors.grey.shade700
                                          : Colors.grey.shade300),
                              ),
                              onSelected: (selected) {
                                if (selected) {
                                  audioProvider.setQori(entry.key);
                                }
                              },
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWaveBar(
    bool isPlaying,
    double height,
    int durationMs,
    bool isDark,
  ) {
    return AnimatedContainer(
      duration: Duration(milliseconds: durationMs),
      width: 4,
      height: isPlaying ? height : 6,
      decoration: BoxDecoration(
        color: isPlaying
            ? mainColor
            : (isDark ? Colors.grey.shade800 : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
