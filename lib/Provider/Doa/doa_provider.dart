import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_quran/Model/model_doa_harian.dart';
import '../url_api.dart';

class DoaProvider with ChangeNotifier {
  List<ModelDoaHarian> listDoa = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> getDoa() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      // 1. Try Primary API
      final response = await http
          .get(Uri.parse(UrlApi.doaHarian))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic> && decoded['data'] is List) {
          final List rawList = decoded['data'];
          listDoa = rawList
              .asMap()
              .entries
              .map((e) => ModelDoaHarian.fromJson(e.value, e.key))
              .toList();
        } else if (decoded is List) {
          listDoa = decoded
              .asMap()
              .entries
              .map((e) => ModelDoaHarian.fromJson(e.value, e.key))
              .toList();
        }
      } else {
        await _fetchBackup();
      }
    } catch (_) {
      await _fetchBackup();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchBackup() async {
    try {
      final response = await http
          .get(Uri.parse(UrlApi.doaHarianBackup))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is List) {
          listDoa = decoded
              .asMap()
              .entries
              .map((e) => ModelDoaHarian.fromJson(e.value, e.key))
              .toList();
        } else if (decoded is Map<String, dynamic> && decoded['data'] is List) {
          final List rawList = decoded['data'];
          listDoa = rawList
              .asMap()
              .entries
              .map((e) => ModelDoaHarian.fromJson(e.value, e.key))
              .toList();
        }
      } else {
        errorMessage = 'Gagal memuat daftar doa harian.';
      }
    } catch (e) {
      if (listDoa.isEmpty) {
        errorMessage = 'Koneksi internet bermasalah atau server tidak merespon.';
      }
    }
  }
}
