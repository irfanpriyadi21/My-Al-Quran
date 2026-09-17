import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_quran/Model/model_doa_harian.dart';
import 'package:my_quran/Utils/default_doa_harian_data.dart';
import '../url_api.dart';

class DoaProvider with ChangeNotifier {
  List<ModelDoaHarian> listDoa = [];
  bool isLoading = false;
  String errorMessage = '';

  DoaProvider() {
    // Pre-populate with default offline dataset so Doa is instantly available
    listDoa = DefaultDoaHarianData.getDefaultDoaList();
  }

  Future<void> getDoa() async {
    // If list is empty, populate with offline data first
    if (listDoa.isEmpty) {
      listDoa = DefaultDoaHarianData.getDefaultDoaList();
    }

    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      // 1. Try Primary API
      final response = await http
          .get(Uri.parse(UrlApi.doaHarian))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200 && response.body.trim().isNotEmpty) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic> && decoded['data'] is List) {
          final List rawList = decoded['data'];
          if (rawList.isNotEmpty) {
            listDoa = rawList
                .asMap()
                .entries
                .map((e) => ModelDoaHarian.fromJson(e.value, e.key))
                .toList();
          }
        } else if (decoded is List && decoded.isNotEmpty) {
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
      if (listDoa.isEmpty) {
        listDoa = DefaultDoaHarianData.getDefaultDoaList();
      }
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchBackup() async {
    try {
      final response = await http
          .get(Uri.parse(UrlApi.doaHarianBackup))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200 && response.body.trim().isNotEmpty) {
        final decoded = json.decode(response.body);
        if (decoded is List && decoded.isNotEmpty) {
          listDoa = decoded
              .asMap()
              .entries
              .map((e) => ModelDoaHarian.fromJson(e.value, e.key))
              .toList();
        } else if (decoded is Map<String, dynamic> && decoded['data'] is List) {
          final List rawList = decoded['data'];
          if (rawList.isNotEmpty) {
            listDoa = rawList
                .asMap()
                .entries
                .map((e) => ModelDoaHarian.fromJson(e.value, e.key))
                .toList();
          }
        }
      }
    } catch (_) {
      // Fallback to bundled offline data
      if (listDoa.isEmpty) {
        listDoa = DefaultDoaHarianData.getDefaultDoaList();
      }
    }
  }
}

