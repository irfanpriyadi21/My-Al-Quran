import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_quran/Model/ModelListAyat.dart';
import 'package:my_quran/Model/ModelListSurah.dart';

import '../url_api.dart';


class SurahApi with ChangeNotifier{
  List<ModelListSurah> listSurah = [];

  Future<void> getSurah()async{
    final url = UrlApi.listSurah;
    try{
      final response = await http.get(
        Uri.parse(url),
      );
      final responseData = json.decode(response.body);
      if(responseData['code'] == 200){
        Iterable data = responseData['data'];
        listSurah = data.map((e) => ModelListSurah.fromJson(e)).toList();
      }else{
        String message = responseData['message'];
        throw Exception(message);
      }
    }catch(e){
      rethrow;
    }
  }

  Future<ModelListAyat> getAyat(nomorSurah)async{
    final url = UrlApi.listAyat + nomorSurah.toString();
    try{
      final response = await http.get(
        Uri.parse(url),
      );
      final responseData = json.decode(response.body);
      print(responseData.toString());
      if(responseData['code'] == 200){
        ModelListAyat imp = ModelListAyat.fromJson(responseData['data']);
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