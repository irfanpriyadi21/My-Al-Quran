import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_quran/Model/model_hadits_item.dart';
import 'package:my_quran/Model/model_hadits_perawi.dart';
import 'package:my_quran/Utils/default_hadits_data.dart';
import '../url_api.dart';

class HaditsProvider with ChangeNotifier {
  List<ModelHaditsPerawi> listPerawi = DefaultHaditsData.getPerawiList();
  List<ModelHaditsItem> listHadits = [];
  final Map<String, List<ModelHaditsItem>> _cacheHadits = {};
  final Set<int> _loadedPages = {};

  bool isLoading = false;
  bool isLoadingMore = false;
  bool isOffline = false;
  bool hasMore = true;
  String errorMessage = '';

  int currentPage = 1;
  int totalPages = 1;
  int totalItems = 0;
  String currentSlug = '';
  int? _activeLoadingPage;

  // 1. Fetch List of Hadith Narrators/Books
  Future<void> getPerawi() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse(UrlApi.haditsBase))
          .timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is List && decoded.isNotEmpty) {
          listPerawi = decoded
              .map((e) => ModelHaditsPerawi.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (_) {
      // Keep DefaultHaditsData.getPerawiList()
    } finally {
      if (listPerawi.isEmpty) {
        listPerawi = DefaultHaditsData.getPerawiList();
      }
      isLoading = false;
      notifyListeners();
    }
  }

  // 2. Fetch Hadiths for a specific narrator by page
  Future<void> getHaditsByPerawi(
    String slug, {
    int page = 1,
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      if (isLoadingMore ||
          isLoading ||
          !hasMore ||
          isOffline ||
          _activeLoadingPage == page ||
          _loadedPages.contains(page) ||
          page > totalPages) {
        return;
      }
      isLoadingMore = true;
      _activeLoadingPage = page;
    } else {
      if (isLoading && currentSlug == slug) return;
      isLoading = true;
      currentSlug = slug;
      currentPage = 1;
      _loadedPages.clear();
      _activeLoadingPage = page;
      hasMore = true;
      isOffline = false;

      // Show cached or fallback immediately while fetching
      if (_cacheHadits.containsKey(slug) && _cacheHadits[slug]!.isNotEmpty) {
        listHadits = List.from(_cacheHadits[slug]!);
      } else {
        listHadits = DefaultHaditsData.getHaditsBySlug(slug);
      }
    }
    errorMessage = '';
    notifyListeners();

    final url = "${UrlApi.haditsBase}/$slug?page=$page&limit=20";
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic>) {
          if (decoded['pagination'] != null) {
            currentPage = decoded['pagination']['currentPage'] ?? page;
            totalPages = decoded['pagination']['totalPages'] ?? 1;
            totalItems = decoded['pagination']['totalItems'] ?? 0;
            hasMore = currentPage < totalPages;
          }
          if (decoded['items'] is List) {
            final List rawItems = decoded['items'];
            final List<ModelHaditsItem> parsed = rawItems
                .map((e) => ModelHaditsItem.fromJson(e as Map<String, dynamic>))
                .toList();

            _loadedPages.add(page);

            if (isLoadMore) {
              listHadits.addAll(parsed);
              _cacheHadits[slug] = listHadits;
            } else {
              listHadits = parsed;
              _cacheHadits[slug] = parsed;
            }
            isOffline = false;
          }
        }
      } else {
        _handleFetchError(slug, isLoadMore);
      }
    } catch (e) {
      _handleFetchError(slug, isLoadMore);
    } finally {
      isLoading = false;
      isLoadingMore = false;
      _activeLoadingPage = null;
      notifyListeners();
    }
  }

  void _handleFetchError(String slug, bool isLoadMore) {
    if (isLoadMore) {
      // Stop continuous pagination retries on network error
      hasMore = false;
      isOffline = true;
    } else {
      if (listHadits.isEmpty) {
        listHadits = DefaultHaditsData.getHaditsBySlug(slug);
        _cacheHadits[slug] = listHadits;
      }
      totalItems = listHadits.length;
      totalPages = 1;
      hasMore = false;
      isOffline = true;
    }
  }

  // 3. Search single Hadith by specific number
  Future<ModelHaditsItem?> getHaditsByNumber(String slug, int number) async {
    // 1. Check current list first
    try {
      final match = listHadits.firstWhere((h) => h.number == number);
      return match;
    } catch (_) {}

    // 2. Try API
    final url = "${UrlApi.haditsBase}/$slug/$number";
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic> && decoded['arab'] != null) {
          return ModelHaditsItem.fromJson(decoded);
        }
      }
    } catch (_) {}

    // 3. Fallback to offline data
    return DefaultHaditsData.getHaditsByNumber(slug, number);
  }
}
