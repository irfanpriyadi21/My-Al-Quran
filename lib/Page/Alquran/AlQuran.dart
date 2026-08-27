import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Page/Alquran/AyatPage.dart';
import 'package:my_quran/Page/indexPage.dart';
import 'package:provider/provider.dart';

import '../../Componen/Widget/SurahCardWidget.dart';
import '../../Componen/Widget/TextDataWidget.dart';
import '../../Componen/alert.dart';
import '../../Componen/colors.dart';
import '../../Model/ModelListSurah.dart';
import '../../Model/string_http_exception.dart';
import '../../Provider/Surah/LastReadService.dart';
import '../../Provider/Surah/SurahApi.dart';

class AlQuran extends StatefulWidget {
  const AlQuran({super.key});

  @override
  State<AlQuran> createState() => _AlQuranState();
}

class _AlQuranState extends State<AlQuran> {
  List<ModelListSurah> listSurah = [];
  Map<String, dynamic>? lastRead;
  bool isLoading = false;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Makkiyyah',
    'Madaniyyah',
    'Juz 30',
  ];

  void loadLastRead() async {
    final data = await LastReadService.getLastRead();
    if (mounted) {
      setState(() {
        lastRead = data;
      });
    }
  }

  Future<void> getSurah() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<SurahApi>(context, listen: false).getSurah();
    } on StringHttpException catch (e) {
      var errorMessage = e.toString();
      AlertFail(errorMessage);
    } catch (error, s) {
      debugPrint("Error getSurah: $error \n $s");
      AlertFail("Terjadi Kesalahan !! $s");
    }
    if (mounted) {
      setState(() {
        listSurah = Provider.of<SurahApi>(context, listen: false).listSurah;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSurah();
    loadLastRead();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ModelListSurah> get _filteredSurahList {
    return listSurah.where((surah) {
      // Category filter
      if (_selectedCategory == 'Makkiyyah') {
        final tempat = surah.tempatTurun?.toLowerCase() ?? '';
        if (!tempat.contains('mekah') && !tempat.contains('makkiyyah')) {
          return false;
        }
      } else if (_selectedCategory == 'Madaniyyah') {
        final tempat = surah.tempatTurun?.toLowerCase() ?? '';
        if (!tempat.contains('madinah') && !tempat.contains('madaniyyah')) {
          return false;
        }
      } else if (_selectedCategory == 'Juz 30') {
        final nomor = surah.nomor?.toInt() ?? 0;
        if (nomor < 78 || nomor > 114) {
          return false;
        }
      }

      // Query search filter
      if (_searchQuery.trim().isNotEmpty) {
        final q = _searchQuery.trim().toLowerCase();
        final nameLatin = surah.namaLatin?.toLowerCase() ?? '';
        final arti = surah.arti?.toLowerCase() ?? '';
        final tempatTurun = surah.tempatTurun?.toLowerCase() ?? '';
        final nomorStr = surah.nomor?.toString() ?? '';

        final matchName = nameLatin.contains(q);
        final matchArti = arti.contains(q);
        final matchTempat = tempatTurun.contains(q);
        final matchNomor = nomorStr == q || nomorStr.startsWith(q);

        return matchName || matchArti || matchTempat || matchNomor;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final filtered = _filteredSurahList;
    final bool isSearching = _searchQuery.isNotEmpty || _selectedCategory != 'Semua';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const IndexPage()),
        );
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: mainColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IndexPage()),
              );
            },
          ),
          backgroundColor: cardColor,
          title: TextData(
            text: "Al-Quran",
            size: 20,
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Search Bar
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
                        hintText: "Cari surat (nama, nomor, atau arti)...",
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
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Category Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories.map((cat) {
                        final isSelected = _selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              setState(() {
                                _selectedCategory = cat;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? mainColor
                                    : (isDark ? const Color(0xFF242424) : Colors.grey.shade100),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? mainColor
                                      : (isDark ? Colors.white12 : Colors.transparent),
                                ),
                              ),
                              child: Text(
                                cat,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark ? Colors.white70 : Colors.black87),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Last Read Hero Banner (Only shown when not actively searching)
                  if (!isSearching && lastRead != null) ...[
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AyatPage(
                              lastRead!['id'] is int
                                  ? lastRead!['id']
                                  : int.tryParse(lastRead!['id'].toString()) ?? 1,
                              lastRead!['name'],
                              lastRead!['jumlahAyat'],
                              lastRead!['tempatTurun'],
                              lastRead!['arti'],
                            ),
                          ),
                        );
                      },
                      child: Container(
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
                              color: const Color(0xff7B3FE4).withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            /// BACKGROUND QURAN IMAGE
                            Positioned(
                              right: -30,
                              bottom: -20,
                              child: Opacity(
                                opacity: 0.9,
                                child: Image.asset(
                                  "assets/image/Quran2.png",
                                  width: 160,
                                ),
                              ),
                            ),

                            /// CONTENT
                            Column(
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
                                      text: "Terakhir Dibaca",
                                      size: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                TextData(
                                  text: "${lastRead!['name']}",
                                  size: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(height: 4),
                                TextData(
                                  text: "Ayat No : ${lastRead!['ayat']}",
                                  size: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Filter Result Counter (when searching)
                  if (isSearching) ...[
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Menampilkan ${filtered.length} surat",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          if (_searchQuery.isNotEmpty || _selectedCategory != 'Semua')
                            InkWell(
                              onTap: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                  _selectedCategory = 'Semua';
                                });
                              },
                              child: Text(
                                "Reset Filter",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],

                  // Content: Loading, Empty State, or List of Surah
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 60),
                      child: Center(
                        child: CircularProgressIndicator(color: mainColor),
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
                                Icons.search_off_rounded,
                                size: 54,
                                color: mainColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Surat Tidak Ditemukan",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Coba gunakan kata kunci nama atau nomor surat lainnya",
                              textAlign: TextAlign.center,
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
                      padding: const EdgeInsets.only(top: 14, bottom: 30),
                      shrinkWrap: true,
                      itemCount: filtered.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final datas = filtered[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AyatPage(
                                  datas.nomor!.toInt(),
                                  datas.namaLatin!,
                                  datas.jumlahAyat!.toString(),
                                  datas.tempatTurun!,
                                  datas.arti!,
                                ),
                              ),
                            );
                          },
                          child: SurahCard(
                            number: datas.nomor!.toInt(),
                            title: datas.namaLatin!,
                            subtitle:
                                "${datas.tempatTurun} • ${datas.jumlahAyat!} Ayat",
                            arabic: datas.nama!,
                            primaryColor: mainColor,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
