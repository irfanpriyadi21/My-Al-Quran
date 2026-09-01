import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:my_quran/Componen/News/NewsWidget.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Page/Alquran/AlQuran.dart';
import 'package:my_quran/Page/Dashboard/menu_lainnya_modal.dart';
import 'package:my_quran/Page/Doa/doa_harian_page.dart';
import 'package:my_quran/Page/Dzikir/dzikir_page.dart';
import 'package:my_quran/Page/Hadits/hadits_page.dart';
import 'package:my_quran/Page/Kiblat/kiblat_page.dart';
import 'package:my_quran/Page/Masjid/nearby_mosque_page.dart';
import 'package:my_quran/Page/Shalat/jadwal_shalat_page.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Page/Quotes/quotes_islami_page.dart';
import 'package:my_quran/Utils/quotes_islami_data.dart';
import '../../Componen/Widget/MenuComponenWidget.dart';
import '../../Componen/Widget/RealtimeClockWidget.dart';
import '../../Componen/Widget/TextDataWidget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final hijri = HijriCalendar.now();
  final List menus = [
    {
      "image": "assets/image/alQuran.png",
      "title": "Al-Quran",
      "page": const AlQuran(),
    },
    {
      "image": "assets/image/doa.png",
      "title": "Doa Harian",
      "page": const DoaHarianPage(),
    },
    {
      "image": "assets/image/Qibla.png",
      "title": "Kiblat",
      "page": const KiblatPage(),
    },
    {
      "image": "assets/image/book.png",
      "title": "Hadits",
      "page": const HaditsPage(),
    },
    {
      "image": "assets/image/shalat.png",
      "title": "Jadwal Shalat",
      "page": const JadwalShalatPage(),
    },
    {
      "image": "assets/image/tasbih.png",
      "title": "Dzikir",
      "page": const DzikirPage(),
    },
    {
      "image": "assets/image/mosque.png",
      "title": "Masjid Terdekat",
      "page": const NearbyMosquePage(),
    },
    {
      "image": "assets/image/other.png",
      "title": "Lainnya",
      "action": (BuildContext ctx) => MenuLainnyaModal.show(ctx),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: user?.photoURL != null
                                ? NetworkImage(user!.photoURL!)
                                : null,
                            backgroundColor: isDark
                                ? const Color(0xFF2C2C2C)
                                : Colors.grey[300],
                            child: user?.photoURL == null
                                ? const Icon(
                                    Icons.person,
                                    size: 20,
                                    color: mainColor,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextData(
                                text: "Hi, ${user?.displayName ?? "Pengguna"}",
                                size: 13,
                                color: isDark
                                    ? Colors.white70
                                    : Colors.grey[700]!,
                                fontWeight: FontWeight.normal,
                              ),
                              TextData(
                                text: user?.email ?? "",
                                size: 10,
                                color: isDark
                                    ? Colors.white60
                                    : Colors.grey[700]!,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.notifications_none,
                      color: isDark ? Colors.white70 : Colors.grey[700],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextData(
                            text: "My Alquran Mobile App",
                            size: 22,
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 6),
                          const TextData(
                            text: "Baca Al-Quran Dengan Mudah",
                            size: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 20),
                          const RealtimeClock(),
                          const SizedBox(height: 4),
                          TextData(
                            text:
                                "${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} H",
                            size: 13,
                            color: isDark ? Colors.white60 : Colors.black45,
                            fontWeight: FontWeight.normal,
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                    Image.asset("assets/image/image1.png", height: 150),
                  ],
                ),

                const SizedBox(height: 30),

                const TextData(
                  text: "Menu",
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 16),
                GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.78,
                  ),
                  controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: menus.map((e) {
                    return GestureDetector(
                      onTap: () {
                        if (e['action'] != null) {
                          e['action'](context);
                        } else if (e['page'] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => e['page']),
                          );
                        }
                      },
                      child: MenuComponent(e['image'], e['title'], ""),
                    );
                  }).toList(),
                ),
                 const SizedBox(height: 20),

                // Islamic Quotes Quick Banner
                Builder(
                  builder: (context) {
                    final quoteOfTheDay = QuotesIslamiData.getQuoteOfTheDay();
                    final gradientColors = quoteOfTheDay.gradientColors
                        .map((c) => Color(c))
                        .toList();

                    return Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuotesIslamiPage(
                                initialQuote: quoteOfTheDay,
                              ),
                            ),
                          );
                        },
                        child: Ink(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: gradientColors.first.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.format_quote_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Kata Mutiara Islami",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white70,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "\"${quoteOfTheDay.quote}\"",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: Colors.white.withValues(alpha: 0.9),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "— ${quoteOfTheDay.source}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white70,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                ),

                const SizedBox(height: 24),
                const TextData(
                  text: "News",
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 16),
                const NewsWidget(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
