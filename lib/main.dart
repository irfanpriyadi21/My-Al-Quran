import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_quran/Page/login_page.dart';
import 'package:my_quran/Provider/ExampleProvider.dart';
import 'package:my_quran/Provider/Surah/SurahApi.dart';
import 'package:my_quran/Provider/app_provider.dart';
import 'package:provider/provider.dart';

import 'Componen/navigatorKey.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SurahApi()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'My Quran App',
            navigatorKey: NavigationService.navigatorKey,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
              ),
              useMaterial3: true,
            ),
            home: LoginPage(),
          );
        },
      ),
    );

  }
}
