import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:my_quran/Model/ModelDetailArtikel.dart';
import 'package:my_quran/Model/ModelListArtikel.dart';

import '../url_api.dart';

class Artikel with ChangeNotifier{
  List<ModelListArtikel> listArtikel = [];

  Future<void> getArtikel()async{
    final url = UrlApi.artikelIslam;
    print(url);
    try{
      final response = await http.get(
        Uri.parse(url),
      );
      final responseData = json.decode(response.body);
      if(responseData['success'] == true){
        Iterable data = responseData['data']['data'];
        listArtikel = data.map((e) => ModelListArtikel.fromJson(e)).toList();
      }else{
        String message = responseData['message'];
        throw Exception(message);
      }
    }catch(e){
      rethrow;
    }
  }

  Future<ModelDetailArtikel> getArtikelDetail(id)async{
    final url = "${UrlApi.artikelDetail}/$id";
    print(url);
    try{
      final response = await http.get(
        Uri.parse(url),
      );
      final responseData = json.decode(response.body);
      if(responseData['success'] == true){
        ModelDetailArtikel imp = ModelDetailArtikel.fromJson(responseData);
        return imp;
      }else{
        String message = responseData['message'];
        throw Exception(message);
      }
    }catch(e){
      rethrow;
    }
  }

}