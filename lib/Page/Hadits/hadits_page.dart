import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:my_quran/Componen/Widget/TextDataWidget.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/model_hadits_perawi.dart';
import 'package:my_quran/Page/Hadits/hadits_detail_page.dart';
import 'package:my_quran/Provider/Hadits/hadits_provider.dart';
import 'package:provider/provider.dart';

class HaditsPage extends StatefulWidget {
  const HaditsPage({super.key});

  @override
  State<HaditsPage> createState() => _HaditsPageState();
}

class _HaditsPageState extends State<HaditsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final NumberFormat _numberFormat = NumberFormat('#,###', 'id_ID');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HaditsProvider>(context, listen: false);
      if (provider.listPerawi.isEmpty) {
        provider.getPerawi();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        title: TextData(
          text: "Kitab Hadits",
          size: 20,
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Consumer<HaditsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: mainColor),
            );
          }

          if (provider.errorMessage.isNotEmpty && provider.listPerawi.isEmpty) {
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
                        color: isDark ? Colors.white70 : Colors.black54,
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () => provider.getPerawi(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Coba Lagi"),
                    ),
                  ],
                ),
              ),
            );
          }

          final filteredList = provider.listPerawi.where((p) {
            final query = _searchQuery.toLowerCase().trim();
            if (query.isEmpty) return true;
            return p.name.toLowerCase().contains(query) ||
                p.slug.toLowerCase().contains(query);
          }).toList();

          final int totalAllHadits = provider.listPerawi.fold(
            0,
            (sum, item) => sum + item.total,
          );

          return RefreshIndicator(
            color: mainColor,
            onRefresh: () => provider.getPerawi(),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              children: [
                // Top Banner
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
                        color: const Color(0xff7B3FE4).withOpacity(0.25),
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
                            const Row(
                              children: [
                                Icon(
                                  Icons.menu_book_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                TextData(
                                  text: "Kutubut Tis'ah",
                                  size: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const TextData(
                              text: "9 Kitab Hadits",
                              size: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 4),
                            TextData(
                              text: totalAllHadits > 0
                                  ? "${_numberFormat.format(totalAllHadits)} Total Hadits"
                                  : "9 Perawi Terkemuka",
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
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.2)
                            : Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.poppins(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 13,
                    ),
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: InputDecoration(
                      hintText:
                          "Cari nama perawi hadits (contoh: Bukhari, Muslim)...",
                      hintStyle: GoogleFonts.poppins(
                        color: isDark ? Colors.white38 : Colors.grey.shade400,
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

                if (filteredList.isEmpty)
                  Padding(
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
                            "Kitab hadits tidak ditemukan",
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
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final perawi = filteredList[index];
                      return _buildPerawiCard(
                        perawi,
                        index + 1,
                        isDark,
                        cardColor,
                      );
                    },
                  ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPerawiCard(
    ModelHaditsPerawi perawi,
    int index,
    bool isDark,
    Color cardColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.25)
                : Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HaditsDetailPage(perawi: perawi),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                // Index Badge
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$index",
                    style: GoogleFonts.poppins(
                      color: mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Name & Stats
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "HR. ${perawi.name}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.auto_stories_rounded,
                            size: 14,
                            color: mainColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${_numberFormat.format(perawi.total)} Hadits",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: isDark ? Colors.white60 : Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFF7F8FA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: mainColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
