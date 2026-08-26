import 'package:flutter/material.dart';
import 'package:my_quran/Model/ModelListKabkot.dart';
import 'package:my_quran/Model/ModelListProvinsi.dart';


class ShalatApi with ChangeNotifier {
  List<ModelListProvinsi> listProvinsi = [];
  List<ModelListKabkot> listKabkot = [];

  Future<void> getProvinsi()async{

  }

  Future<void> getKabkot(String provinsi)async{

  }
}