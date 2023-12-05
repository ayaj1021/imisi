import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Utils/button_widget.dart';
import 'package:imisi/Utils/gap.dart';


class SignupOptionScreens extends StatelessWidget {
  const SignupOptionScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 60,
                  width: 40,
                  child: Image.asset(
                    'assets/logos/Imisi_logo1.png',
                  ),
                ),
              ),
              const Spacer(),
              //  gapHeight(126),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ButtonWidget(
                      color: AppColors.primaryColor,
                      text: 'Sign up as a Listener',
                      textColor: AppColors.secondaryColor,
                    ),
                  gapHeight(16),
                  ButtonWidget(
                      border: Border.all(color: AppColors.onPrimaryColor),
                      text: 'Sign up as a music artiste',
                      textColor: AppColors.onPrimaryColor,
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
