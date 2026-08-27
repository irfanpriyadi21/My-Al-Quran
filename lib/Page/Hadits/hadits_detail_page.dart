import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:my_quran/Componen/Widget/TextDataWidget.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/model_hadits_item.dart';
import 'package:my_quran/Model/model_hadits_perawi.dart';
import 'package:my_quran/Provider/Hadits/hadits_provider.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HaditsProvider>(
        context,
        listen: false,
      ).getHaditsByPerawi(widget.perawi.slug, page: 1);
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final provider = Provider.of<HaditsProvider>(context, listen: false);
      if (!provider.isLoadingMore &&
          !provider.isLoading &&
          provider.currentPage < provider.totalPages &&
          _searchedItem == null) {
        provider.getHaditsByPerawi(
          widget.perawi.slug,
          page: provider.currentPage + 1,
          isLoadMore: true,
        );
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch(String query) async {
    setState(() {
      _searchQuery = query;
      _searchedItem = null;
    });

    final int? hadithNumber = int.tryParse(query.trim());
    if (hadithNumber != null &&
        hadithNumber > 0 &&
        hadithNumber <= widget.perawi.total) {
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

  void _copyHadits(ModelHaditsItem hadits) {
    final text =
        '''HR. ${widget.perawi.name} No. ${hadits.number}

${hadits.arab}

Artinya:
"${hadits.translation}"

(Dibagikan dari Aplikasi My Alquran Mobile App)''';

    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              "Hadits No. ${hadits.number} berhasil disalin",
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

  void _shareHadits(ModelHaditsItem hadits) {
    final text =
        '''HR. ${widget.perawi.name} No. ${hadits.number}

${hadits.arab}

Artinya:
"${hadits.translation}"

Dibagikan dari Aplikasi My Alquran Mobile App''';

    Share.share(
      text,
      subject: "HR. ${widget.perawi.name} No. ${hadits.number}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: mainColor),
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
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator(color: mainColor));
          }

          if (provider.errorMessage.isNotEmpty && provider.listHadits.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_off_rounded,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      provider.errorMessage,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => provider.getHaditsByPerawi(
                        widget.perawi.slug,
                        page: 1,
                      ),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Coba Lagi"),
                    ),
                  ],
                ),
              ),
            );
          }

          // Filter by search query (if not single number search)
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
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
                        color: const Color(0xff7B3FE4).withValues(alpha: 0.25),
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
                                  text: "Kitab Hadits",
                                  size: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
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
                                  "Total ${_numberFormat.format(widget.perawi.total)} Hadits",
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

                const SizedBox(height: 16),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _handleSearch,
                    decoration: InputDecoration(
                      hintText:
                          "Cari nomor hadits (1-${widget.perawi.total}) atau kata kunci...",
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.grey.shade400,
                        fontSize: 13,
                      ),
                      prefixIcon: Icon(Icons.search_rounded, color: mainColor),
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

                const SizedBox(height: 16),

                if (_isSearchingNumber)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: CircularProgressIndicator(color: mainColor),
                    ),
                  )
                else if (displayList.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 60,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Hadits tidak ditemukan",
                            style: GoogleFonts.poppins(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: displayList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final hadits = displayList[index];
                      return _buildHaditsCard(hadits);
                    },
                  ),

                // Load More Indicator
                if (provider.isLoadingMore)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: CircularProgressIndicator(color: mainColor),
                    ),
                  ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHaditsCard(ModelHaditsItem hadits) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
            // Top Row: Number badge + Perawi + Actions
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: mainColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Hadits No. ${hadits.number}",
                    style: GoogleFonts.poppins(
                      color: mainColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.copy_rounded,
                    size: 18,
                    color: Colors.black45,
                  ),
                  tooltip: "Salin",
                  onPressed: () => _copyHadits(hadits),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(6),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(
                    Icons.share_rounded,
                    size: 18,
                    color: Colors.black45,
                  ),
                  tooltip: "Bagikan",
                  onPressed: () => _shareHadits(hadits),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(6),
                ),
              ],
            ),

            const Divider(height: 24, thickness: 0.7, color: Color(0xFFF0F0F0)),

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
                  color: const Color(0xFF240F4F),
                ),
              ),
              const SizedBox(height: 14),
            ],

            // Translation
            if (hadits.translation.isNotEmpty) ...[
              Text(
                "Artinya:",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                hadits.translation,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.black87,
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
