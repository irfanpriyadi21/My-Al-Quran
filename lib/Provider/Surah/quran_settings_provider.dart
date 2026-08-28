import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranSettingsProvider with ChangeNotifier {
  static const String keyFontFamily = 'quran_arabic_font';
  static const String keyFontSize = 'quran_arabic_font_size';
  static const String keyShowLatin = 'quran_show_latin';
  static const String keyShowTranslation = 'quran_show_translation';

  String _arabicFontFamily = 'Amiri';
  double _arabicFontSize = 26.0;
  bool _showLatin = true;
  bool _showTranslation = true;

  String get arabicFontFamily => _arabicFontFamily;
  double get arabicFontSize => _arabicFontSize;
  bool get showLatin => _showLatin;
  bool get showTranslation => _showTranslation;

  static const List<Map<String, String>> availableFonts = [
    {
      'id': 'Amiri',
      'name': 'Amiri',
      'desc': 'Klasik Mushaf Standar Indonesia & Timur Tengah',
    },
    {
      'id': 'Scheherazade New',
      'name': 'Scheherazade',
      'desc': 'Tulisan Tradisional Utsmani yang Otentik',
    },
    {
      'id': 'Noto Naskh Arabic',
      'name': 'Noto Naskh',
      'desc': 'Font Modern, Jelas, & Sangat Tajam',
    },
    {
      'id': 'Lateef',
      'name': 'Lateef',
      'desc': 'Gaya Kaligrafi Halus & Ramping',
    },
    {
      'id': 'Cairo',
      'name': 'Cairo',
      'desc': 'Gaya Geometris Bersih & Minimalis',
    },
  ];

  QuranSettingsProvider() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _arabicFontFamily = prefs.getString(keyFontFamily) ?? 'Amiri';
      _arabicFontSize = prefs.getDouble(keyFontSize) ?? 26.0;
      _showLatin = prefs.getBool(keyShowLatin) ?? true;
      _showTranslation = prefs.getBool(keyShowTranslation) ?? true;
      notifyListeners();
    } catch (_) {}
  }

  Future<void> setFontFamily(String fontId) async {
    _arabicFontFamily = fontId;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyFontFamily, fontId);
  }

  Future<void> setFontSize(double size) async {
    _arabicFontSize = size;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(keyFontSize, size);
  }

  Future<void> toggleShowLatin(bool value) async {
    _showLatin = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyShowLatin, value);
  }

  Future<void> toggleShowTranslation(bool value) async {
    _showTranslation = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyShowTranslation, value);
  }

  /// Helper to generate TextStyle based on selected font family
  TextStyle getArabicTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    final size = fontSize ?? _arabicFontSize;
    final weight = fontWeight ?? FontWeight.bold;
    final h = height ?? 2.0;

    switch (_arabicFontFamily) {
      case 'Scheherazade New':
        return GoogleFonts.scheherazadeNew(
          fontSize: size,
          fontWeight: weight,
          color: color,
          height: h,
        );
      case 'Noto Naskh Arabic':
        return GoogleFonts.notoNaskhArabic(
          fontSize: size,
          fontWeight: weight,
          color: color,
          height: h,
        );
      case 'Lateef':
        return GoogleFonts.lateef(
          fontSize: size * 1.15, // Lateef is slightly smaller in baseline
          fontWeight: weight,
          color: color,
          height: h,
        );
      case 'Cairo':
        return GoogleFonts.cairo(
          fontSize: size,
          fontWeight: weight,
          color: color,
          height: h,
        );
      case 'Amiri':
      default:
        return GoogleFonts.amiri(
          fontSize: size,
          fontWeight: weight,
          color: color,
          height: h,
        );
    }
  }
}
