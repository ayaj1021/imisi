import 'package:flutter/material.dart';
import 'package:imisi/Authentication_pages/login.dart';
import 'package:imisi/Database/database.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Widget/button_widget.dart';

class SignupOptionScreens extends StatefulWidget {
  const SignupOptionScreens({super.key});

  @override
  State<SignupOptionScreens> createState() => _SignupOptionScreensState();
}

class _SignupOptionScreensState extends State<SignupOptionScreens> {
  List userType = [
    {
      "name": "Artist",
    },
    {
      "name": "Listener",
    },
  ];

  int? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 40,
                child: Image.asset(
                  'assets/logos/Imisi_logo1.png',
                ),
              ),
              gapHeight(100),
              ListView.builder(
                shrinkWrap: true,
                itemCount: userType.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ButtonWidget(
                      onTap: () {
                        setState(() {
                          selectedItem = index;
                        });
                      },
                      text: "Sign up as ${userType[index]["name"]}",
                      color: selectedItem == index
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor,
                      border: Border.all(
                        color: selectedItem == index
                            ? AppColors.primaryColor
                            : AppColors.primaryColor,
                      ),
                      textColor: selectedItem == index
                          ? Colors.black
                          : AppColors.primaryColor,
                    ),
                  );
                },
              ),
              SizedBox(
                width: 135,
                child: ButtonWidget(
                  onTap: () {
                    SharedPref().saveUserAccountType(
                        userType[selectedItem!.toInt()]["name"]);
                    nextPage(const LoginPage(), context);
                  },
                  text: "Continue",
                  color: selectedItem == null
                      ? AppColors.disabledButtonColor
                      : AppColors.primaryColor,
                  textColor: selectedItem == null
                      ? AppColors.hintTextColor
                      : AppColors.disabledButtonColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
