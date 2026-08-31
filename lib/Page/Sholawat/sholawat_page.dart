import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Page/Alquran/quran_font_settings_modal.dart';
import 'package:my_quran/Provider/Surah/quran_settings_provider.dart';
import 'package:my_quran/Utils/sholawat_data.dart';
import 'package:provider/provider.dart';

class SholawatPage extends StatefulWidget {
  const SholawatPage({super.key});

  @override
  State<SholawatPage> createState() => _SholawatPageState();
}

class _SholawatPageState extends State<SholawatPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ModelSholawat> get _filteredList {
    return SholawatData.list.where((item) {
      final matchesCategory =
          _selectedCategory == 'all' || item.category == _selectedCategory;
      final q = _searchQuery.toLowerCase().trim();
      final matchesSearch =
          q.isEmpty ||
          item.title.toLowerCase().contains(q) ||
          item.subtitle.toLowerCase().contains(q) ||
          item.keutamaan.toLowerCase().contains(q) ||
          item.latin.toLowerCase().contains(q);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final filtered = _filteredList;

    return Consumer<QuranSettingsProvider>(
      builder: (context, quranSettings, _) {
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
              "Kumpulan Shalawat",
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
          ),
          body: Column(
            children: [
              // Search & Filter Header
              Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black26
                          : Colors.grey.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Search Field
                    TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: "Cari shalawat, fadhilah, hajat...",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark ? Colors.white38 : Colors.grey.shade400,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: mainColor,
                          size: 20,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: isDark
                            ? const Color(0xFF282828)
                            : const Color(0xFFF7F8FA),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Category Filter Pills
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildCategoryChip(
                            'all',
                            'Semua',
                            Icons.grid_view_rounded,
                            isDark,
                          ),
                          const SizedBox(width: 8),
                          _buildCategoryChip(
                            'matsurah',
                            'Ma\'tsurah (Hadits)',
                            Icons.verified_rounded,
                            isDark,
                          ),
                          const SizedBox(width: 8),
                          _buildCategoryChip(
                            'hajat_rezeki',
                            'Hajat & Rezeki',
                            Icons.auto_awesome_rounded,
                            isDark,
                          ),
                          const SizedBox(width: 8),
                          _buildCategoryChip(
                            'kesehatan_hati',
                            'Kesehatan & Hati',
                            Icons.favorite_rounded,
                            isDark,
                          ),
                          const SizedBox(width: 8),
                          _buildCategoryChip(
                            'perlindungan',
                            'Perlindungan',
                            Icons.shield_rounded,
                            isDark,
                          ),
                          const SizedBox(width: 8),
                          _buildCategoryChip(
                            'maulid',
                            'Maulid & Qasidah',
                            Icons.library_music_rounded,
                            isDark,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Sholawat List
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 64,
                              color: isDark
                                  ? Colors.white24
                                  : Colors.grey.shade300,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Shalawat tidak ditemukan",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white60
                                    : Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Coba kata kunci pencarian lainnya",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: isDark
                                    ? Colors.white38
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          return _buildSholawatCard(item, isDark);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryChip(
    String id,
    String label,
    IconData icon,
    bool isDark,
  ) {
    final isSelected = _selectedCategory == id;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        setState(() {
          _selectedCategory = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? mainColor
              : isDark
              ? const Color(0xFF282828)
              : const Color(0xFFF0F1F5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isSelected
                  ? Colors.white
                  : isDark
                  ? Colors.white70
                  : Colors.grey.shade700,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Colors.white
                    : isDark
                    ? Colors.white70
                    : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSholawatCard(ModelSholawat item, bool isDark) {
    Color badgeColor;
    IconData icon;

    switch (item.category) {
      case 'matsurah':
        badgeColor = const Color(0xFF00C853);
        icon = Icons.verified_rounded;
        break;
      case 'hajat_rezeki':
        badgeColor = const Color(0xFFFF9800);
        icon = Icons.auto_awesome_rounded;
        break;
      case 'kesehatan_hati':
        badgeColor = const Color(0xFFE91E63);
        icon = Icons.favorite_rounded;
        break;
      case 'perlindungan':
        badgeColor = const Color(0xFF00B0FF);
        icon = Icons.shield_rounded;
        break;
      default:
        badgeColor = const Color(0xFF9C27B0);
        icon = Icons.library_music_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SholawatDetailPage(item: item),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: badgeColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: isDark ? Colors.white60 : Colors.grey.shade600,
                        ),
                      ),
                      if (item.anjuranBaca != null) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: mainColor.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "⏱️ ${item.anjuranBaca!}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: mainColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? Colors.white38 : Colors.grey.shade400,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ========================================================
// DETAIL PAGE KUMPULAN SHOLAWAT
// ========================================================
class SholawatDetailPage extends StatefulWidget {
  final ModelSholawat item;

  const SholawatDetailPage({super.key, required this.item});

  @override
  State<SholawatDetailPage> createState() => _SholawatDetailPageState();
}

class _SholawatDetailPageState extends State<SholawatDetailPage> {
  int _counter = 0;
  int _target = 33; // default 33x

  void _incrementCounter() {
    HapticFeedback.lightImpact();
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
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
    final item = widget.item;

    return Consumer<QuranSettingsProvider>(
      builder: (context, quranSettings, _) {
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
              item.title,
              style: GoogleFonts.poppins(
                fontSize: 17,
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
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(16),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    if (item.anjuranBaca != null) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Anjuran: ${item.anjuranBaca!}",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Keutamaan & Fadhilah
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF282828) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark ? Colors.white10 : Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome_rounded,
                          color: mainColor,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Keutamaan & Khasiat Amalan",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.keutamaan,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: isDark ? Colors.white70 : Colors.grey.shade800,
                        height: 1.5,
                      ),
                    ),
                    if (item.sejarah != null) ...[
                      const Divider(height: 18),
                      Text(
                        "📜 Asal Usul / Riwayat:",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: mainColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.sejarah!,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          color: isDark ? Colors.white60 : Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Lafadz Shalawat Card
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: mainColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Teks Shalawat",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: mainColor,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy_rounded,
                            size: 18,
                            color: mainColor,
                          ),
                          tooltip: "Salin Shalawat",
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => _copyToClipboard(
                            "${item.arabic}\n\n${item.latin}\n\nArtinya: ${item.translation}",
                            item.title,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        item.arabic,
                        textAlign: TextAlign.right,
                        style: quranSettings.getArabicTextStyle(
                          color: mainColor,
                          height: 2.1,
                        ),
                      ),
                    ),
                    if (quranSettings.showLatin && item.latin.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      Text(
                        item.latin,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: isDark ? Colors.white70 : Colors.grey.shade800,
                          height: 1.5,
                        ),
                      ),
                    ],
                    if (quranSettings.showTranslation &&
                        item.translation.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        "Artinya: \"${item.translation}\"",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark ? Colors.white60 : Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Interactive Tap Counter Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF282828) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark ? Colors.white10 : Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.touch_app_rounded,
                              color: mainColor,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Penghitung Wirid (Tasbih)",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: _resetCounter,
                          child: Text(
                            "Reset",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Target selector chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [11, 33, 80, 100, 1000].map((t) {
                          final isSel = _target == t;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: ChoiceChip(
                              label: Text("${t}x"),
                              selected: isSel,
                              selectedColor: mainColor,
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: isSel
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSel
                                    ? Colors.white
                                    : (isDark
                                          ? Colors.white70
                                          : Colors.grey.shade700),
                              ),
                              onSelected: (_) => setState(() => _target = t),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Interactive Tap Circle
                    GestureDetector(
                      onTap: _incrementCounter,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: _counter >= _target
                                ? [
                                    const Color(0xFF00E676),
                                    const Color(0xFF00C853),
                                  ]
                                : [const Color(0xFFB176F2), mainColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  (_counter >= _target
                                          ? const Color(0xFF00C853)
                                          : mainColor)
                                      .withValues(alpha: 0.35),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$_counter",
                                style: GoogleFonts.poppins(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "/ $_target",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _counter >= _target
                          ? "🎉 Target tercapai! Alhamdulillah"
                          : "Ketuk lingkaran untuk menghitung",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: _counter >= _target
                            ? const Color(0xFF00C853)
                            : (isDark ? Colors.white38 : Colors.grey.shade500),
                        fontWeight: _counter >= _target
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
