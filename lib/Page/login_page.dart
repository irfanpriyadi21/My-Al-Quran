import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Componen/Widget/TextDataWidget.dart';
import 'package:my_quran/Componen/alert.dart';
import 'package:my_quran/Componen/colors.dart';
import 'package:my_quran/Page/Dashboard/dashboard_page.dart';
import 'package:my_quran/Page/indexPage.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Provider/AuthService.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= const Duration(seconds: 2);

        print(cantExit);
        pre_backpress = DateTime.now();
        if(cantExit){
          // show snackbar
          final snack = SnackBar(content: Text('Press Back button again to Exit'),duration: Duration(seconds: 2),);
          ScaffoldMessenger.of(context).showSnackBar(snack);
        }else{
          SystemNavigator.pop();
        }

      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/image/quran1.png",
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(height: 16),
                    TextData(
                      text: "My Quran",
                      size: 18,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                    TextData(
                      text: "Baca Al Quran Dengan Mudah",
                      size: 13,
                      color: secondaryColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      final user =
                          await AuthService().signInWithGoogle();

                      if (user != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IndexPage()
                            )
                        );
                      } else {
                        AlertFail("Terjadi Kesalahan Login");
                      }
                    },
                    child: TextData(
                      text: "Login With Google",
                      size: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      )

    );
  }
}
