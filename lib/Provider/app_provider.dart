import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AppProvider with ChangeNotifier {
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  AppProvider() {
    initTheme();
  }

  Future<void> initTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }
}