import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_quran/Componen/News/NewsDetail.dart';
import 'package:my_quran/Componen/Widget/CardComponen.dart';
import 'package:my_quran/Componen/Widget/shimmer_widget.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Model/ModelListArtikel.dart';
import 'package:my_quran/Provider/Artikel/ArtikelApi.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  List<ModelListArtikel> listArtikel = [];
  bool isLoading = false;
  final PageController _pageController =
      PageController(viewportFraction: 0.88);
  int _currentPage = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    getArtikel();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    if (listArtikel.length <= 1) return;

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || !_pageController.hasClients) return;

      int nextPage = _currentPage + 1;
      if (nextPage >= listArtikel.length) {
        nextPage = 0;
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> getArtikel() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Artikel>(context, listen: false).getArtikel();
    } catch (error) {
      debugPrint("Error getArtikel: $error");
    }
    if (mounted) {
      setState(() {
        listArtikel = Provider.of<Artikel>(context, listen: false).listArtikel;
        isLoading = false;
      });
      if (listArtikel.isNotEmpty) {
        _startAutoPlay();
      }
    }
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isLoading) {
      return const NewsShimmerWidget();
    }

    if (listArtikel.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 195,
          child: PageView.builder(
            controller: _pageController,
            itemCount: listArtikel.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final artikel = listArtikel[index];
              return AnimatedScale(
                scale: _currentPage == index ? 1.0 : 0.95,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetail(artikel.id!),
                        ),
                      );
                    },
                    child: CardComponen(
                      artikel.thumbnail ?? '',
                      artikel.title ?? '',
                      artikel.date ?? '',
                      width: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (listArtikel.length > 1) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              listArtikel.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 6,
                width: _currentPage == index ? 22 : 6,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? mainColor
                      : (isDark
                          ? const Color(0xFF333333)
                          : Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
