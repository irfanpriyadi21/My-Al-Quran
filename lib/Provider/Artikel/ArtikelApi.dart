import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_quran/Model/ModelDetailArtikel.dart';
import 'package:my_quran/Model/ModelListArtikel.dart';

import '../url_api.dart';

class Artikel with ChangeNotifier {
  List<ModelListArtikel> listArtikel = [];

  Future<void> getArtikel() async {
    final url = UrlApi.artikelIslam;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          Iterable data = responseData['data']['data'];
          listArtikel = data.map((e) => ModelListArtikel.fromJson(e)).toList();
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Gagal mengambil artikel: $e");
    }
  }

  Future<ModelDetailArtikel> getArtikelDetail(dynamic id) async {
    final url = "${UrlApi.artikelDetail}/$id";
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return ModelDetailArtikel.fromJson(responseData);
        }
      }
      return ModelDetailArtikel();
    } catch (e) {
      debugPrint("Gagal mengambil detail artikel: $e");
      return ModelDetailArtikel();
    }
  }
}