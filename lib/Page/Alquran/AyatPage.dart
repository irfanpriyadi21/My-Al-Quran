import 'package:flutter/material.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/ModelListAyat.dart';
import 'package:provider/provider.dart';

import '../../Componen/Widget/TextDataWidget.dart';
import '../../Componen/Widget/VerseTileWidget.dart';
import '../../Componen/alert.dart';
import '../../Model/string_http_exception.dart';
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
  ModelListAyat listAyat = ModelListAyat();
  bool isLoading = false;

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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAyat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:SingleChildScrollView(
            child: Column(
              children: [
                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back, color: Colors.grey),
                    TextData(
                      text:  "${widget.name}",
                      size: 20,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
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
                  ),
                ),

                const SizedBox(height: 30),
                isLoading ?
                Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                )
                    : ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    shrinkWrap: true,
                    itemCount: listAyat.ayat == null ? 0 : listAyat.ayat!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index){
                      final datas = listAyat.ayat![index];
                      return VerseTile(
                        number: datas.nomorAyat!,
                        arabic: datas.teksArab!,
                        translation: datas.teksIndonesia!,
                        latin: datas.teksLatin!,
                        audioUrl: datas.audio!.s01!,
                      );
                    }
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
