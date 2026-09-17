import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:my_quran/Componen/Widget/TextDataWidget.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/model_hadits_item.dart';
import 'package:my_quran/Model/model_hadits_perawi.dart';
import 'package:my_quran/Provider/Hadits/hadits_provider.dart';
import 'package:my_quran/Provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HaditsDetailPage extends StatefulWidget {
  final ModelHaditsPerawi perawi;
  const HaditsDetailPage({super.key, required this.perawi});

  @override
  State<HaditsDetailPage> createState() => _HaditsDetailPageState();
}

class _HaditsDetailPageState extends State<HaditsDetailPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  final NumberFormat _numberFormat = NumberFormat('#,###', 'id_ID');

  ModelHaditsItem? _searchedItem;
  bool _isSearchingNumber = false;
  Timer? _scrollDebounceTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<HaditsProvider>(
          context,
          listen: false,
        ).getHaditsByPerawi(widget.perawi.slug, page: 1);
      }
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels < 100) return;

    if (_scrollController.position.extentAfter < 300) {
      _scrollDebounceTimer?.cancel();
      _scrollDebounceTimer = Timer(const Duration(milliseconds: 200), () {
        if (!mounted) return;
        final provider = Provider.of<HaditsProvider>(context, listen: false);
        if (!provider.isLoadingMore &&
            !provider.isLoading &&
            !provider.isOffline &&
            provider.hasMore &&
            _searchedItem == null &&
            _searchQuery.isEmpty) {
          provider.getHaditsByPerawi(
            widget.perawi.slug,
            page: provider.currentPage + 1,
            isLoadMore: true,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollDebounceTimer?.cancel();
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch(String query) async {
    setState(() {
      _searchQuery = query;
      _searchedItem = null;
    });

    final int? hadithNumber = int.tryParse(query.trim());
    if (hadithNumber != null && hadithNumber > 0) {
      setState(() {
        _isSearchingNumber = true;
      });

      final provider = Provider.of<HaditsProvider>(context, listen: false);
      final item = await provider.getHaditsByNumber(
        widget.perawi.slug,
        hadithNumber,
      );
      if (mounted) {
        setState(() {
          _searchedItem = item;
          _isSearchingNumber = false;
        });
      }
    }
  }

  void _copyHadits(ModelHaditsItem hadits, AppProvider appProvider) {
    final text =
        '''HR. ${widget.perawi.name} No. ${hadits.number}

${hadits.arab}

${appProvider.tr('hadits_meaning')}
"${hadits.translation}"

${appProvider.tr('hadits_share_footer')}''';

    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              "${appProvider.tr('hadits_number_label')} ${hadits.number} ${appProvider.tr('hadits_copied')}",
              style: GoogleFonts.poppins(fontSize: 13),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF240F4F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareHadits(ModelHaditsItem hadits, AppProvider appProvider) {
    final text =
        '''HR. ${widget.perawi.name} No. ${hadits.number}

${hadits.arab}

${appProvider.tr('hadits_meaning')}
"${hadits.translation}"

${appProvider.tr('hadits_share_footer')}''';

    Share.share(
      text,
      subject: "HR. ${widget.perawi.name} No. ${hadits.number}",
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final appProvider = context.watch<AppProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextData(
          text: "HR. ${widget.perawi.name}",
          size: 20,
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Consumer<HaditsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.listHadits.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: mainColor),
            );
          }

          // Filter by search query
          final List<ModelHaditsItem> displayList;
          if (_searchedItem != null) {
            displayList = [_searchedItem!];
          } else if (_searchQuery.isNotEmpty &&
              int.tryParse(_searchQuery) == null) {
            final q = _searchQuery.toLowerCase().trim();
            displayList = provider.listHadits
                .where((h) => h.translation.toLowerCase().contains(q))
                .toList();
          } else {
            displayList = provider.listHadits;
          }

          return RefreshIndicator(
            color: mainColor,
            onRefresh: () =>
                provider.getHaditsByPerawi(widget.perawi.slug, page: 1),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
                    child: Column(
                      children: [
                        // Top Info Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xffC58AF9), Color(0xff7B3FE4)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xff7B3FE4,
                                ).withValues(alpha: 0.25),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.menu_book_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        TextData(
                                          text: appProvider.tr('hadits_title'),
                                          size: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        if (provider.isOffline) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withValues(
                                                alpha: 0.25,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              appProvider.tr(
                                                'offline_mode_badge',
                                              ),
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    TextData(
                                      text: "Imam ${widget.perawi.name}",
                                      size: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 4),
                                    TextData(
                                      text:
                                          "${appProvider.tr('hadits_total_count')}: ${_numberFormat.format(widget.perawi.total)}",
                                      size: 12,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                              Opacity(
                                opacity: 0.9,
                                child: Image.asset(
                                  "assets/image/book.png",
                                  width: 80,
                                  height: 80,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.auto_stories,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Search Bar
                        Container(
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? Colors.black.withValues(alpha: 0.2)
                                    : Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: _handleSearch,
                            style: GoogleFonts.poppins(
                              color: isDark ? Colors.white : Colors.black87,
                              fontSize: 13,
                            ),
                            decoration: InputDecoration(
                              hintText: appProvider.tr(
                                'hadits_search_number_hint',
                              ),
                              hintStyle: GoogleFonts.poppins(
                                color: isDark
                                    ? Colors.white38
                                    : Colors.grey.shade400,
                                fontSize: 13,
                              ),
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: mainColor,
                              ),
                              suffixIcon: _searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear_rounded,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {
                                          _searchQuery = '';
                                          _searchedItem = null;
                                        });
                                      },
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (_isSearchingNumber)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: CircularProgressIndicator(color: mainColor),
                      ),
                    ),
                  )
                else if (displayList.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 60,
                              color: isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              appProvider.tr('hadits_item_not_found'),
                              style: GoogleFonts.poppins(
                                color: isDark
                                    ? Colors.white60
                                    : Colors.grey.shade600,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final hadits = displayList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _buildHaditsCard(
                            hadits,
                            isDark,
                            cardColor,
                            appProvider,
                          ),
                        );
                      }, childCount: displayList.length),
                    ),
                  ),

                // Load More Indicator
                if (provider.isLoadingMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: CircularProgressIndicator(color: mainColor),
                      ),
                    ),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHaditsCard(
    ModelHaditsItem hadits,
    bool isDark,
    Color cardColor,
    AppProvider appProvider,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.25)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Row: Number badge + Actions
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: mainColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${appProvider.tr('hadits_number_label')} ${hadits.number}",
                    style: GoogleFonts.poppins(
                      color: mainColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.copy_rounded,
                    size: 18,
                    color: isDark ? Colors.white60 : Colors.black45,
                  ),
                  tooltip: "Salin",
                  onPressed: () => _copyHadits(hadits, appProvider),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(6),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: Icon(
                    Icons.share_rounded,
                    size: 18,
                    color: isDark ? Colors.white60 : Colors.black45,
                  ),
                  tooltip: "Bagikan",
                  onPressed: () => _shareHadits(hadits, appProvider),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(6),
                ),
              ],
            ),

            Divider(
              height: 24,
              thickness: 0.7,
              color: isDark ? const Color(0xFF333333) : const Color(0xFFF0F0F0),
            ),

            // Arabic Text
            if (hadits.arab.isNotEmpty) ...[
              Text(
                hadits.arab,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.amiri(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 2.0,
                  color: isDark
                      ? const Color(0xFFE0C9FF)
                      : const Color(0xFF240F4F),
                ),
              ),
              const SizedBox(height: 14),
            ],

            // Translation
            if (hadits.translation.isNotEmpty) ...[
              Text(
                appProvider.tr('hadits_meaning'),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                hadits.translation,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black87,
                  height: 1.6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
