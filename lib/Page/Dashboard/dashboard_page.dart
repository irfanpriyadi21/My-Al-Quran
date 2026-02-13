import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:my_quran/Componen/Widget/CaegoryChipWidget.dart';
import 'package:my_quran/Componen/Widget/SurahCardWidget.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Page/Alquran/AlQuran.dart';
import 'package:my_quran/Provider/Surah/SurahApi.dart';
import 'package:provider/provider.dart';

import '../../Componen/Widget/MenuComponenWidget.dart';
import '../../Componen/Widget/RealtimeClockWidget.dart';
import '../../Componen/Widget/TextDataWidget.dart';
import '../../Componen/alert.dart';
import '../../Model/ModelListSurah.dart';
import '../../Model/string_http_exception.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final hijri = HijriCalendar.now();
  List menus = [
    {
      "image" : "assets/image/alQuran.png",
      "title" : "Al-Quran",
      "page" : const AlQuran()
    },
    {
      "image" : "assets/image/alQuran.png",
      "title" : "Doa Harian",
      "page" : const AlQuran()
    },
    {
      "image" : "assets/image/alQuran.png",
      "title" : "Kiblat",
      "page" : const AlQuran()
    },
    {
      "image" : "assets/image/alQuran.png",
      "title" : "Hadits",
      "page" : const AlQuran()
    },
    {
      "image" : "assets/image/alQuran.png",
      "title" : "Waktu Sholat",
      "page" : const AlQuran()
    },
    {
      "image" : "assets/image/alQuran.png",
      "title" : "Imasakiyah",
      "page" : const AlQuran()
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
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
                            backgroundImage: NetworkImage(
                              FirebaseAuth.instance.currentUser!.photoURL!,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextData(
                                text: "Hi, ${FirebaseAuth.instance.currentUser!.displayName ?? ""}",
                                size: 13,
                                color: Colors.grey[700]!,
                                fontWeight: FontWeight.normal,
                              ),
                              TextData(
                                text: FirebaseAuth.instance.currentUser!.email ?? "",
                                size: 10,
                                color: Colors.grey[700]!,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Icon(
                      Icons.notifications_none,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextData(
                            text: "My Quran",
                            size: 24,
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 6),
                          TextData(
                            text: "Baca Al-Quran Dengan Mudah",
                            size: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 20),
                          RealtimeClock(),
                          const SizedBox(height: 4),
                          TextData(
                            text: "${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} H",
                            size: 13,
                            color: Colors.black45,
                            fontWeight: FontWeight.normal,
                          ),
                          const SizedBox(height: 12),

                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/image/image1.png",
                      height: 150,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                TextData(
                  text: "Menu",
                  size: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 16),
                GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 1,
                  ),
                  controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: menus.map((e){
                    return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => e['page']
                              )
                          );
                        },
                        child:
                        MenuComponent(
                            e['image'],
                            e['title'],
                            ""
                        ));
                  }).toList(),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
