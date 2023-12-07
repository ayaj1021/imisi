import 'package:flutter/material.dart';

import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/onboard/Onboard%20Screens/signup_options_screen.dart';

class FirstOnboardPage extends StatelessWidget {
  const FirstOnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/images/onboard_image1.jpg',
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => nextPage(const SignupOptionScreens(), context),
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              gapHeight(15),
              // const Gap(15),
              // Text(
              //   'Enjoy the best gospel music from your favorite gospel artiste',
              //   style: AppStyles.h5.copyWith(color: Colors.white),
              //   textAlign: TextAlign.center,
              // ),
            ],
          ),
        ),
      ]),
    );
  }
}
