import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Page/KisahNabi/kisah_nabi_detail_page.dart';
import 'package:my_quran/Utils/kisah_nabi_data.dart';

class KisahNabiPage extends StatefulWidget {
  const KisahNabiPage({super.key});

  @override
  State<KisahNabiPage> createState() => _KisahNabiPageState();
}

class _KisahNabiPageState extends State<KisahNabiPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'all'; // all, ulul_azmi
  bool _isGridView = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ModelKisahNabi> get _filteredList {
    return KisahNabiData.list.where((item) {
      // Filter logic
      final matchesFilter = _selectedFilter == 'all' ||
          (_selectedFilter == 'ulul_azmi' && item.isUlulAzmi);

      // Search query logic
      final q = _searchQuery.toLowerCase().trim();
      final matchesSearch = q.isEmpty ||
          item.name.toLowerCase().contains(q) ||
          item.arabicName.contains(q) ||
          item.summary.toLowerCase().contains(q) ||
          item.kaum.toLowerCase().contains(q) ||
          item.place.toLowerCase().contains(q) ||
          item.mukjizat.any((m) => m.toLowerCase().contains(q));

      return matchesFilter && matchesSearch;
    }).toList();
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
          "Kisah 25 Nabi & Rasul",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: _isGridView ? "Tampilan List" : "Tampilan Grid",
            icon: Icon(
              _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
              color: mainColor,
            ),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
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
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20)),
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
                // Search Input
                TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: "Cari nabi (Adam, Musa, Muhammad, mukjizat...)",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: isDark ? Colors.white38 : Colors.grey.shade400,
                    ),
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: mainColor, size: 20),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: isDark
                        ? const Color(0xFF282828)
                        : const Color(0xFFF7F8FA),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Filter Chips
                Row(
                  children: [
                    _buildFilterChip('all', 'Semua (25 Nabi)', isDark),
                    const SizedBox(width: 8),
                    _buildFilterChip('ulul_azmi', '⭐ Ulul Azmi (5 Nabi)', isDark),
                  ],
                ),
              ],
            ),
          ),

          // Count & Information Banner
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Daftar 25 Nabi & Rasul Allah",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: mainColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${filtered.length} Nabi",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content List / Grid
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 64,
                          color: isDark ? Colors.white24 : Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Kisah Nabi tidak ditemukan",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white60 : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Coba gunakan kata kunci pencarian lainnya",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: isDark ? Colors.white38 : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  )
                : _isGridView
                    ? GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                        itemCount: filtered.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.85,
                        ),
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          return _buildGridCard(item, isDark);
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          return _buildListTile(item, isDark);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String id, String label, bool isDark) {
    final isSelected = _selectedFilter == id;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => setState(() => _selectedFilter = id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? mainColor
              : (isDark ? const Color(0xFF282828) : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? mainColor
                : (isDark ? Colors.white10 : Colors.grey.shade300),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.white70 : Colors.grey.shade700),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(ModelKisahNabi item, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KisahNabiDetailPage(nabi: item),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Number Circle Badge
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: item.isUlulAzmi
                        ? const Color(0xFFFF9800).withValues(alpha: 0.15)
                        : mainColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    "${item.number}",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: item.isUlulAzmi
                          ? const Color(0xFFFF9800)
                          : mainColor,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Info Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name & Ulul Azmi Star
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                          if (item.isUlulAzmi)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD700)
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFFFFB300),
                                  width: 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star_rounded,
                                      color: Color(0xFFFFB300), size: 12),
                                  const SizedBox(width: 3),
                                  Text(
                                    "Ulul Azmi",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? const Color(0xFFFFD54F)
                                          : const Color(0xFFE65100),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),

                      // Arabic Calligraphy Subtitle
                      Text(
                        item.arabicName,
                        style: GoogleFonts.amiri(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Summary snippet
                      Text(
                        item.summary,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: isDark ? Colors.white60 : Colors.grey.shade600,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Era / Place Tag
                      Row(
                        children: [
                          Icon(
                            Icons.history_rounded,
                            size: 14,
                            color:
                                isDark ? Colors.white38 : Colors.grey.shade400,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "${item.era} • ${item.place}",
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                color: isDark
                                    ? Colors.white54
                                    : Colors.grey.shade500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Forward Arrow
                Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? Colors.white24 : Colors.grey.shade400,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard(ModelKisahNabi item, bool isDark) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KisahNabiDetailPage(nabi: item),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Number & Ulul Azmi Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: mainColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "${item.number}",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                    ),
                    if (item.isUlulAzmi)
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFFFB300), size: 20),
                  ],
                ),

                const SizedBox(height: 6),

                // Big Calligraphy
                Center(
                  child: Text(
                    item.arabicName,
                    style: GoogleFonts.amiri(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 4),

                // Name & Era
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item.era,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: isDark ? Colors.white54 : Colors.grey.shade500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
