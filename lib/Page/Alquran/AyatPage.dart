import 'package:flutter/material.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/ModelListAyat.dart';
import 'package:my_quran/Page/Alquran/AlQuran.dart';
import 'package:provider/provider.dart';

import '../../Componen/Widget/TextDataWidget.dart';
import '../../Componen/Widget/VerseTileWidget.dart';
import '../../Componen/alert.dart';
import '../../Model/string_http_exception.dart';
import '../../Provider/Surah/LastReadService.dart';
import '../../Provider/Surah/SurahApi.dart';



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
  final ScrollController _scrollController = ScrollController();
  int lastVisibleAyat = 1;
  ModelListAyat listAyat = ModelListAyat();
  bool isLoading = false;
  int? savedAyat;

  getAyat()async{
    setState(() {
      isLoading = true;
    });
    try {
      listAyat = await Provider.of<SurahApi>(context, listen: false).getAyat(widget.id);
    } on StringHttpException catch (e) {
      var errorMessage = e.toString();
      AlertFail(errorMessage);
    } catch (error, s) {
      print(error);
      print(s.toString());
      AlertFail("Terjadi Kesalahan !! $s");
    }
    setState(() {
      isLoading = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 300));
      scrollToLastAyat();
    });
  }

  Future<void> initPage() async {
    await loadLastRead();
    await getAyat();
  }

  scrollToLastAyat() {
    if (savedAyat != null && savedAyat! > 1) {

      double position = (savedAyat! - 1) * 250;

      _scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onScroll() {
    double offset = _scrollController.offset;

    int currentAyat = (offset / 350).floor() + 1;

    final totalAyat = listAyat.ayat?.length ?? 0;

    if (currentAyat > totalAyat) {
      currentAyat = totalAyat;
    }

    if (currentAyat != lastVisibleAyat && currentAyat > 0) {
      lastVisibleAyat = currentAyat;

      LastReadService.saveLastRead(
        id: widget.id,
        name: widget.name,
        jumlahAyat: widget.jumlahAyat,
        tempatTurun: widget.tempatTurun,
        arti: widget.arti,
        ayat: currentAyat,
      );
    }
  }


  loadLastRead() async {
    final data = await LastReadService.getLastRead();

    if (data != null && data["id"] == widget.id.toString()) {
      savedAyat = data["ayat"];
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAyat();
    _scrollController.addListener(_onScroll);
    initPage();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AlQuran()
            )
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
            children: [

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlQuran()
                          )
                      );
                    },
                    child: Icon(Icons.arrow_back, color: mainColor),
                  ),
                  TextData(
                    text: widget.name,
                    size: 20,
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(),
                ],
              ),

              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 250,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    // BACKGROUND IMAGE
                    Positioned(
                      right: -10,
                      bottom: -10,
                      child: Opacity(
                        opacity: 1, // penting supaya samar
                        child: Image.asset(
                          "assets/image/Quran2.png",
                          width: 250,
                        ),
                      ),
                    ),

                    // GRADIENT OVERLAY
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffC58AF9).withOpacity(0.85),
                              Color(0xff7B3FE4).withOpacity(0.85),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20),
                        TextData(
                          text:  "${widget.name}",
                          size: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 6),
                        TextData(
                          text:  "${widget.arti}",
                          size: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.white38),
                        SizedBox(height: 10),
                        TextData(
                          text:   "${widget.tempatTurun} • ${widget.jumlahAyat} Ayat",
                          size: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(height: 20),
                        TextData(
                          text:   "بِسْمِ ٱللّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
                          size: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),

              /// LIST AYAT
              ...List.generate(
                listAyat.ayat?.length ?? 0,
                    (index) {
                  final datas = listAyat.ayat![index];

                  return VerseTile(
                    number: datas.nomorAyat!,
                    arabic: datas.teksArab!,
                    translation: datas.teksIndonesia!,
                    latin: datas.teksLatin!,
                    audioUrl: datas.audio!.s01!,
                    surah: widget.name,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
