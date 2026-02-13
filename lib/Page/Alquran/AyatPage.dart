import 'package:flutter/material.dart';

import '../../Componen/Widget/VerseTileWidget.dart';



class AyatPage extends StatefulWidget {
  final int id;
  final String name;
  final String jumlahAyat;
  final String tempatTurun;
  final String arti;
  const AyatPage(this.id, this.name, this.jumlahAyat, this.tempatTurun, this.arti,
      {super.key});

  @override
  State<AyatPage> createState() => _AyatPageState();
}

class _AyatPageState extends State<AyatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, color: Colors.grey),
                  Text(
                    "${widget.name}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6A35D4),
                    ),
                  ),
                  Icon(Icons.search, color: Colors.grey),
                ],
              ),

              const SizedBox(height: 20),

              // CARD SURAH
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffC58AF9),
                      Color(0xff7B3FE4),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "${widget.name}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "${widget.arti}",
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.white38),
                    SizedBox(height: 10),
                    Text(
                      "${widget.tempatTurun} • ${widget.jumlahAyat} Ayat",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "بِسْمِ ٱللّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: [
                    VerseTile(
                      number: 1,
                      arabic: "ٱلْحَمْدُ لِلَّٰهِ رَبِّ ٱلْعَٰلَمِينَ",
                      translation:
                      "[All] praise is [due] to Allah, Lord of the worlds –",
                      audioUrl: "https://cdn.equran.id/audio-partial/Abdullah-Al-Juhany/001001.mp3",
                    ),
                    SizedBox(height: 16),
                    VerseTile(
                      number: 2,
                      arabic: "ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
                      translation:
                      "The Entirely Merciful, the Especially Merciful,",
                      audioUrl: "https://cdn.equran.id/audio-partial/Abdullah-Al-Juhany/001001.mp3",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
