import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Onboard/Screens/signup_options_screen.dart';
import 'package:imisi/Widget/button_widget.dart';
import 'package:scaled_size/scaled_size.dart';

import '../Onboard_model/onboard_model.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late PageController pageController;
  int currentPage = 0;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: contents.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          contents[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    nextPage(
                                        const SignupOptionScreens(), context);
                                  },
                                  child: const Text(
                                    'Skip',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            gapHeight(16),
                            Text(
                              contents[index].titleText,
                              style: AppStyles.h5.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    contents.length,
                                    (index) => Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 8,
                                      width: currentPage == index ? 50 : 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: currentPage == index
                                            ? AppColors.primaryColor
                                            : const Color(0xFF585757),
                                      ),
                                    ),
                                  ),
                                ),
                                gapHeight(16),
                                ButtonWidget(
                                  onTap: () {
                                    if (currentPage == contents.length - 1) {
                                      nextPage(
                                          const SignupOptionScreens(), context);
                                    }
                                    pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.bounceIn);
                                  },
                                  color: AppColors.primaryColor,
                                  text: currentPage == index - 1
                                      ? 'Next'
                                      : 'Continue',
                                  textColor: AppColors.secondaryColor,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
