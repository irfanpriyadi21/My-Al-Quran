import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_quran/Page/indexPage.dart';
import 'package:my_quran/Page/login_page.dart';
import 'package:my_quran/Provider/Artikel/ArtikelApi.dart';
import 'package:my_quran/Provider/Doa/doa_provider.dart';
import 'package:my_quran/Provider/Hadits/hadits_provider.dart';
import 'package:my_quran/Provider/Shalat/AdzanAlarmService.dart';
import 'package:my_quran/Provider/Shalat/shalat_api.dart';
import 'package:my_quran/Provider/Surah/QuranAudioProvider.dart';
import 'package:my_quran/Provider/Surah/SurahApi.dart';
import 'package:my_quran/Provider/app_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'package:my_quran/Provider/Shalat/adzan_notification_service.dart';
import 'Componen/colors.dart';
import 'Componen/navigatorKey.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('id_ID', null);

  // Initialize Background Adzan Alarm Notification Service
  try {
    await AdzanNotificationService().initialize();
  } catch (e) {
    debugPrint("Failed to initialize AdzanNotificationService: $e");
  }

  final prefs = await SharedPreferences.getInstance();
  final isLogin = prefs.getBool('isLogin') ?? false;
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(MyApp(isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp(this.isLogin, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SurahApi()),
        ChangeNotifierProvider(create: (_) => QuranAudioProvider()),
        ChangeNotifierProvider(create: (_) => Artikel()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => DoaProvider()),
        ChangeNotifierProvider(create: (_) => HaditsProvider()),
        ChangeNotifierProvider(create: (_) => ShalatApi()),
        ChangeNotifierProvider(create: (_) => AdzanAlarmService()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My Alquran Mobile App',
            navigatorKey: NavigationService.navigatorKey,
            themeMode: appProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: const Color(0xFFF5F5F7),
              cardColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(149, 67, 255, 1),
                brightness: Brightness.light,
                surface: Colors.white,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF121212),
              cardColor: const Color(0xFF1E1E1E),
              colorScheme: ColorScheme.fromSeed(
                seedColor: mainColor,
                brightness: Brightness.dark,
                surface: const Color(0xFF1E1E1E),
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1E1E1E),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              useMaterial3: true,
            ),
            home: isLogin ? const IndexPage() : const LoginPage(),
          );
        },
      ),
    );
  }
}
