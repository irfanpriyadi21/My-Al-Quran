import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/News/NewsDetail.dart';
import 'package:my_quran/Componen/Widget/shimmer_widget.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/ModelListArtikel.dart';
import 'package:my_quran/Model/string_http_exception.dart';
import 'package:my_quran/Provider/Artikel/ArtikelApi.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List<ModelListArtikel> _articles = [];
  bool _isLoading = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchArticles() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Artikel>(context, listen: false).getArtikel();
    } on StringHttpException catch (e) {
      debugPrint("Http Error: $e");
    } catch (e) {
      debugPrint("Error fetching articles: $e");
    }
    if (mounted) {
      setState(() {
        _articles = Provider.of<Artikel>(context, listen: false).listArtikel;
        _isLoading = false;
      });
    }
  }

  List<ModelListArtikel> get _filteredArticles {
    if (_searchQuery.trim().isEmpty) return _articles;
    final query = _searchQuery.toLowerCase().trim();
    return _articles.where((article) {
      final title = article.title?.toLowerCase() ?? '';
      return title.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final filtered = _filteredArticles;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: mainColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Informasi & Berita Islam",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchArticles,
        color: mainColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Input
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF242424) : const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.grey.shade300,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Cari artikel atau informasi Islam...",
                    hintStyle: GoogleFonts.poppins(
                      color: isDark ? Colors.white38 : Colors.grey.shade400,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(Icons.search_rounded, color: mainColor, size: 22),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            color: isDark ? Colors.white60 : Colors.grey,
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
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

              const SizedBox(height: 18),

              // Total count banner
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Menampilkan ${filtered.length} artikel",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    InkWell(
                      onTap: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                      child: Text(
                        "Reset Pencarian",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 14),

              // Content List
              if (_isLoading)
                Column(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: ShimmerEffect(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF2C2C2C) : Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              else if (filtered.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: mainColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.article_outlined,
                            size: 54,
                            color: mainColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Artikel Tidak Ditemukan",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Coba gunakan kata kunci pencarian lainnya",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: isDark ? Colors.white60 : Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final article = filtered[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            if (article.id != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetail(article.id!),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                // Thumbnail
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: article.thumbnail != null &&
                                            article.thumbnail!.isNotEmpty
                                        ? Image.network(
                                            article.thumbnail!,
                                            fit: BoxFit.cover,
                                            errorBuilder: (ctx, _, __) => Container(
                                              color: isDark
                                                  ? const Color(0xFF2C2C2C)
                                                  : Colors.grey[200],
                                              child: const Icon(
                                                Icons.image,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            color: isDark
                                                ? const Color(0xFF2C2C2C)
                                                : Colors.grey[200],
                                            child: const Icon(
                                              Icons.article,
                                              color: Colors.grey,
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                // Text details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title ?? 'Informasi Islam',
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? Colors.white : Colors.black87,
                                          height: 1.35,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      if (article.date != null &&
                                          article.date!.isNotEmpty)
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              size: 11,
                                              color: isDark
                                                  ? Colors.white54
                                                  : Colors.grey.shade600,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              article.date!,
                                              style: GoogleFonts.poppins(
                                                fontSize: 10.5,
                                                color: isDark
                                                    ? Colors.white54
                                                    : Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: isDark ? Colors.white38 : Colors.grey.shade400,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
