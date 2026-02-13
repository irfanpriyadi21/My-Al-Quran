import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';

import '../../Componen/Widget/CaegoryChipWidget.dart';
import '../../Componen/Widget/RealtimeClockWidget.dart';
import '../../Componen/Widget/SurahCardWidget.dart';
import '../../Componen/Widget/TextDataWidget.dart';
import '../../Componen/alert.dart';
import '../../Componen/colors.dart';
import '../../Model/ModelListSurah.dart';
import '../../Model/string_http_exception.dart';
import '../../Provider/Surah/SurahApi.dart';


class AlQuran extends StatefulWidget {
  const AlQuran({super.key});

  @override
  State<AlQuran> createState() => _AlQuranState();
}

class _AlQuranState extends State<AlQuran> {
  final hijri = HijriCalendar.now();
  List<ModelListSurah> listSurah = [];
  bool isLoading = false;

  getSurah()async{
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<SurahApi>(context, listen: false).getSurah();
    } on StringHttpException catch (e) {
      var errorMessage = e.toString();
      AlertFail(errorMessage);
    } catch (error, s) {
      print(error);
      print(s.toString());
      AlertFail("Terjadi Kesalahan !! $s");
    }
    setState(() {
      listSurah = Provider.of<SurahApi>(context, listen: false).listSurah;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSurah();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextData(
          text: "Al-Quran",
          size: 20,
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                isLoading
                    ? Center(child: CircularProgressIndicator(color: mainColor,),)
                    : ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    shrinkWrap: true,
                    itemCount: listSurah.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index){
                      final datas = listSurah[index];
                      return SurahCard(
                        number: datas.nomor!.toInt(),
                        title: datas.namaLatin!,
                        subtitle: "${datas.tempatTurun} • ${datas.jumlahAyat!} Ayat",
                        arabic: datas.nama!,
                        primaryColor: mainColor,
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
