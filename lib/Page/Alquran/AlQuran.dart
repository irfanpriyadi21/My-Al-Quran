import 'package:flutter/material.dart';
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

  void loadLastRead() async {
    final data = await LastReadService.getLastRead();

    setState(() {
      lastRead = data;
    });
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
    setState(() {
      listSurah = Provider.of<SurahApi>(context, listen: false).listSurah;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSurah();
    loadLastRead();
  }

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: Theme.of(context).cardColor,
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
                  const SizedBox(height: 20),
                  lastRead != null
                      ? GestureDetector(
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
                            padding: const EdgeInsets.only(
                              left: 18,
                              top: 18,
                              bottom: 18,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xffC58AF9), Color(0xff7B3FE4)],
                              ),
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
                                    const SizedBox(height: 18),
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
                        )
                      : const SizedBox.shrink(),
                  isLoading
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: CircularProgressIndicator(color: mainColor),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          shrinkWrap: true,
                          itemCount: listSurah.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final datas = listSurah[index];
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
