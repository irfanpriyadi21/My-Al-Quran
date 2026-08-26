import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_quran/Page/login_page.dart';
import 'package:nb_utils/nb_utils.dart' hide SettingItemWidget;

import '../../Componen/Widget/SettingItemWidget.dart';
import '../../Componen/Widget/TextDataWidget.dart';
import '../../Componen/colors.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  _modalBottomSheetMenu(){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder){
          return Wrap(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)
                      )
                  ),
                  child:  Container(
                    padding: EdgeInsets.only(bottom: 40, right: 10, left: 10, top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Apakah Anda Yakin Ingin Logout ?",
                            style: TextStyle(
                                fontFamily: 'PoppinsMedium',
                                fontSize: 16,
                                color: Color(0xFF424242))
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size(120, 25),
                                backgroundColor: mainColor,
                                padding: EdgeInsets.only(
                                    top: 12, bottom: 14, left: 40, right: 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () async {
                                await googleSignIn.signOut();     // Logout Google
                                await FirebaseAuth.instance.signOut(); // Logout Firebase

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()
                                    )
                                );
                              },
                              child: Text(
                                "Oke!",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: 'PoppinsSemibold',
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: const Size(120, 25),
                                backgroundColor: Colors.grey[200],
                                padding: const EdgeInsets.only(
                                    top: 14, bottom: 14, left: 40, right: 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: mainColor,
                                  fontFamily: 'PoppinsSemibold',
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextData(
          text: "Profile",
          size: 20,
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Center(
               child: CircleAvatar(
                 radius: 40.0,
                 backgroundImage: NetworkImage(
                   FirebaseAuth.instance.currentUser!.photoURL!,
                 ),
                 backgroundColor: Colors.transparent,
               ),
              ),
              SizedBox(height: 10),
              TextData(
                text: "${FirebaseAuth.instance.currentUser!.displayName}",
                size: 17,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              TextData(
                text: "${FirebaseAuth.instance.currentUser!.email}",
                size: 14,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 50),
              SettingItemWidget(
                  title: 'Privacy Policy',
                  titleTextStyle: GoogleFonts.poppins(
                      textStyle: boldTextStyle(
                        color: Colors.grey,
                        size: 14
                      )
                  ),
                  decoration: boxDecorationRoundedWithShadow(12,
                      backgroundColor: Colors.white),
                  trailing: const Icon(Icons.privacy_tip_outlined, color: Colors.grey),
                  onTap: () {
                    // _modalBottomSheetMenu();
                  }).paddingOnly(bottom: 5),
              SettingItemWidget(
                  title: 'Dark Mode',
                  titleTextStyle: GoogleFonts.poppins(
                      textStyle: boldTextStyle(
                          color: Colors.grey,
                          size: 14
                      )
                  ),
                  decoration: boxDecorationRoundedWithShadow(12,
                      backgroundColor: Colors.white),
                  trailing: const Icon(Icons.dark_mode, color: Colors.grey),
                  onTap: () {
                    // _modalBottomSheetMenu();
                  }).paddingOnly(bottom: 5),
              SettingItemWidget(
                  title: 'Logout',
                  titleTextStyle: GoogleFonts.poppins(
                      textStyle: boldTextStyle(
                          color: Colors.grey,
                          size: 14
                      )
                  ),
                  decoration: boxDecorationRoundedWithShadow(12,
                      backgroundColor: Colors.white),
                  trailing: const Icon(Icons.power_settings_new, color: Colors.red),
                  onTap: () {
                    _modalBottomSheetMenu();
                  }),
            ],
          ).paddingOnly(right: 20, left: 20),
        ),
      ),
    );
  }
}
