import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imisi/Database/database.dart';
import 'package:imisi/Styles/app_colors.dart';

import 'package:imisi/Utils/navigator.dart';

import 'package:imisi/onboard/Onboard%20Screens/Base/base_page.dart';
import 'package:imisi/onboard/Onboard%20Screens/onboard_screen.dart';

String? token;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool newUser;
  SharedPref pref = SharedPref();
  @override
  void initState() {
    super.initState();
    pref.getUserToken().then((value) {
      token = value;
    });
    Timer(const Duration(seconds: 4), () {
      token == null
          ? nextPage(const OnboardScreen(), context)
          : nextPage(const BasePage(), context);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const OnboardScreen(),
      //   ),
      // );
    });
  }

  void userLoggedIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.secondaryColor,
        ),
        child: Image.asset(
          'assets/logos/Imisi_logo1.png',
          scale: 5,
        ),
      ),
    );
  }
}
