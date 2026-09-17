import 'package:flutter/material.dart';
import 'package:my_quran/Utils/app_language.dart';
import 'package:nb_utils/nb_utils.dart';

class AppProvider with ChangeNotifier {
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  String _languageCode = 'id';
  String get languageCode => _languageCode;

  Locale get locale => Locale(_languageCode);

  String get languageName => AppLanguage.getLanguageName(_languageCode);
  String get languageNativeName => AppLanguage.getLanguageNativeName(_languageCode);

  AppProvider() {
    initSettings();
  }

  Future<void> initSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _languageCode = prefs.getString('app_language_code') ?? 'id';
    notifyListeners();
  }

  Future<void> initTheme() async {
    await initSettings();
  }

  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    _languageCode = code;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language_code', code);
    notifyListeners();
  }

  String tr(String key) {
    return AppLanguage.getText(key, _languageCode);
  }
}