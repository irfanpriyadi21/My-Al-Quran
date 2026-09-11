import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Utils/kisah_nabi_data.dart';
import 'package:share_plus/share_plus.dart';

class KisahNabiDetailPage extends StatelessWidget {
  final ModelKisahNabi nabi;

  const KisahNabiDetailPage({super.key, required this.nabi});

  void _shareKisah(BuildContext context) {
    final text = '✨ *Kisah ${nabi.name} (${nabi.arabicName})* ✨\n\n'
        '📌 *Masa / Era:* ${nabi.era}\n'
        '📌 *Tempat / Kaum:* ${nabi.place} (${nabi.kaum})\n\n'
        '📖 *Ringkasan Kisah:*\n${nabi.summary}\n\n'
        '🌟 *Mukjizat Utama:*\n${nabi.mukjizat.map((m) => "• $m").join("\n")}\n\n'
        '💡 *Hikmah & Pelajaran:*\n${nabi.hikmah.map((h) => "• $h").join("\n")}\n\n'
        '📚 *Ayat Al-Qur\'an:* ${nabi.quranVerses}\n\n'
        'Dibagikan dari aplikasi My Al-Qur\'an Mobile App.';
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          nabi.name,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Bagikan Kisah",
            icon: const Icon(Icons.share_rounded, color: mainColor),
            onPressed: () => _shareKisah(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Calligraphy Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFB176F2), mainColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
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
                  // Badges Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Nabi Ke-${nabi.number} dari 25",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (nabi.isUlulAzmi)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700)
                                .withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star_rounded,
                                  color: Color(0xFF6A4A00), size: 14),
                              const SizedBox(width: 4),
                              Text(
                                "Rasul Ulul Azmi",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6A4A00),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Big Arabic Calligraphy
                  Text(
                    nabi.arabicName,
                    style: GoogleFonts.amiri(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  // Name
                  Text(
                    nabi.name,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Era & Age Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      "Masa Hidup: ${nabi.era} • Usia: ${nabi.age}",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Quick Info Grid (Place, Kaum, Quran Mentions)
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.location_on_rounded,
                    title: "Wilayah Diutus",
                    value: nabi.place,
                    color: const Color(0xFFE91E63),
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.people_rounded,
                    title: "Kaum / Umat",
                    value: nabi.kaum,
                    color: const Color(0xFF00897B),
                    isDark: isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Summary Highlight
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: mainColor.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.format_quote_rounded,
                      color: mainColor, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      nabi.summary,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white70 : const Color(0xFF424242),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Section: Kisah Lengkap
            _buildSectionHeader(
              icon: Icons.auto_stories_rounded,
              title: "Kisah Lengkap & Perjalanan Dakwah",
              isDark: isDark,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF242424) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF333333)
                      : Colors.grey.withValues(alpha: 0.15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nabi.story,
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      color: isDark ? Colors.white70 : const Color(0xFF333333),
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: nabi.story));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Kisah berhasil disalin ke clipboard!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded, size: 16),
                      label: Text(
                        "Salin Kisah",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Section: Mukjizat & Keistimewaan
            _buildSectionHeader(
              icon: Icons.auto_awesome_rounded,
              title: "Mukjizat & Keistimewaan",
              isDark: isDark,
            ),
            const SizedBox(height: 10),
            ...nabi.mukjizat.map((m) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
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
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9800).withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFF9800),
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        m,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),

            // Section: Hikmah & Pelajaran
            _buildSectionHeader(
              icon: Icons.lightbulb_rounded,
              title: "Hikmah & Pelajaran Berharga",
              isDark: isDark,
            ),
            const SizedBox(height: 10),
            ...nabi.hikmah.map((h) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
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
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF4CAF50),
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        h,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),

            // Section: Dalil Al-Qur'an
            _buildSectionHeader(
              icon: Icons.menu_book_rounded,
              title: "Disebutkan dalam Al-Qur'an",
              isDark: isDark,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: mainColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Disebutkan ${nabi.mentionCountInQuran} Kali",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    nabi.quranVerses,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF242424) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? const Color(0xFF333333)
              : Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: isDark ? Colors.white54 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: mainColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: mainColor, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
