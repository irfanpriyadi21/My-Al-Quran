import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Utils/hijaiyah_data.dart';

class BelajarHijaiyahPage extends StatefulWidget {
  const BelajarHijaiyahPage({super.key});

  @override
  State<BelajarHijaiyahPage> createState() => _BelajarHijaiyahPageState();
}

class _BelajarHijaiyahPageState extends State<BelajarHijaiyahPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _selectedMakhraj = 'all';
  int _displayMode = 0; // 0: Asli, 1: Fathah (A), 2: Kasrah (I), 3: Dhammah (U)

  // Quiz State
  int _currentQuestionIndex = 0;
  int _quizScore = 0;
  bool _isAnswerChecked = false;
  int? _selectedAnswerIndex;
  late List<_QuizQuestion> _quizQuestions;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _generateQuizQuestions();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _generateQuizQuestions() {
    final random = Random();
    final allLetters = List<ModelHijaiyah>.from(HijaiyahData.list)..shuffle(random);
    final selectedLetters = allLetters.take(10).toList();

    _quizQuestions = selectedLetters.map((targetLetter) {
      final questionType = random.nextInt(3); // 0: Tebak Latin, 1: Tebak Arab, 2: Tebak Harakat
      final options = <String>[];
      int correctIndex = 0;
      String prompt = '';
      String questionArabic = '';

      if (questionType == 0) {
        prompt = "Huruf di bawah ini dibaca apa?";
        questionArabic = targetLetter.arabic;
        options.add(targetLetter.name);

        final wrongPool = HijaiyahData.list
            .where((l) => l.number != targetLetter.number)
            .toList()
          ..shuffle(random);
        for (var i = 0; i < 3; i++) {
          options.add(wrongPool[i].name);
        }
      } else if (questionType == 1) {
        prompt = "Manakah huruf Arab untuk '${targetLetter.name}'?";
        questionArabic = targetLetter.name;
        options.add(targetLetter.arabic);

        final wrongPool = HijaiyahData.list
            .where((l) => l.number != targetLetter.number)
            .toList()
          ..shuffle(random);
        for (var i = 0; i < 3; i++) {
          options.add(wrongPool[i].arabic);
        }
      } else {
        final harakatType = random.nextInt(3); // 0: Fathah, 1: Kasrah, 2: Dhammah
        if (harakatType == 0) {
          prompt = "Huruf ini berharakat Fathah, bagaimana bunyinya?";
          questionArabic = targetLetter.fathah;
          options.add(targetLetter.fathahRead);
          options.add(targetLetter.kasrahRead);
          options.add(targetLetter.dhammahRead);
          options.add("${targetLetter.fathahRead}n");
        } else if (harakatType == 1) {
          prompt = "Huruf ini berharakat Kasrah, bagaimana bunyinya?";
          questionArabic = targetLetter.kasrah;
          options.add(targetLetter.kasrahRead);
          options.add(targetLetter.fathahRead);
          options.add(targetLetter.dhammahRead);
          options.add("${targetLetter.kasrahRead}n");
        } else {
          prompt = "Huruf ini berharakat Dhammah, bagaimana bunyinya?";
          questionArabic = targetLetter.dhammah;
          options.add(targetLetter.dhammahRead);
          options.add(targetLetter.fathahRead);
          options.add(targetLetter.kasrahRead);
          options.add("${targetLetter.dhammahRead}n");
        }
      }

      final correctOption = options[0];
      options.shuffle(random);
      correctIndex = options.indexOf(correctOption);

      return _QuizQuestion(
        prompt: prompt,
        questionArabic: questionArabic,
        options: options,
        correctIndex: correctIndex,
        explanation:
            "Huruf '${targetLetter.name}' (${targetLetter.arabic}) berbunyi ${targetLetter.fathahRead} / ${targetLetter.kasrahRead} / ${targetLetter.dhammahRead}. Makhraj: ${targetLetter.makhraj}.",
      );
    }).toList();

    _currentQuestionIndex = 0;
    _quizScore = 0;
    _isAnswerChecked = false;
    _selectedAnswerIndex = null;
  }

  List<ModelHijaiyah> get _filteredLetters {
    return HijaiyahData.list.where((item) {
      final matchesMakhraj =
          _selectedMakhraj == 'all' || item.categoryMakhraj == _selectedMakhraj;
      final q = _searchQuery.toLowerCase().trim();
      final matchesSearch = q.isEmpty ||
          item.name.toLowerCase().contains(q) ||
          item.latin.toLowerCase().contains(q) ||
          item.arabic.contains(q) ||
          item.makhraj.toLowerCase().contains(q);
      return matchesMakhraj && matchesSearch;
    }).toList();
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
        title: Text(
          "Belajar Huruf Hijaiyah",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: mainColor,
          unselectedLabelColor: isDark ? Colors.white60 : Colors.grey.shade600,
          labelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          indicatorColor: mainColor,
          indicatorWeight: 3,
          isScrollable: true,
          tabs: const [
            Tab(text: "Huruf Hijaiyah"),
            Tab(text: "Harakat & Tanda"),
            Tab(text: "Bentuk Sambung"),
            Tab(text: "Kuis Interaktif"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHijaiyahTab(isDark, cardColor),
          _buildHarakatTab(isDark, cardColor),
          _buildConnectedTab(isDark, cardColor),
          _buildQuizTab(isDark, cardColor),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 1: HURUF HIJAIYAH (GRID VIEW)
  // ==========================================
  Widget _buildHijaiyahTab(bool isDark, Color cardColor) {
    final letters = _filteredLetters;

    return Column(
      children: [
        // Controls: Search + Display Mode + Filter Chips
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(18)),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black26
                    : Colors.grey.withValues(alpha: 0.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Box
              TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: "Cari huruf, nama (Alif, Ba, Ta...), makhraj...",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isDark ? Colors.white38 : Colors.grey.shade400,
                  ),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: mainColor, size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: isDark
                      ? const Color(0xFF2C2C2C)
                      : const Color(0xFFF5F6FA),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Harakat Mode Switcher
              Row(
                children: [
                  Text(
                    "Bunyi Vokal: ",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white60 : Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildModeChip(0, "Asli (Tunggal)", isDark),
                          const SizedBox(width: 6),
                          _buildModeChip(1, "Fathah (A)", isDark),
                          const SizedBox(width: 6),
                          _buildModeChip(2, "Kasrah (I)", isDark),
                          const SizedBox(width: 6),
                          _buildModeChip(3, "Dhammah (U)", isDark),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Makhraj Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: HijaiyahData.makhrajCategories.map((cat) {
                    final isSelected = _selectedMakhraj == cat['id'];
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        label: Text(cat['name']!),
                        selected: isSelected,
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? Colors.white
                              : (isDark ? Colors.white70 : Colors.grey.shade700),
                        ),
                        selectedColor: mainColor,
                        backgroundColor: isDark
                            ? const Color(0xFF2C2C2C)
                            : Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: isSelected
                                ? mainColor
                                : (isDark
                                    ? Colors.white10
                                    : Colors.grey.shade300),
                          ),
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedMakhraj = cat['id']!);
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        // Result Count Banner
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Daftar Huruf Hijaiyah",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              Text(
                "${letters.length} Huruf",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: mainColor,
                ),
              ),
            ],
          ),
        ),

        // Grid of Hijaiyah Cards
        Expanded(
          child: letters.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off_rounded,
                          size: 48,
                          color: isDark ? Colors.white24 : Colors.grey.shade300),
                      const SizedBox(height: 10),
                      Text(
                        "Huruf tidak ditemukan",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: isDark ? Colors.white60 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  itemCount: letters.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (context, index) {
                    final item = letters[index];
                    return _buildHijaiyahCard(item, isDark);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildModeChip(int modeIndex, String label, bool isDark) {
    final isSelected = _displayMode == modeIndex;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => setState(() => _displayMode = modeIndex),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? mainColor.withValues(alpha: 0.15)
              : (isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEFEFF2)),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? mainColor : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? mainColor
                : (isDark ? Colors.white60 : Colors.grey.shade700),
          ),
        ),
      ),
    );
  }

  Widget _buildHijaiyahCard(ModelHijaiyah item, bool isDark) {
    String displayArabic;
    String displayRead;

    switch (_displayMode) {
      case 1:
        displayArabic = item.fathah;
        displayRead = item.fathahRead;
        break;
      case 2:
        displayArabic = item.kasrah;
        displayRead = item.kasrahRead;
        break;
      case 3:
        displayArabic = item.dhammah;
        displayRead = item.dhammahRead;
        break;
      default:
        displayArabic = item.arabic;
        displayRead = item.name;
        break;
    }

    return Material(
      color: isDark ? const Color(0xFF242424) : Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: isDark ? 0 : 2,
      shadowColor: Colors.grey.withValues(alpha: 0.12),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _showDetailModal(item),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark
                  ? const Color(0xFF333333)
                  : Colors.grey.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Number & Sound Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: mainColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${item.number}",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: isDark ? Colors.white30 : Colors.grey.shade400,
                  ),
                ],
              ),

              // Big Calligraphy Letter (Expanded to safely fill available space)
              Expanded(
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      displayArabic,
                      style: GoogleFonts.amiri(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF212121),
                        height: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              // Letter Name & Latin
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    displayRead,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.latin,
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
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
    );
  }

  // ==========================================
  // DETAIL MODAL HIJAIYAH
  // ==========================================
  void _showDetailModal(ModelHijaiyah item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.88,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 14,
              bottom: MediaQuery.of(context).padding.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color:
                            isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Header Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: mainColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Huruf Ke-${item.number} dari 30",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close_rounded, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Calligraphy Showcase Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
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
                          item.arabic,
                          style: GoogleFonts.amiri(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          item.name,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Transliterasi Latin: [ ${item.latin} ]",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Harakat Showcase Row (A - I - U)
                  Text(
                    "Bunyi Harakat (Vokal Dasar)",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildHarakatSoundCard(
                          harakatName: "Fathah (ـَ)",
                          arabic: item.fathah,
                          sound: item.fathahRead,
                          color: const Color(0xFF4CAF50),
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildHarakatSoundCard(
                          harakatName: "Kasrah (ـِ)",
                          arabic: item.kasrah,
                          sound: item.kasrahRead,
                          color: const Color(0xFF2196F3),
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildHarakatSoundCard(
                          harakatName: "Dhammah (ـُ)",
                          arabic: item.dhammah,
                          sound: item.dhammahRead,
                          color: const Color(0xFFFF9800),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Posisi Bentuk Sambung
                  Text(
                    "Bentuk Penulisan Sambung",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF282828)
                          : const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF383838)
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPositionItem("Tunggal", item.isolated, isDark),
                        _buildPositionDivider(isDark),
                        _buildPositionItem("Awal", item.initial, isDark),
                        _buildPositionDivider(isDark),
                        _buildPositionItem("Tengah", item.medial, isDark),
                        _buildPositionDivider(isDark),
                        _buildPositionItem("Akhir", item.finalForm, isDark),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Contoh Kata dalam Al-Qur'an
                  Text(
                    "Contoh Kata dalam Bahasa Arab",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF282828)
                          : const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: mainColor.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.menu_book_rounded,
                              color: mainColor, size: 20),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.exampleWord,
                                style: GoogleFonts.amiri(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor,
                                ),
                              ),
                              Text(
                                "Arti: ${item.exampleMeaning}",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Makhraj & Sifat Huruf
                  Text(
                    "Makhorijul & Sifat Huruf",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF282828)
                          : const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.record_voice_over_rounded,
                                color: Color(0xFF3F51B5), size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item.makhraj,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.makhrajDesc,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: isDark ? Colors.white70 : Colors.grey.shade700,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(
                            color: isDark ? Colors.white12 : Colors.grey.shade200,
                            height: 1),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sifat Huruf: ",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: mainColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item.sifat,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHarakatSoundCard({
    required String harakatName,
    required String arabic,
    required String sound,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF282828) : const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color.withValues(alpha: isDark ? 0.35 : 0.25),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            harakatName,
            style: GoogleFonts.poppins(
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            arabic,
            style: GoogleFonts.amiri(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            sound,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white70 : Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionItem(String label, String arabic, bool isDark) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: isDark ? Colors.white54 : Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          arabic,
          style: GoogleFonts.amiri(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPositionDivider(bool isDark) {
    return Container(
      width: 1,
      height: 28,
      color: isDark ? Colors.white12 : Colors.grey.shade300,
    );
  }

  // ==========================================
  // TAB 2: HARAKAT & TANDA BACA
  // ==========================================
  Widget _buildHarakatTab(bool isDark, Color cardColor) {
    final list = HijaiyahData.harakatList;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Symbol Calligraphy Circle
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: mainColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  item.symbol,
                  style: GoogleFonts.amiri(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Description Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.sound,
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: isDark ? Colors.white70 : Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF2C2C2C)
                            : const Color(0xFFF7F8FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Contoh: ${item.exampleLatin}",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? Colors.white60
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item.exampleArabic,
                            style: GoogleFonts.amiri(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================
  // TAB 3: BENTUK SAMBUNG
  // ==========================================
  Widget _buildConnectedTab(bool isDark, Color cardColor) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Guide Info Card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFB176F2), mainColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
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
              Row(
                children: [
                  const Icon(Icons.lightbulb_outline_rounded,
                      color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "Kaidah Penulisan Huruf Sambung",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "Sebagian besar huruf hijaiyah berubah bentuk saat berada di posisi Awal, Tengah, atau Akhir kata. "
                "Terdapat 6 huruf yang TIDAK BISA disambung ke huruf setelahnya: (ا, د, ذ, ر, ز, و).",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Table of Letters & Shapes
        Container(
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
          child: Column(
            children: [
              // Table Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF2C2C2C)
                      : const Color(0xFFF5F6FA),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(18)),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text("Huruf",
                            style: _headerStyle(isDark))),
                    Expanded(
                        flex: 2,
                        child: Text("Tunggal",
                            style: _headerStyle(isDark),
                            textAlign: TextAlign.center)),
                    Expanded(
                        flex: 2,
                        child: Text("Awal",
                            style: _headerStyle(isDark),
                            textAlign: TextAlign.center)),
                    Expanded(
                        flex: 2,
                        child: Text("Tengah",
                            style: _headerStyle(isDark),
                            textAlign: TextAlign.center)),
                    Expanded(
                        flex: 2,
                        child: Text("Akhir",
                            style: _headerStyle(isDark),
                            textAlign: TextAlign.center)),
                  ],
                ),
              ),

              // Rows
              ...HijaiyahData.list.map((item) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isDark
                            ? const Color(0xFF303030)
                            : Colors.grey.shade100,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              item.latin,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: isDark
                                    ? Colors.white54
                                    : Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          item.isolated,
                          style: GoogleFonts.amiri(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          item.initial,
                          style: GoogleFonts.amiri(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          item.medial,
                          style: GoogleFonts.amiri(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          item.finalForm,
                          style: GoogleFonts.amiri(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle _headerStyle(bool isDark) {
    return GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: isDark ? Colors.white70 : Colors.grey.shade800,
    );
  }

  // ==========================================
  // TAB 4: KUIS INTERAKTIF
  // ==========================================
  Widget _buildQuizTab(bool isDark, Color cardColor) {
    final currentQ = _quizQuestions[_currentQuestionIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Progress & Score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: mainColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Soal ${_currentQuestionIndex + 1} dari ${_quizQuestions.length}",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Color(0xFF4CAF50), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "Skor: $_quizScore",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Linear Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _quizQuestions.length,
              backgroundColor: isDark
                  ? const Color(0xFF333333)
                  : Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(mainColor),
              minHeight: 6,
            ),
          ),

          const SizedBox(height: 24),

          // Question Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFB176F2), mainColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: mainColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  currentQ.prompt,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  currentQ.questionArabic,
                  style: GoogleFonts.amiri(
                    fontSize: 54,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Option Buttons (A, B, C, D)
          ...List.generate(currentQ.options.length, (index) {
            final optionText = currentQ.options[index];
            final isSelected = _selectedAnswerIndex == index;
            final isCorrect = index == currentQ.correctIndex;

            Color optionBg = isDark ? const Color(0xFF242424) : Colors.white;
            Color borderColor = isDark
                ? const Color(0xFF333333)
                : Colors.grey.withValues(alpha: 0.2);
            Color textColor = isDark ? Colors.white : Colors.black87;

            if (_isAnswerChecked) {
              if (isCorrect) {
                optionBg = const Color(0xFF4CAF50).withValues(alpha: 0.18);
                borderColor = const Color(0xFF4CAF50);
                textColor = const Color(0xFF2E7D32);
              } else if (isSelected) {
                optionBg = const Color(0xFFF44336).withValues(alpha: 0.18);
                borderColor = const Color(0xFFF44336);
                textColor = const Color(0xFFC62828);
              }
            } else if (isSelected) {
              optionBg = mainColor.withValues(alpha: 0.12);
              borderColor = mainColor;
              textColor = mainColor;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: optionBg,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: _isAnswerChecked
                      ? null
                      : () {
                          setState(() {
                            _selectedAnswerIndex = index;
                            _isAnswerChecked = true;
                            if (index == currentQ.correctIndex) {
                              _quizScore += 10;
                            }
                          });
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: borderColor.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            String.fromCharCode(65 + index), // A, B, C, D
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            optionText,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),
                        if (_isAnswerChecked)
                          Icon(
                            isCorrect
                                ? Icons.check_circle_rounded
                                : (isSelected
                                    ? Icons.cancel_rounded
                                    : Icons.circle_outlined),
                            color: isCorrect
                                ? const Color(0xFF4CAF50)
                                : (isSelected
                                    ? const Color(0xFFF44336)
                                    : Colors.transparent),
                            size: 22,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 12),

          // Feedback Explanation & Next Button
          if (_isAnswerChecked) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2C2C2C)
                    : const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark ? Colors.white12 : Colors.grey.shade200,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _selectedAnswerIndex == currentQ.correctIndex
                            ? Icons.check_circle_outline_rounded
                            : Icons.info_outline_rounded,
                        color: _selectedAnswerIndex == currentQ.correctIndex
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFF44336),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _selectedAnswerIndex == currentQ.correctIndex
                            ? "Benar Sekali!"
                            : "Kurang Tepat",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _selectedAnswerIndex == currentQ.correctIndex
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFF44336),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentQ.explanation,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: isDark ? Colors.white70 : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  if (_currentQuestionIndex + 1 < _quizQuestions.length) {
                    setState(() {
                      _currentQuestionIndex++;
                      _isAnswerChecked = false;
                      _selectedAnswerIndex = null;
                    });
                  } else {
                    _showQuizResultDialog();
                  }
                },
                child: Text(
                  _currentQuestionIndex + 1 < _quizQuestions.length
                      ? "Lanjut ke Soal Berikutnya"
                      : "Lihat Hasil Kuis",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showQuizResultDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalQuestions = _quizQuestions.length;
    final correctCount = _quizScore ~/ 10;
    final isPerfect = correctCount == totalQuestions;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF242424) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: isPerfect
                      ? const Color(0xFF4CAF50).withValues(alpha: 0.15)
                      : mainColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPerfect ? Icons.emoji_events_rounded : Icons.thumb_up_rounded,
                  color: isPerfect ? const Color(0xFF4CAF50) : mainColor,
                  size: 38,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isPerfect ? "Luar Biasa! Nilai Sempurna" : "Kuis Selesai!",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                "Kamu berhasil menjawab $correctCount dari $totalQuestions soal dengan benar.",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isDark ? Colors.white60 : Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF2C2C2C)
                      : const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Total Skor: $_quizScore Poin",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        setState(() {
                          _generateQuizQuestions();
                        });
                      },
                      child: Text(
                        "Ulangi Kuis",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        _tabController.animateTo(0);
                      },
                      child: Text(
                        "Belajar Lagi",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuizQuestion {
  final String prompt;
  final String questionArabic;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const _QuizQuestion({
    required this.prompt,
    required this.questionArabic,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}
