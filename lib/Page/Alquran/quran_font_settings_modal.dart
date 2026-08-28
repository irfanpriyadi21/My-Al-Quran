import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Provider/Surah/quran_settings_provider.dart';
import 'package:provider/provider.dart';

class QuranFontSettingsModal extends StatelessWidget {
  const QuranFontSettingsModal({super.key});

  static void show(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => const QuranFontSettingsModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA);

    return Consumer<QuranSettingsProvider>(
      builder: (context, settings, _) {
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
                // Handle
                Center(
                  child: Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color:
                          isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: mainColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.font_download_rounded,
                            color: mainColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pengaturan Teks Arab",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              "Pilih jenis & ukuran font Al-Qur'an",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: isDark
                                    ? Colors.white60
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        settings.setFontFamily('Amiri');
                        settings.setFontSize(26.0);
                        settings.toggleShowLatin(true);
                        settings.toggleShowTranslation(true);
                      },
                      child: Text(
                        "Reset",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: mainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Live Preview Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: mainColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Pratinjau Teks (Live Preview)",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white60 : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                        textAlign: TextAlign.center,
                        style: settings.getArabicTextStyle(
                          color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                        ),
                      ),
                      if (settings.showLatin) ...[
                        const SizedBox(height: 8),
                        Text(
                          "Bismillāhir-raḥmānir-raḥīm",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: isDark
                                ? const Color(0xFFD0A8FF)
                                : mainColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      if (settings.showTranslation) ...[
                        const SizedBox(height: 4),
                        Text(
                          "\"Dengan nama Allah Yang Maha Pengasih, Maha Penyayang.\"",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: isDark
                                ? Colors.white70
                                : Colors.grey.shade700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Section 1: Font Family Selector
                Text(
                  "Jenis Font Arab",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),

                ...QuranSettingsProvider.availableFonts.map((font) {
                  final isSelected = settings.arabicFontFamily == font['id'];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Material(
                      color: isSelected
                          ? mainColor.withOpacity(0.12)
                          : cardBg,
                      borderRadius: BorderRadius.circular(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: isSelected
                              ? mainColor
                              : (isDark
                                  ? Colors.white10
                                  : Colors.transparent),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () => settings.setFontFamily(font['id']!),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              // Radio Indicator
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? mainColor
                                        : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: mainColor,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              // Name and description
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      font['name']!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w600,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      font['desc']!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: isDark
                                            ? Colors.white60
                                            : Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Sample text rendered in this specific font
                              Text(
                                "القرآن",
                                style: _getSampleTextStyle(
                                  font['id']!,
                                  isSelected
                                      ? mainColor
                                      : (isDark
                                          ? Colors.white70
                                          : Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 16),

                // Section 2: Font Size Slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ukuran Tulisan Arab",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: mainColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "${settings.arabicFontSize.round()} pt",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.text_decrease_rounded, size: 20),
                      color: mainColor,
                      tooltip: "Perkecil",
                      onPressed: settings.arabicFontSize > 20.0
                          ? () => settings.setFontSize(settings.arabicFontSize - 2)
                          : null,
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: mainColor,
                          inactiveTrackColor: mainColor.withOpacity(0.15),
                          thumbColor: mainColor,
                          overlayColor: mainColor.withOpacity(0.1),
                          trackHeight: 4,
                        ),
                        child: Slider(
                          value: settings.arabicFontSize,
                          min: 20.0,
                          max: 38.0,
                          divisions: 9,
                          onChanged: (val) => settings.setFontSize(val),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.text_increase_rounded, size: 20),
                      color: mainColor,
                      tooltip: "Perbesar",
                      onPressed: settings.arabicFontSize < 38.0
                          ? () => settings.setFontSize(settings.arabicFontSize + 2)
                          : null,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Section 3: Display Toggles
                Text(
                  "Tampilan Ayat",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                Material(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: settings.showLatin,
                        activeThumbColor: mainColor,
                        tileColor: Colors.transparent,
                        title: Text(
                          "Teks Latin (Transliterasi)",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          "Panduan bacaan huruf latin",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: isDark
                                ? Colors.white60
                                : Colors.grey.shade600,
                          ),
                        ),
                        onChanged: (val) => settings.toggleShowLatin(val),
                      ),
                      Divider(
                        height: 1,
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                      ),
                      SwitchListTile(
                        value: settings.showTranslation,
                        activeThumbColor: mainColor,
                        tileColor: Colors.transparent,
                        title: Text(
                          "Terjemahan Bahasa Indonesia",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          "Arti ayat dalam bahasa Indonesia",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: isDark
                                ? Colors.white60
                                : Colors.grey.shade600,
                          ),
                        ),
                        onChanged: (val) => settings.toggleShowTranslation(val),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Close Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      "Selesai & Simpan",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

  TextStyle _getSampleTextStyle(String fontId, Color color) {
    switch (fontId) {
      case 'Scheherazade New':
        return GoogleFonts.scheherazadeNew(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: color,
        );
      case 'Noto Naskh Arabic':
        return GoogleFonts.notoNaskhArabic(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        );
      case 'Lateef':
        return GoogleFonts.lateef(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: color,
        );
      case 'Cairo':
        return GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        );
      case 'Amiri':
      default:
        return GoogleFonts.amiri(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: color,
        );
    }
  }
}
