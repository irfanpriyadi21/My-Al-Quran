import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Page/Profile/privacy_policy_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Componen/colors.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  void _shareApp(BuildContext context) {
    const shareText = '''
🌙 *My Al-Quran - Sahabat Ibadah Muslim Sehari-hari* 📖✨

Yuk gunakan aplikasi *My Al-Quran* untuk mendukung ibadah harianmu:
• Al-Quran Digital 30 Juz & Audio Murottal Qori Internasional
• Jadwal Sholat 5 Waktu & Alarm Notifikasi Adzan Otomatis
• Kompas Arah Kiblat Presisi
• Doa Harian, Dzikir Pagi Petang & Tasbih Digital
• Hadits 9 Imam, Kalender Hijriah & Hari Besar Islam
• Tuntunan Sholat, Ilmu Tajwid, Yasin & Tahlil, Shalawat
• 99 Asmaul Husna, Kata Mutiara Islami, & Masjid Terdekat

Semoga bermanfaat dan menjadi amal jariyah untuk kita semua! Aamiin. 🤲
''';
    Share.share(shareText.trim(), subject: "My Al-Quran Mobile App");
  }

  Future<void> _launchEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'irfanpnf@gmail.com',
      queryParameters: {'subject': 'Feedback & Masukan Aplikasi My Al-Quran'},
    );
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Email pengembang: irfanpnf@gmail.com"),
            ),
          );
        }
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email pengembang: irfanpnf@gmail.com")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: mainColor,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Tentang Aplikasi",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: mainColor, size: 22),
            tooltip: "Bagikan Aplikasi",
            onPressed: () => _shareApp(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // HERO APP CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFB176F2), mainColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: mainColor.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // App Icon Container
                  Container(
                    width: 88,
                    height: 88,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/image/app_logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (ctx, error, stackTrace) => const Icon(
                        Icons.menu_book_rounded,
                        color: mainColor,
                        size: 48,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "My Al-Quran",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Versi 1.0.0 (Release)",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Aplikasi Al-Quran Digital Modern & Sahabat Lengkap Ibadah Muslim Sehari-hari",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // QUICK ACTIONS ROW
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    context: context,
                    icon: Icons.share_rounded,
                    iconColor: const Color(0xFF00B0FF),
                    title: "Bagikan",
                    subtitle: "Sebar kebaikan",
                    onTap: () => _shareApp(context),
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    context: context,
                    icon: Icons.mail_outline_rounded,
                    iconColor: const Color(0xFFFF9800),
                    title: "Kritik & Saran",
                    subtitle: "Kirim email",
                    onTap: () => _launchEmail(context),
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    context: context,
                    icon: Icons.privacy_tip_outlined,
                    iconColor: const Color(0xFF00C853),
                    title: "Privasi",
                    subtitle: "Kebijakan data",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyPage(),
                        ),
                      );
                    },
                    isDark: isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // SECTION 1: VISI & DESKRIPSI
            _buildSectionHeader(
              title: "Tentang My Al-Quran",
              icon: Icons.auto_awesome_rounded,
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                "My Al-Quran dibangun dengan tujuan memberikan kemudahan bagi umat Islam dalam menjalankan ibadah harian. Dilengkapi dengan mushaf Al-Quran standar Kemenag RI, audio murottal dari qori internasional, jadwal sholat otomatis berbasis lokasi geografis dengan alarm notifikasi adzan, penunjuk arah kiblat kompas akurat, serta puluhan perlengkapan ibadah seperti doa harian, dzikir, hadits, tuntunan sholat, dan ilmu tajwid.",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: isDark ? Colors.white70 : Colors.black87,
                  height: 1.65,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // SECTION 2: FITUR-FITUR LENGKAP
            _buildSectionHeader(
              title: "Fitur Lengkap Aplikasi",
              icon: Icons.grid_view_rounded,
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            _buildFeatureTile(
              icon: Icons.menu_book_rounded,
              iconColor: const Color(0xFF673AB7),
              title: "Al-Quran Digital & Audio Murottal",
              description:
                  "114 Surah lengkap, teks Arab Utsmani, terjemahan Kemenag RI, transliterasi Latin, audio murottal per ayat, pencarian cerdas, dan ekspor surah ke format PDF.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.access_time_filled_rounded,
              iconColor: const Color(0xFF00897B),
              title: "Jadwal Shalat & Notifikasi Adzan",
              description:
                  "Waktu sholat 5 waktu & Imsakiyah akurat harian dan bulanan otomatis sesuai lokasi GPS pengguna, dilengkapi alarm adzan bersuara merdu.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.explore_rounded,
              iconColor: const Color(0xFFFF5722),
              title: "Kompas Arah Kiblat Presisi",
              description:
                  "Penunjuk arah Ka'bah interaktif dengan sensor kompas dan perhitungan derajat azimuth dari lokasi pengguna.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.pan_tool_rounded,
              iconColor: const Color(0xFFE91E63),
              title: "Doa Harian & Dzikir Pagi Petang",
              description:
                  "Kumpulan doa sehari-hari lengkap dan dzikir pagi petang shahih dilengkapi tasbih digital counter dengan getar haptic.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.library_books_rounded,
              iconColor: const Color(0xFF3F51B5),
              title: "Hadits 9 Imam Terkemuka",
              description:
                  "Koleksi hadits shahih dari Imam Bukhari, Muslim, Abu Daud, Tirmidzi, Nasai, Ibnu Majah, Ahmad, Malik, dan Darimi.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.calendar_month_rounded,
              iconColor: const Color(0xFF8E24AA),
              title: "Kalender Hijriah & Hari Besar Islam",
              description:
                  "Penanggalan Hijriah interaktif, konversi masehi-hijriah, pengingat hari besar Islam, dan jadwal puasa sunnah.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.accessibility_new_rounded,
              iconColor: const Color(0xFF00ACC1),
              title: "Tuntunan Sholat & Wudhu",
              description:
                  "Panduan shalat fardhu 5 waktu, sholat sunnah, tata cara wudhu, tayamum, serta bacaan dzikir setelah shalat.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.record_voice_over_rounded,
              iconColor: const Color(0xFF43A047),
              title: "Panduan Lengkap Ilmu Tajwid",
              description:
                  "Hukum nun mati, tanwin, mim mati, mad far'i, qalqalah, dan tanda waqaf disertai contoh bacaan Arab.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.book_outlined,
              iconColor: const Color(0xFFD81B60),
              title: "Surat Yasin & Tahlil Lengkap",
              description:
                  "Surat Yasin 83 ayat, susunan tahlil lengkap dengan doa arwah dan doa selamat.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.favorite_rounded,
              iconColor: const Color(0xFFFF7043),
              title: "Kumpulan Shalawat Nabi",
              description:
                  "Shalawat Nariyah, Thibbil Qulub, Munjiyat, Jibril, Fatih, Ibrahimiyah, Asyghil, dan Busyro.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.stars_rounded,
              iconColor: const Color(0xFF26A69A),
              title: "99 Asmaul Husna",
              description:
                  "99 Nama-nama terindah Allah SWT lengkap dengan kaligrafi Arab, arti bahasa Indonesia, dan dzikir.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.format_quote_rounded,
              iconColor: const Color(0xFF7E57C2),
              title: "Kata-Kata Mutiara Islami",
              description:
                  "Quotes mutiara motivasi islami harian, kata bijak sahabat nabi, dan kemudahan salin/bagikan ke media sosial.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.mosque_rounded,
              iconColor: const Color(0xFF009688),
              title: "Masjid Terdekat & Navigasi Peta",
              description:
                  "Pencarian lokasi masjid dan musholla terdekat dari posisi saat ini dilengkapi estimasi jarak dan rute peta.",
              isDark: isDark,
              cardColor: cardColor,
            ),
            _buildFeatureTile(
              icon: Icons.calculate_rounded,
              iconColor: const Color(0xFF0288D1),
              title: "Kalkulator Zakat Maal & Emas",
              description:
                  "Kalkulator zakat maal 2.5% berdasarkan nisab emas untuk membantu menghitung kewajiban zakat.",
              isDark: isDark,
              cardColor: cardColor,
            ),

            const SizedBox(height: 28),

            // SECTION 3: SUMBER DATA & API
            _buildSectionHeader(
              title: "Sumber Data & Lisensi API",
              icon: Icons.cloud_done_rounded,
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSourceItem(
                    title: "Al-Quran & Terjemahan",
                    source:
                        "Kementerian Agama Republik Indonesia (Kemenag RI) & equran.id API",
                    isDark: isDark,
                  ),
                  const Divider(height: 20),
                  _buildSourceItem(
                    title: "Jadwal Sholat & Imsakiyah",
                    source: "Kemenag RI melalui API myquran.com",
                    isDark: isDark,
                  ),
                  const Divider(height: 20),
                  _buildSourceItem(
                    title: "Hadits Nabawi",
                    source: "Kitab 9 Imam melalui Hadith API ID",
                    isDark: isDark,
                  ),
                  const Divider(height: 20),
                  _buildSourceItem(
                    title: "Audio Murottal Qori",
                    source: "EveryAyah & Quran Cloud Audio Database",
                    isDark: isDark,
                  ),
                  const Divider(height: 20),
                  _buildSourceItem(
                    title: "Peta & Lokasi Masjid",
                    source: "OpenStreetMap Contributors & Geolocator Services",
                    isDark: isDark,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // SECTION 4: INFORMASI PENGEMBANG
            _buildSectionHeader(
              title: "Pengembang & Kontak",
              icon: Icons.code_rounded,
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: mainColor.withValues(alpha: 0.15),
                        child: const Icon(
                          Icons.developer_mode_rounded,
                          color: mainColor,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Irfan Priyadi & Tim Pengembang",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              "Flutter Mobile App Developer",
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
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Divider(),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    leading: const Icon(
                      Icons.email_outlined,
                      color: mainColor,
                      size: 20,
                    ),
                    title: Text(
                      "irfanpnf@gmail.com",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 13,
                      color: Colors.grey,
                    ),
                    onTap: () => _launchEmail(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // FOOTER COPYRIGHT
            Text(
              "Hak Cipta © 2026 My Al-Quran. Seluruh Hak Cipta Dilindungi.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: isDark ? Colors.white38 : Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Dibuat dengan penuh dedikasi untuk umat Muslim di seluruh dunia 🤲",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                color: isDark ? Colors.white24 : Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
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
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Material(
      color: isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: isDark ? Colors.white54 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required bool isDark,
    required Color cardColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
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
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: isDark ? Colors.white60 : Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceItem({
    required String title,
    required String source,
    required bool isDark,
  }) {
    return Column(
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
          source,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: isDark ? Colors.white60 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
