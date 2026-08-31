import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Page/Alquran/quran_font_settings_modal.dart';
import 'package:my_quran/Provider/Surah/quran_settings_provider.dart';
import 'package:my_quran/Utils/yasin_tahlil_data.dart';
import 'package:provider/provider.dart';

class YasinTahlilPage extends StatefulWidget {
  final int initialTabIndex;

  const YasinTahlilPage({super.key, this.initialTabIndex = 0});

  @override
  State<YasinTahlilPage> createState() => _YasinTahlilPageState();
}

class _YasinTahlilPageState extends State<YasinTahlilPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$label berhasil disalin ke clipboard"),
        duration: const Duration(seconds: 2),
        backgroundColor: mainColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return Consumer<QuranSettingsProvider>(
      builder: (context, quranSettings, child) {
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
              "Yasin & Tahlil",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.format_size_rounded, color: mainColor),
                tooltip: "Pengaturan Font Arab",
                onPressed: () => QuranFontSettingsModal.show(context),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              labelColor: mainColor,
              unselectedLabelColor: isDark
                  ? Colors.white60
                  : Colors.grey.shade600,
              indicatorColor: mainColor,
              indicatorWeight: 3,
              isScrollable: true,
              labelStyle: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
              tabs: const [
                Tab(text: "Surat Yasin"),
                Tab(text: "Susunan Tahlil"),
                Tab(text: "Doa Tahlil"),
                Tab(text: "Ziarah Kubur"),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildYasinTab(isDark, quranSettings),
              _buildTahlilTab(isDark, quranSettings),
              _buildDoaTahlilTab(isDark, quranSettings),
              _buildZiarahTab(isDark, quranSettings),
            ],
          ),
        );
      },
    );
  }

  // ==========================================
  // TAB 1: SURAT YASIN
  // ==========================================
  Widget _buildYasinTab(bool isDark, QuranSettingsProvider quranSettings) {
    final list = YasinTahlilData.ayatYasin;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      itemCount: list.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildYasinHeaderCard(isDark, quranSettings);
        }
        final ayat = list[index - 1];
        return _buildAyatCard(ayat, isDark, quranSettings);
      },
    );
  }

  Widget _buildYasinHeaderCard(
    bool isDark,
    QuranSettingsProvider quranSettings,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFB176F2), mainColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: mainColor.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "سُوْرَةُ يٰسٓ",
            style: quranSettings.getArabicTextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Surat Yasin (83 Ayat) • Makkiyyah",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "\"Jantungnya Al-Qur'an (Qalbul Qur'an)\"",
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const Divider(color: Colors.white24, height: 20),
          Text(
            "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
            textAlign: TextAlign.center,
            style: quranSettings.getArabicTextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAyatCard(
    ModelAyatYasin ayat,
    bool isDark,
    QuranSettingsProvider quranSettings,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF282828) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black26
                : Colors.grey.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: mainColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${ayat.number}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.copy_rounded,
                  size: 18,
                  color: mainColor,
                ),
                tooltip: "Salin Ayat",
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _copyToClipboard(
                  "${ayat.arabic}\n\n${ayat.latin}\n\nArtinya: ${ayat.translation} (QS. Yasin: ${ayat.number})",
                  "Ayat ${ayat.number}",
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              ayat.arabic,
              textAlign: TextAlign.right,
              style: quranSettings.getArabicTextStyle(color: mainColor),
            ),
          ),
          if (quranSettings.showLatin && ayat.latin.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              ayat.latin,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: isDark ? Colors.white70 : Colors.grey.shade800,
              ),
            ),
          ],
          if (quranSettings.showTranslation && ayat.translation.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              "Artinya: \"${ayat.translation}\"",
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: isDark ? Colors.white60 : Colors.grey.shade600,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ==========================================
  // TAB 2: SUSUNAN TAHLIL
  // ==========================================

  Widget _buildTahlilTab(bool isDark, QuranSettingsProvider quranSettings) {
    final list = YasinTahlilData.bacaanTahlil;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final tahlil = list[index];
        return _buildTahlilCard(tahlil, isDark, quranSettings);
      },
    );
  }

  Widget _buildTahlilCard(
    ModelBacaanTahlil tahlil,
    bool isDark,
    QuranSettingsProvider quranSettings,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF282828) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black26
                : Colors.grey.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: mainColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${tahlil.number}",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        tahlil.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (tahlil.pengulangan != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C853).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tahlil.pengulangan!,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00C853),
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 6),
              IconButton(
                icon: const Icon(
                  Icons.copy_rounded,
                  size: 18,
                  color: mainColor,
                ),
                tooltip: "Salin Bacaan",
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _copyToClipboard(
                  "${tahlil.arabic}\n\n${tahlil.latin}\n\nArtinya: ${tahlil.translation}",
                  tahlil.title,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              tahlil.arabic,
              textAlign: TextAlign.right,
              style: quranSettings.getArabicTextStyle(color: mainColor),
            ),
          ),
          if (quranSettings.showLatin && tahlil.latin.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              tahlil.latin,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: isDark ? Colors.white70 : Colors.grey.shade800,
              ),
            ),
          ],
          if (quranSettings.showTranslation &&
              tahlil.translation.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              "Artinya: \"${tahlil.translation}\"",
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: isDark ? Colors.white60 : Colors.grey.shade600,
                height: 1.4,
              ),
            ),
          ],
          if (tahlil.keterangan != null) ...[
            const SizedBox(height: 6),
            Text(
              "ℹ️ ${tahlil.keterangan!}",
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontStyle: FontStyle.italic,
                color: const Color(0xFFFF9800),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ==========================================
  // TAB 3: DOA TAHLIL (DOA ARWAH)
  // ==========================================
  Widget _buildDoaTahlilTab(bool isDark, QuranSettingsProvider quranSettings) {
    final doa = YasinTahlilData.doaTahlil;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF282828) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black26
                    : Colors.grey.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      doa.title,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.copy_rounded,
                      size: 18,
                      color: mainColor,
                    ),
                    tooltip: "Salin Doa Tahlil",
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => _copyToClipboard(
                      "${doa.arabic}\n\n${doa.latin}\n\nArtinya:\n${doa.translation}",
                      doa.title,
                    ),
                  ),
                ],
              ),
              const Divider(height: 18),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  doa.arabic,
                  textAlign: TextAlign.right,
                  style: quranSettings.getArabicTextStyle(
                    color: mainColor,
                    height: 2.1,
                  ),
                ),
              ),
              if (quranSettings.showLatin && doa.latin.isNotEmpty) ...[
                const SizedBox(height: 14),
                Text(
                  "Bacaan Latin:",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doa.latin,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: isDark ? Colors.white70 : Colors.grey.shade800,
                    height: 1.5,
                  ),
                ),
              ],
              if (quranSettings.showTranslation &&
                  doa.translation.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  "Terjemahan:",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doa.translation,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: isDark ? Colors.white60 : Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // TAB 4: ZIARAH KUBUR
  // ==========================================
  Widget _buildZiarahTab(bool isDark, QuranSettingsProvider quranSettings) {
    final list = YasinTahlilData.doaZiarahKubur;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF282828) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black26
                    : Colors.grey.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF00897B),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.copy_rounded,
                      size: 18,
                      color: mainColor,
                    ),
                    tooltip: "Salin",
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => _copyToClipboard(
                      "${item.arabic}\n\n${item.latin}\n\n${item.translation}",
                      item.title,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (item.arabic.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    item.arabic,
                    textAlign: TextAlign.right,
                    style: quranSettings.getArabicTextStyle(color: mainColor),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              if (quranSettings.showLatin && item.latin.isNotEmpty) ...[
                Text(
                  item.latin,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: isDark ? Colors.white70 : Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 6),
              ],
              if (quranSettings.showTranslation &&
                  item.translation.isNotEmpty) ...[
                Text(
                  item.translation,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: isDark ? Colors.white60 : Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
              ],
              if (item.keterangan != null) ...[
                const SizedBox(height: 8),
                Text(
                  "ℹ️ ${item.keterangan!}",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFFFF9800),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
