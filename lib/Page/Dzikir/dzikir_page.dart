import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/Widget/TextDataWidget.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Page/Dzikir/dzikir_data.dart';
import 'package:my_quran/Page/Dzikir/dzikir_list_tab.dart';
import 'package:my_quran/Page/Dzikir/tasbih_digital_widget.dart';

class DzikirPage extends StatefulWidget {
  final int initialTabIndex;
  const DzikirPage({super.key, this.initialTabIndex = 0});

  @override
  State<DzikirPage> createState() => _DzikirPageState();
}

class _DzikirPageState extends State<DzikirPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          text: "Dzikir & Tasbih",
          size: 20,
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF242424) : const Color(0xFFF0EDF7),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: mainColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: isDark ? Colors.white60 : Colors.black54,
              labelStyle: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.touch_app_rounded, size: 16),
                        SizedBox(width: 6),
                        Text("Tasbih"),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.wb_sunny_rounded, size: 16),
                        SizedBox(width: 6),
                        Text("Pagi"),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.nights_stay_rounded, size: 16),
                        SizedBox(width: 6),
                        Text("Petang"),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.mosque_rounded, size: 16),
                        SizedBox(width: 6),
                        Text("Setelah Shalat"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TasbihDigitalWidget(),
          DzikirListTab(
            listDzikir: DzikirData.listDzikirPagi,
            title: "Dzikir Pagi Sesuai Sunnah",
            description: "Dibaca setelah shalat Subuh hingga matahari terbit atau siang hari.",
          ),
          DzikirListTab(
            listDzikir: DzikirData.listDzikirPetang,
            title: "Dzikir Petang Sesuai Sunnah",
            description: "Dibaca setelah shalat Ashar hingga menjelang shalat Isya.",
          ),
          DzikirListTab(
            listDzikir: DzikirData.listDzikirSetelahShalat,
            title: "Dzikir Setelah Shalat Fardhu",
            description: "Wirid dan dzikir yang dicontohkan Rasulullah SAW seusai shalat fardhu.",
          ),
        ],
      ),
    );
  }
}
