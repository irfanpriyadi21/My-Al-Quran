import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/Loading.dart';
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

  Future<void> getDetailArtikel() async {
    setState(() {
      isLoading = true;
    });
    try {
      detailArtikel = await Provider.of<Artikel>(context, listen: false)
          .getArtikelDetail(widget.id);
    } on StringHttpException catch (e) {
      var errorMessage = e.toString();
      AlertFail(errorMessage);
    } catch (error, s) {
      debugPrint("Error getDetailArtikel: $error \n $s");
      AlertFail("Terjadi Kesalahan !! $s");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDetailArtikel();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final data = detailArtikel.data;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: mainColor),
                    ),
                    TextData(
                      text: "News Detail",
                      size: 18,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
                const SizedBox(height: 20),

                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 80),
                    child: Center(
                      child: Loading(),
                    ),
                  )
                else if (data != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TITLE
                      if (data.title != null)
                        Text(
                          data.title!,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      const SizedBox(height: 8),

                      // AUTHOR & DATE
                      if (data.author != null || data.date != null)
                        Row(
                          children: [
                            if (data.author != null) ...[
                              Icon(
                                Icons.person_outline,
                                size: 14,
                                color: isDark ? Colors.white60 : Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                data.author!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                            if (data.date != null) ...[
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 13,
                                color: isDark ? Colors.white60 : Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                data.date!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.grey[600],
                                ),
                              ),
                            ],
                          ],
                        ),
                      const SizedBox(height: 16),

                      // THUMBNAIL
                      if (data.thumbnail != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            width: double.infinity,
                            height: 210,
                            child: Image.network(
                              data.thumbnail!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: isDark
                                    ? const Color(0xFF2C2C2C)
                                    : Colors.grey[200],
                                child: const Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),

                      // CONTENT HTML
                      if (data.contentHtml != null)
                        Html(
                          data: data.contentHtml!,
                          style: {
                            "p": Style(
                              fontSize: FontSize(15),
                              color: isDark ? Colors.white70 : Colors.black87,
                              lineHeight: const LineHeight(1.6),
                            ),
                            "body": Style(
                              fontSize: FontSize(15),
                              color: isDark ? Colors.white70 : Colors.black87,
                              lineHeight: const LineHeight(1.6),
                            ),
                            "h1": Style(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            "h2": Style(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            "h3": Style(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            "strong": Style(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            "b": Style(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            "a": Style(
                              color: mainColor,
                            ),
                            "li": Style(
                              color: isDark ? Colors.white70 : Colors.black87,
                              fontSize: FontSize(14.5),
                            ),
                          },
                        ),
                      const SizedBox(height: 30),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
