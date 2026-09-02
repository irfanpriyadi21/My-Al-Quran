import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../../Componen/colors.dart';

class SurahInfoModal extends StatelessWidget {
  final int surahNumber;
  final String arabicName;
  final String latinName;
  final String translation;
  final String revelationPlace;
  final String verseCount;
  final String? description;

  const SurahInfoModal({
    super.key,
    required this.surahNumber,
    required this.arabicName,
    required this.latinName,
    required this.translation,
    required this.revelationPlace,
    required this.verseCount,
    this.description,
  });

  static void show(
    BuildContext context, {
    required int surahNumber,
    required String arabicName,
    required String latinName,
    required String translation,
    required String revelationPlace,
    required String verseCount,
    String? description,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (ctx) => SurahInfoModal(
        surahNumber: surahNumber,
        arabicName: arabicName,
        latinName: latinName,
        translation: translation,
        revelationPlace: revelationPlace,
        verseCount: verseCount,
        description: description,
      ),
    );
  }

  void _shareSurahInfo() {
    final cleanDesc = description != null
        ? description!
            .replaceAll(RegExp(r'<[^>]*>'), '')
            .replaceAll('&quot;', '"')
            .replaceAll('&amp;', '&')
            .replaceAll('&rsquo;', "'")
            .replaceAll('&lsquo;', "'")
        : '';

    final text = '''
📖 *INFO SURAH: $latinName ($arabicName)*
━━━━━━━━━━━━━━━━━━━━
• Nomor Surah : Ke-$surahNumber
• Arti Nama   : $translation
• Golongan    : $revelationPlace
• Jumlah Ayat : $verseCount Ayat

📝 *Deskripsi & Pokok Kandungan:*
$cleanDesc

Dibagikan via aplikasi *My Al-Quran* 🌙
''';

    Share.share(text.trim(), subject: "Info Surah $latinName");
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMakkiyyah = revelationPlace.toLowerCase().contains('mekah') ||
        revelationPlace.toLowerCase().contains('makki');

    return DraggableScrollableSheet(
      initialChildSize: 0.72,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            controller: scrollController,
            children: [
              const SizedBox(height: 12),
              // Top drag indicator
              Center(
                child: Container(
                  width: 44,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Modal Title Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: mainColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.info_outline_rounded,
                          color: mainColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Info & Deskripsi Surah",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            "QS. $latinName : Surah ke-$surahNumber",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: isDark ? Colors.white60 : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_outlined, color: mainColor, size: 22),
                    tooltip: "Bagikan Info Surah",
                    onPressed: _shareSurahInfo,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Surah Hero Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB176F2), mainColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      arabicName,
                      style: GoogleFonts.amiri(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      latinName,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "\"$translation\"",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      height: 1,
                      color: Colors.white.withValues(alpha: 0.25),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildHeroMetaItem(
                          icon: Icons.format_list_numbered_rounded,
                          label: "Urutan",
                          value: "Ke-$surahNumber",
                        ),
                        Container(
                          width: 1,
                          height: 28,
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                        _buildHeroMetaItem(
                          icon: Icons.menu_book_rounded,
                          label: "Jumlah Ayat",
                          value: "$verseCount Ayat",
                        ),
                        Container(
                          width: 1,
                          height: 28,
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                        _buildHeroMetaItem(
                          icon: isMakkiyyah
                              ? Icons.location_city_rounded
                              : Icons.mosque_rounded,
                          label: "Golongan",
                          value: revelationPlace,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Badges Row
              Row(
                children: [
                  Expanded(
                    child: _buildBadgeCard(
                      isDark: isDark,
                      icon: isMakkiyyah
                          ? Icons.wb_sunny_outlined
                          : Icons.nights_stay_outlined,
                      iconColor: isMakkiyyah
                          ? const Color(0xFFFF9800)
                          : const Color(0xFF00B0FF),
                      title: isMakkiyyah ? "Makkiyyah" : "Madaniyyah",
                      subtitle: isMakkiyyah
                          ? "Diturunkan di Makkah (Sebelum Hijrah)"
                          : "Diturunkan di Madinah (Setelah Hijrah)",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildBadgeCard(
                      isDark: isDark,
                      icon: Icons.layers_outlined,
                      iconColor: const Color(0xFF00C853),
                      title: "$verseCount Ayat",
                      subtitle: "Total ayat dalam surah ini",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Description Title
              Row(
                children: [
                  const Icon(
                    Icons.subject_rounded,
                    color: mainColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Kandungan & Asbabun Nuzul",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Description Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.grey.shade200,
                  ),
                ),
                child: description != null && description!.trim().isNotEmpty
                    ? Html(
                        data: description!,
                        style: {
                          "body": Style(
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                            fontSize: FontSize(13.5),
                            color: isDark ? Colors.white70 : Colors.black87,
                            lineHeight: const LineHeight(1.65),
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                          "p": Style(
                            margin: Margins.only(bottom: 12),
                            fontSize: FontSize(13.5),
                            color: isDark ? Colors.white70 : Colors.black87,
                            lineHeight: const LineHeight(1.65),
                          ),
                          "strong": Style(
                            color: isDark ? Colors.white : mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                          "b": Style(
                            color: isDark ? Colors.white : mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                          "i": Style(
                            fontStyle: FontStyle.italic,
                          ),
                          "em": Style(
                            fontStyle: FontStyle.italic,
                          ),
                        },
                      )
                    : Text(
                        "Deskripsi dan asbabun nuzul untuk surat $latinName saat ini belum tersedia secara lengkap.",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: isDark ? Colors.white60 : Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
              ),

              const SizedBox(height: 24),

              // Bottom Close Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Tutup",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroMetaItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: Colors.white70),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildBadgeCard({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: isDark ? Colors.white60 : Colors.grey.shade600,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
