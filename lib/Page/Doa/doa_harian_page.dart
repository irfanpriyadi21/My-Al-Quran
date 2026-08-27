import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/Widget/TextDataWidget.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/model_doa_harian.dart';
import 'package:my_quran/Provider/Doa/doa_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DoaHarianPage extends StatefulWidget {
  const DoaHarianPage({super.key});

  @override
  State<DoaHarianPage> createState() => _DoaHarianPageState();
}

class _DoaHarianPageState extends State<DoaHarianPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DoaProvider>(context, listen: false);
      if (provider.listDoa.isEmpty) {
        provider.getDoa();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _copyDoa(ModelDoaHarian doa) {
    final text = '''${doa.title}

${doa.arabic}

${doa.latin}

Artinya:
"${doa.translation}"

(Dibagikan dari Aplikasi My Quran)''';

    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              "Doa berhasil disalin ke clipboard",
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

  void _shareDoa(ModelDoaHarian doa) {
    final text = '''${doa.title}

${doa.arabic}

${doa.latin}

Artinya:
"${doa.translation}"

Dibagikan dari Aplikasi My Quran''';

    Share.share(text, subject: doa.title);
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
          text: "Doa Harian",
          size: 20,
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Consumer<DoaProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: mainColor),
            );
          }

          if (provider.errorMessage.isNotEmpty && provider.listDoa.isEmpty) {
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
                      onPressed: () => provider.getDoa(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Coba Lagi"),
                    ),
                  ],
                ),
              ),
            );
          }

          // Filter by search query
          final filteredList = provider.listDoa.where((doa) {
            final query = _searchQuery.toLowerCase().trim();
            if (query.isEmpty) return true;
            return doa.title.toLowerCase().contains(query) ||
                doa.latin.toLowerCase().contains(query) ||
                doa.translation.toLowerCase().contains(query);
          }).toList();

          return RefreshIndicator(
            color: mainColor,
            onRefresh: () => provider.getDoa(),
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
                      colors: [
                        Color(0xffC58AF9),
                        Color(0xff7B3FE4),
                      ],
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
                                  text: "Kumpulan Doa Pilihan",
                                  size: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const TextData(
                              text: "Doa Sehari-hari",
                              size: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 4),
                            TextData(
                              text: "${provider.listDoa.length} Doa Tersedia",
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
                          "assets/image/alQuran.png",
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
                      hintText: "Cari doa harian (contoh: makan, tidur)...",
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
                            "Doa tidak ditemukan",
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
                        const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final doa = filteredList[index];
                      return _buildDoaCard(doa, index + 1, isDark, cardColor);
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

  Widget _buildDoaCard(
      ModelDoaHarian doa, int number, bool isDark, Color cardColor) {
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
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header: Number + Title + Action buttons
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$number",
                    style: GoogleFonts.poppins(
                      color: mainColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    doa.title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.copy_rounded,
                    size: 18,
                    color: isDark ? Colors.white60 : Colors.black45,
                  ),
                  tooltip: "Salin",
                  onPressed: () => _copyDoa(doa),
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
                  onPressed: () => _shareDoa(doa),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(6),
                ),
              ],
            ),

            Divider(
              height: 24,
              thickness: 0.7,
              color: isDark ? Colors.white12 : const Color(0xFFF0F0F0),
            ),

            // Arabic Text
            if (doa.arabic.isNotEmpty) ...[
              Text(
                doa.arabic,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.amiri(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 2.0,
                  color: isDark ? Colors.white : const Color(0xFF240F4F),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Latin Text
            if (doa.latin.isNotEmpty) ...[
              Text(
                doa.latin,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  color: isDark ? const Color(0xFFD0A8FF) : mainColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Translation
            if (doa.translation.isNotEmpty) ...[
              Text(
                doa.translation,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black87,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
