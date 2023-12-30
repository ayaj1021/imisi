import 'package:flutter/material.dart';

import 'package:imisi/Styles/app_colors.dart';

import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Widget/button_widget.dart';
import 'package:imisi/onboard/Onboard%20Screens/signup_options_screen.dart';
import 'package:video_player/video_player.dart';

class ThirdOnboardPage extends StatefulWidget {
  const ThirdOnboardPage({super.key});

  @override
  State<ThirdOnboardPage> createState() => _ThirdOnboardPageState();
}

class _ThirdOnboardPageState extends State<ThirdOnboardPage> {
  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.asset('assets/images/onboard_video1.mp4');
    initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      videoPlayerController.play();
      videoPlayerController.setLooping(false);
      setState(() {});
    });
    // videoPlayerController.setLooping(false);
    // videoPlayerController.initialize().then((value) => setState(() {}));
    // videoPlayerController.play();
    super.initState();
  }

  //  videoPlayerController.play();
  //           videoPlayerController.setLooping(false);
  //           setState(() {});

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Stack(
        children: [
          // SizedBox(
          //   height: double.infinity,
          //   width: double.infinity,
          //   child: videoPlayerController.value.isInitialized == true
          //       ? AspectRatio(
          //           aspectRatio: videoPlayerController.value.aspectRatio,
          //           child: VideoPlayer(videoPlayerController),
          //         )
          //       : Container(),
          // ),
          Center(
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            ),
          ),
          Positioned(
            left: 5,
            right: 5,
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ButtonWidget(
                    onTap: () {
                      videoPlayerController.pause();
                      nextPage(const SignupOptionScreens(), context);
                    },
                    text: 'Sign up',
                    color: AppColors.primaryColor,
                  ),

                  // gapHeight(15),
                  // ButtonWidget(
                  //   onTap: () => nextPage(const LoginPage(), context),
                  //   text: 'Login',
                  //   textColor: AppColors.primaryColor,
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
