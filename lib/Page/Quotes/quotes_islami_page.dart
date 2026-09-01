import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/model_quotes_islami.dart';
import 'package:my_quran/Utils/quotes_islami_data.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesIslamiPage extends StatefulWidget {
  final ModelQuotesIslami? initialQuote;

  const QuotesIslamiPage({super.key, this.initialQuote});

  @override
  State<QuotesIslamiPage> createState() => _QuotesIslamiPageState();
}

class _QuotesIslamiPageState extends State<QuotesIslamiPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';
  String _searchQuery = '';
  bool _showOnlyFavorites = false;
  Set<String> _favoriteIds = {};

  late ModelQuotesIslami _dailyQuote;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _dailyQuote = widget.initialQuote ?? QuotesIslamiData.getQuoteOfTheDay();
    _loadFavorites();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('quotes_favorites_list') ?? [];
    if (mounted) {
      setState(() {
        _favoriteIds = favList.toSet();
      });
    }
  }

  Future<void> _toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favoriteIds.contains(id)) {
        _favoriteIds.remove(id);
      } else {
        _favoriteIds.add(id);
      }
    });
    await prefs.setStringList('quotes_favorites_list', _favoriteIds.toList());
  }

  void _shuffleDailyQuote() {
    setState(() {
      int nextIdx;
      do {
        nextIdx = _random.nextInt(QuotesIslamiData.list.length);
      } while (QuotesIslamiData.list[nextIdx].id == _dailyQuote.id && QuotesIslamiData.list.length > 1);
      _dailyQuote = QuotesIslamiData.list[nextIdx];
    });
    HapticFeedback.lightImpact();
  }

  List<ModelQuotesIslami> get _filteredList {
    return QuotesIslamiData.list.where((item) {
      if (_showOnlyFavorites && !_favoriteIds.contains(item.id)) {
        return false;
      }
      final matchesCategory = _selectedCategory == 'all' || item.category == _selectedCategory;
      final q = _searchQuery.toLowerCase().trim();
      final matchesSearch = q.isEmpty ||
          item.quote.toLowerCase().contains(q) ||
          item.source.toLowerCase().contains(q) ||
          item.categoryName.toLowerCase().contains(q) ||
          (item.arabic?.contains(q) ?? false);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _copyQuote(ModelQuotesIslami quote) {
    final buffer = StringBuffer();
    if (quote.arabic != null && quote.arabic!.isNotEmpty) {
      buffer.writeln(quote.arabic);
      buffer.writeln();
    }
    buffer.writeln('"${quote.quote}"');
    buffer.writeln();
    buffer.writeln('— ${quote.source}');
    buffer.writeln('📖 Dibagikan via Aplikasi My Al-Quran');

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    HapticFeedback.lightImpact();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              "Kata mutiara berhasil disalin!",
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF00C853),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareQuote(ModelQuotesIslami quote) {
    final buffer = StringBuffer();
    if (quote.arabic != null && quote.arabic!.isNotEmpty) {
      buffer.writeln(quote.arabic);
      buffer.writeln();
    }
    buffer.writeln('"${quote.quote}"');
    buffer.writeln();
    buffer.writeln('— ${quote.source} (${quote.categoryName})');
    buffer.writeln('\n✨ Dibagikan dari Aplikasi My Al-Quran');

    Share.share(buffer.toString());
  }

  void _showQuotePosterModal(ModelQuotesIslami quote) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                16,
                20,
                MediaQuery.of(context).padding.bottom + 16,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle Bar
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Poster Canvas Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: quote.gradientColors.map((c) => Color(c)).toList(),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(quote.gradientColors.first).withValues(alpha: 0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.format_quote_rounded,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (quote.arabic != null && quote.arabic!.isNotEmpty) ...[
                            Text(
                              quote.arabic!,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: GoogleFonts.amiri(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.8,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          Text(
                            "\"${quote.quote}\"",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Text(
                              quote.source,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(ctx);
                              _copyQuote(quote);
                            },
                            icon: const Icon(Icons.copy_rounded, size: 18),
                            label: Text(
                              "Salin Kutipan",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: mainColor,
                              side: const BorderSide(color: mainColor, width: 1.5),
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(ctx);
                              _shareQuote(quote);
                            },
                            icon: const Icon(Icons.share_rounded, size: 18),
                            label: Text(
                              "Bagikan",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final filtered = _filteredList;

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
          "Kata Mutiara Islami",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _showOnlyFavorites ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: _showOnlyFavorites ? Colors.redAccent : mainColor,
            ),
            tooltip: _showOnlyFavorites ? "Tampilkan Semua" : "Hanya Favorit",
            onPressed: () {
              setState(() {
                _showOnlyFavorites = !_showOnlyFavorites;
              });
            },
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
                  color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.06),
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
                    hintText: "Cari kutipan, tokoh, hadits, ayat...",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      color: isDark ? Colors.white38 : Colors.grey.shade400,
                    ),
                    prefixIcon: const Icon(Icons.search, color: mainColor, size: 20),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: isDark ? const Color(0xFF282828) : const Color(0xFFF5F5F7),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Category Chips List
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: QuotesIslamiData.categories.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final cat = QuotesIslamiData.categories[index];
                      final catId = cat['id']!;
                      final catName = cat['name']!;
                      final isSelected = _selectedCategory == catId && !_showOnlyFavorites;

                      return InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            _selectedCategory = catId;
                            _showOnlyFavorites = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? mainColor
                                : (isDark ? const Color(0xFF282828) : const Color(0xFFF0F0F3)),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? mainColor : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            catName,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark ? Colors.white70 : Colors.black87),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Main List View
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                // Daily Featured Quote Hero Banner (only on 'all' filter and not searching)
                if (_selectedCategory == 'all' && _searchQuery.isEmpty && !_showOnlyFavorites) ...[
                  _buildDailyQuoteBanner(isDark),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Semua Kata Mutiara (${QuotesIslamiData.list.length})",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        Text(
                          "Inspirasi Harian",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: isDark ? Colors.white54 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Favorites Header
                if (_showOnlyFavorites) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.favorite_rounded, color: Colors.redAccent, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          "Kutipan Favorit Anda (${_filteredList.length})",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Empty State
                if (filtered.isEmpty) ...[
                  const SizedBox(height: 50),
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          _showOnlyFavorites
                              ? Icons.favorite_border_rounded
                              : Icons.format_quote_rounded,
                          size: 56,
                          color: isDark ? Colors.white24 : Colors.grey.shade300,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          _showOnlyFavorites
                              ? "Belum ada kutipan favorit yang disimpan."
                              : "Kutipan islami tidak ditemukan.",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white60 : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _showOnlyFavorites
                              ? "Ketuk ikon hati pada kutipan untuk menyimpannya."
                              : "Coba gunakan kata kunci pencarian yang lain.",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: isDark ? Colors.white38 : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  // Cards List
                  ...filtered.map((quote) => _buildQuoteCard(quote, isDark, cardColor)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyQuoteBanner(bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _dailyQuote.gradientColors.map((c) => Color(c)).toList(),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(_dailyQuote.gradientColors.first).withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background subtle quotation watermark
          Positioned(
            right: -10,
            bottom: -15,
            child: Icon(
              Icons.format_quote_rounded,
              size: 130,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                          const SizedBox(width: 5),
                          Text(
                            "Kutipan Pilihan",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: _shuffleDailyQuote,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.shuffle_rounded, color: Colors.white, size: 13),
                            const SizedBox(width: 4),
                            Text(
                              "Acak Quote",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                if (_dailyQuote.arabic != null && _dailyQuote.arabic!.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _dailyQuote.arabic!,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.amiri(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],

                Text(
                  "\"${_dailyQuote.quote}\"",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.55,
                  ),
                ),

                const SizedBox(height: 14),

                // Source and Action Toolbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "— ${_dailyQuote.source}",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.copy_rounded, color: Colors.white, size: 18),
                          tooltip: "Salin",
                          onPressed: () => _copyQuote(_dailyQuote),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.share_rounded, color: Colors.white, size: 18),
                          tooltip: "Bagikan",
                          onPressed: () => _shareQuote(_dailyQuote),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: Icon(
                            _favoriteIds.contains(_dailyQuote.id)
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: _favoriteIds.contains(_dailyQuote.id)
                                ? Colors.redAccent
                                : Colors.white,
                            size: 18,
                          ),
                          tooltip: "Favorit",
                          onPressed: () => _toggleFavorite(_dailyQuote.id),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(ModelQuotesIslami quote, bool isDark, Color cardColor) {
    final isFav = _favoriteIds.contains(quote.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withValues(alpha: 0.05),
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
          onTap: () => _showQuotePosterModal(quote),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Tag Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: mainColor.withValues(alpha: isDark ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          quote.categoryName,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            isFav
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: isFav
                                ? Colors.redAccent
                                : (isDark ? Colors.white54 : Colors.grey),
                            size: 20,
                          ),
                          tooltip: "Favorit",
                          onPressed: () => _toggleFavorite(quote.id),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            Icons.copy_rounded,
                            color: isDark ? Colors.white54 : Colors.grey,
                            size: 18,
                          ),
                          tooltip: "Salin",
                          onPressed: () => _copyQuote(quote),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            Icons.share_rounded,
                            color: isDark ? Colors.white54 : Colors.grey,
                            size: 18,
                          ),
                          tooltip: "Bagikan",
                          onPressed: () => _shareQuote(quote),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Arabic Text if available
                if (quote.arabic != null && quote.arabic!.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      quote.arabic!,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.amiri(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFFE0C9FF) : mainColor,
                        height: 1.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                // Quote Body Text
                Text(
                  "\"${quote.quote}\"",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87,
                    height: 1.55,
                  ),
                ),

                const SizedBox(height: 12),

                // Source footer
                Row(
                  children: [
                    Container(
                      width: 3,
                      height: 14,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        quote.source,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white70 : Colors.grey.shade700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.fullscreen_rounded,
                      size: 18,
                      color: isDark ? Colors.white38 : Colors.grey.shade400,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
