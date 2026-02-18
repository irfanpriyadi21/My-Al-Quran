import 'package:flutter/material.dart';
import 'package:my_quran/Componen/News/NewsDetail.dart';
import 'package:my_quran/Componen/Widget/CardComponen.dart';
import 'package:my_quran/Model/ModelListArtikel.dart';
import 'package:my_quran/Provider/Artikel/ArtikelApi.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../Model/string_http_exception.dart';
import '../alert.dart';


class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  List<ModelListArtikel> listArtikel = [];
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  void autoScroll() {
    Future.delayed(const Duration(seconds: 1), () async {
      while (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final minScroll = _scrollController.position.minScrollExtent;

        await _scrollController.animateTo(
          maxScroll,
          duration: const Duration(seconds: 5),
          curve: Curves.linear,
        );

        await _scrollController.animateTo(
          minScroll,
          duration: const Duration(seconds: 5),
          curve: Curves.linear,
        );
      }
    });
  }


  getArtikel()async{
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Artikel>(context, listen: false).getArtikel();
    } on StringHttpException catch (e) {
      var errorMessage = e.toString();
      AlertFail(errorMessage);
    } catch (error, s) {
      print(error);
      print(s.toString());
      AlertFail("Terjadi Kesalahan !! $s");
    }
    if(mounted){
      setState(() {
        listArtikel = Provider.of<Artikel>(context, listen: false).listArtikel;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArtikel();
    autoScroll();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 16,
                  children: List.generate(
                      listArtikel.length,
                          (index) => GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetail(
                                      listArtikel[index].id!
                                  )
                              )
                          );

                        },
                        child: CardComponen(
                            "${listArtikel[index].thumbnail}",
                            "${listArtikel[index].title}",
                            "${listArtikel[index].date}",
                        ),
                      )
                  ),
                ).paddingOnly(bottom: 16),
              ),
      ],
    );
  }
}
