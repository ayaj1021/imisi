// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/onboard/Onboard%20Screens/onboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void userLoggedIn() {
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      if (token == null) {
        nextPage(const OnboardScreen(), context);
      } else {
        nextPage(const BasePage(), context);
      }
    });
  }

  @override
  void initState() {
    userLoggedIn();
    super.initState();
  }

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

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
