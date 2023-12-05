// import 'package:flutter/material.dart';
// import 'package:imisi/Styles/app_colors.dart';
// import 'package:imisi/Utils/button_widget.dart';
// import 'package:imisi/Utils/gap.dart';
// import 'package:imisi/Utils/navigator.dart';
// import 'package:imisi/onboard/Screens/signup_options_screen.dart';
// import 'package:video_player/video_player.dart';

// class ThirdOnboardPage extends StatefulWidget {
//   const ThirdOnboardPage({super.key});

//   @override
//   State<ThirdOnboardPage> createState() => _ThirdOnboardPageState();
// }

// class _ThirdOnboardPageState extends State<ThirdOnboardPage> {
//   late VideoPlayerController videoPlayerController;

//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController =
//         VideoPlayerController.asset('assets/images/onboard_video.mp4');
//     videoPlayerController.setLooping(true);
//     videoPlayerController.initialize().then((value) => setState(() {}));
//     videoPlayerController.play();
//   }

//   //  videoPlayerController.play();
//   //           videoPlayerController.setLooping(false);
//   //           setState(() {});

//   @override
//   void dispose() {
//     videoPlayerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondaryColor,
//       body: Stack(
//         children: [
//           SizedBox(
//             height: double.infinity,
//             width: double.infinity,
//             child: videoPlayerController.value.isInitialized == true
//                 ? AspectRatio(
//                     aspectRatio: videoPlayerController.value.aspectRatio,
//                     child: VideoPlayer(videoPlayerController),
//                   )
//                 : Container(),
//           ),
//           Positioned(
//             left: 5,
//             right: 5,
//             bottom: 20,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   ButtonWidget(
//                     onTap: () => nextPage(const SignupOptionScreens(), context),
//                     text: 'Sign up',
//                     color: AppColors.primaryColor,
//                   ),
//                   // GestureDetector(
//                   //   onTap: () {}
//                   //   // context.go('/signupOptions'),
//                   //   child: LongButtonContainer(
//                   //     callback: () => context.go('/signupOptions'),
//                   //     buttonColor: AppColors.primaryColor,
//                   //     buttonWidget: Text(
//                   //       'Sign up',
//                   //       style: AppStyles.buttonText.copyWith(
//                   //         color: AppColors.secondaryColor,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   gapHeight(15),
//                   const ButtonWidget(
//                     text: 'Login',
//                     textColor: AppColors.primaryColor,
//                   )

//                   // GestureDetector(
//                   //   onTap: () {},
//                   //   child: LongButtonContainer(
//                   //     callback: () {},
//                   //     buttonWidget: Text(
//                   //       'Login',
//                   //       style: AppStyles.buttonText.copyWith(
//                   //         color: AppColors.primaryColor,
//                   //       ),
//                   //     ),

//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
