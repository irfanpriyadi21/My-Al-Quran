import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_quran/Model/model_hadits_item.dart';
import 'package:my_quran/Model/model_hadits_perawi.dart';
import '../url_api.dart';

class HaditsProvider with ChangeNotifier {
  List<ModelHaditsPerawi> listPerawi = [];
  List<ModelHaditsItem> listHadits = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  String errorMessage = '';

  int currentPage = 1;
  int totalPages = 1;
  int totalItems = 0;
  String currentSlug = '';

  // 1. Fetch List of Hadith Narrators/Books
  Future<void> getPerawi() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse(UrlApi.haditsBase))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is List) {
          listPerawi = decoded
              .map((e) => ModelHaditsPerawi.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      } else {
        _useFallbackPerawi();
      }
    } catch (_) {
      _useFallbackPerawi();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _useFallbackPerawi() {
    if (listPerawi.isEmpty) {
      listPerawi = [
        ModelHaditsPerawi(name: "Bukhari", slug: "bukhari", total: 6638),
        ModelHaditsPerawi(name: "Muslim", slug: "muslim", total: 4930),
        ModelHaditsPerawi(name: "Abu Dawud", slug: "abu-dawud", total: 4419),
        ModelHaditsPerawi(name: "Tirmidzi", slug: "tirmidzi", total: 3625),
        ModelHaditsPerawi(name: "Nasai", slug: "nasai", total: 5364),
        ModelHaditsPerawi(name: "Ibnu Majah", slug: "ibnu-majah", total: 4285),
        ModelHaditsPerawi(name: "Ahmad", slug: "ahmad", total: 4305),
        ModelHaditsPerawi(name: "Malik", slug: "malik", total: 1587),
        ModelHaditsPerawi(name: "Darimi", slug: "darimi", total: 2949),
      ];
    }
  }

  // 2. Fetch Hadiths for a specific narrator by page
  Future<void> getHaditsByPerawi(
    String slug, {
    int page = 1,
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      if (isLoadingMore || page > totalPages) return;
      isLoadingMore = true;
    } else {
      isLoading = true;
      listHadits.clear();
      currentPage = 1;
    }
    errorMessage = '';
    currentSlug = slug;
    notifyListeners();

    final url = "${UrlApi.haditsBase}/$slug?page=$page&limit=20";
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic>) {
          if (decoded['pagination'] != null) {
            currentPage = decoded['pagination']['currentPage'] ?? page;
            totalPages = decoded['pagination']['totalPages'] ?? 1;
            totalItems = decoded['pagination']['totalItems'] ?? 0;
          }
          if (decoded['items'] is List) {
            final List rawItems = decoded['items'];
            final List<ModelHaditsItem> parsed = rawItems
                .map((e) => ModelHaditsItem.fromJson(e as Map<String, dynamic>))
                .toList();

            if (isLoadMore) {
              listHadits.addAll(parsed);
            } else {
              listHadits = parsed;
            }
          }
        }
      } else {
        errorMessage = 'Gagal memuat hadits (Status ${response.statusCode})';
      }
    } catch (e) {
      errorMessage = 'Koneksi bermasalah saat memuat hadits.';
    } finally {
      isLoading = false;
      isLoadingMore = false;
      notifyListeners();
    }
  }

  // 3. Search single Hadith by specific number
  Future<ModelHaditsItem?> getHaditsByNumber(String slug, int number) async {
    final url = "${UrlApi.haditsBase}/$slug/$number";
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic> && decoded['arab'] != null) {
          return ModelHaditsItem.fromJson(decoded);
        }
      }
    } catch (_) {}
    return null;
  }
}
