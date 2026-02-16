import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_quran/Model/ModelDetailArtikel.dart';
import 'package:provider/provider.dart';

import '../../Model/string_http_exception.dart';
import '../../Provider/Artikel/ArtikelApi.dart';
import '../Widget/TextDataWidget.dart';
import '../alert.dart';
import '../colors.dart';


class NewsDetail extends StatefulWidget {
  final String id;
  const NewsDetail(this.id, {super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  bool isLoading = false;
  ModelDetailArtikel detailArtikel = ModelDetailArtikel();

  getDetailArtikel()async{
    setState(() {
      isLoading = true;
    });
    try {
      detailArtikel = await Provider.of<Artikel>(context, listen: false).getArtikelDetail(widget.id);
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
    getDetailArtikel();
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
                    Icon(Icons.arrow_back, color:mainColor),
                    TextData(
                      text:  "News Detail",
                      size: 18,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                isLoading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(detailArtikel.data!.thumbnail!),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    const SizedBox(height: 20),
                    Html(
                      data: detailArtikel.data!.contentHtml!,
                      style: {
                        "p": Style(
                          fontSize: FontSize(16),
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      },
                    )

                  ],
                )
              ]
              )
          ),
        ),
      ),
    );
  }
}
