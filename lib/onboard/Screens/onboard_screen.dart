// import 'package:flutter/material.dart';

// import 'package:imisi/Styles/app_colors.dart';

// import 'package:imisi/Utils/button_widget.dart';
// import 'package:imisi/Utils/gap.dart';
// import 'package:imisi/onboard/Onboard_pages/first_onboard_page.dart';
// import 'package:imisi/onboard/Onboard_pages/second_onboard_page.dart';
// import 'package:imisi/onboard/Onboard_pages/third_onboard_page.dart';

// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class OnboardScreen extends StatefulWidget {
//   const OnboardScreen({super.key});

//   @override
//   State<OnboardScreen> createState() => _OnboardScreenState();
// }

// class _OnboardScreenState extends State<OnboardScreen> {
//   PageController pageController = PageController(initialPage: 0);
//   int currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     pageController.addListener(() {
//       setState(() {
//         currentPage = pageController.page?.round() ?? 0;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     pageController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondaryColor,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             PageView(
//               controller: pageController,
//               children: const [
//                 FirstOnboardPage(),
//                 SecondOnboardPage(),
//               ],
//             ),
//             Positioned(
//               left: 5,
//               right: 5,
//               bottom: 15,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SmoothPageIndicator(
//                       controller: pageController,
//                       count: 2,
//                       effect: const ExpandingDotsEffect(
//                         dotColor: Color(0xFF585757),
//                         dotWidth: 22,
//                         dotHeight: 10,
//                         activeDotColor: AppColors.primaryColor,
//                       ),
//                     ),
//                     gapHeight(80),
//                     ButtonWidget(
//                         onTap: () {
//                           if (currentPage == 0) {
//                             pageController.nextPage(
//                                 duration: const Duration(milliseconds: 300),
//                                 curve: Curves.bounceInOut);
//                           } else {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const ThirdOnboardPage()));
//                           }
//                         },
//                         color: AppColors.primaryColor,
//                         text: 'Continue')

//                     //    LongButtonContainer(
//                     //     callback: () {},
//                     //     buttonColor: AppColors.primaryColor,
//                     //     buttonWidget: Text(
//                     //       'Continue',
//                     //       style: AppStyles.buttonText.copyWith(
//                     //         color: AppColors.secondaryColor,
//                     //       ),
//                     //     ),
//                     //     textColor: AppColors.secondaryColor,
//                     //   ),
//                     // )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
