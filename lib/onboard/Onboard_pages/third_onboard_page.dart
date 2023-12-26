import 'package:flutter/material.dart';
import 'package:imisi/Authentication_pages/login.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Widget/button_widget.dart';
import 'package:imisi/onboard/Onboard%20Screens/signup_options_screen.dart';
import 'package:video_player/video_player.dart';

class ThirdOnboardPage extends StatefulWidget {
  const ThirdOnboardPage({super.key});

  @override
  State<ThirdOnboardPage> createState() => _ThirdOnboardPageState();
}

class _ThirdOnboardPageState extends State<ThirdOnboardPage> with RouteAware {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.asset('assets/images/onboard_video.mp4')
          ..addListener(() => setState(() {}))
          ..setLooping(true)
          ..initialize().then((value) => videoPlayerController.play());
  }

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
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: videoPlayerController.value.isInitialized == true
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width: videoPlayerController.value.size.width,
                        height: videoPlayerController.value.size.height,
                        child: InkWell(
                            onTap: () => videoPlayerController.value.isPlaying
                                ? videoPlayerController.pause()
                                : videoPlayerController.play(),
                            splashColor: Colors.transparent,
                            child: VideoPlayer(videoPlayerController)),
                      ),
                    ),
                  )
                : Container(),
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
                      videoPlayerController.value.isPlaying
                          ? videoPlayerController.pause()
                          : null;
                      nextPage(const SignupOptionScreens(), context);
                    },
                    text: 'Sign up',
                    color: AppColors.primaryColor,
                  ),
                  gapHeight(15),
                  ButtonWidget(
                    onTap: () {
                      videoPlayerController.value.isPlaying
                          ? videoPlayerController.pause()
                          : null;
                      nextPage(const LoginPage(), context);
                    },
                    text: 'Login',
                    textColor: AppColors.primaryColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
