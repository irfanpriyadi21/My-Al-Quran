import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_quran/Page/Profile/app_info_page.dart';
import 'package:my_quran/Page/Profile/privacy_policy_page.dart';
import 'package:my_quran/Page/login_page.dart';
import 'package:my_quran/Provider/app_provider.dart';
import 'package:nb_utils/nb_utils.dart' hide SettingItemWidget;
import 'package:provider/provider.dart';

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

  void _modalBottomSheetMenu() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return Wrap(
          children: [
            Material(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                    bottom: 40, right: 16, left: 16, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Apakah Anda Yakin Ingin Logout ?",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF424242),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size(120, 25),
                            backgroundColor: mainColor,
                            padding: const EdgeInsets.only(
                                top: 12, bottom: 14, left: 40, right: 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () async {
                            try {
                              await googleSignIn.signOut();
                            } catch (_) {}
                            if (Firebase.apps.isNotEmpty) {
                              try {
                                await FirebaseAuth.instance.signOut();
                              } catch (_) {}
                            }

                            if (mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          child: const Text(
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
                            backgroundColor: isDark
                                ? const Color(0xFF2C2C2C)
                                : Colors.grey[200],
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
                              color: isDark ? Colors.white70 : mainColor,
                              fontFamily: 'PoppinsSemibold',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final user = Firebase.apps.isNotEmpty ? FirebaseAuth.instance.currentUser : null;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
      body: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : null,
                      backgroundColor: isDark
                          ? const Color(0xFF2C2C2C)
                          : Colors.grey[300],
                      child: user?.photoURL == null
                          ? Icon(Icons.person, size: 40, color: mainColor)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextData(
                    text: user?.displayName ?? 'Pengguna',
                    size: 17,
                    color: isDark ? Colors.white : Colors.grey[800]!,
                    fontWeight: FontWeight.bold,
                  ),
                  TextData(
                    text: user?.email ?? '',
                    size: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 40),

                  // TENTANG APLIKASI / APP INFO
                  SettingItemWidget(
                    title: 'Tentang Aplikasi',
                    titleTextStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    decoration: boxDecorationRoundedWithShadow(
                      12,
                      backgroundColor: cardColor,
                    ),
                    trailing: const Icon(
                      Icons.info_outline_rounded,
                      color: mainColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppInfoPage(),
                        ),
                      );
                    },
                  ).paddingOnly(bottom: 10),

                  // PRIVACY POLICY
                  SettingItemWidget(
                    title: 'Privacy Policy',
                    titleTextStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    decoration: boxDecorationRoundedWithShadow(
                      12,
                      backgroundColor: cardColor,
                    ),
                    trailing: const Icon(
                      Icons.privacy_tip_outlined,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyPage(),
                        ),
                      );
                    },
                  ).paddingOnly(bottom: 10),

                  // DARK MODE TOGGLE
                  SettingItemWidget(
                    title: 'Dark Mode',
                    titleTextStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    decoration: boxDecorationRoundedWithShadow(
                      12,
                      backgroundColor: cardColor,
                    ),
                    trailing: Switch.adaptive(
                      value: appProvider.isDarkMode,
                      activeTrackColor: mainColor,
                      onChanged: (value) {
                        appProvider.toggleDarkMode(value);
                      },
                    ),
                    onTap: () {
                      appProvider.toggleDarkMode(!appProvider.isDarkMode);
                    },
                  ).paddingOnly(bottom: 10),

                  // LOGOUT
                  SettingItemWidget(
                    title: 'Logout',
                    titleTextStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    decoration: boxDecorationRoundedWithShadow(
                      12,
                      backgroundColor: cardColor,
                    ),
                    trailing: const Icon(
                      Icons.power_settings_new,
                      color: Colors.redAccent,
                    ),
                    onTap: () {
                      _modalBottomSheetMenu();
                    },
                  ),
                ],
              ).paddingOnly(right: 20, left: 20),
            ),
          );
        },
      ),
    );
  }
}
