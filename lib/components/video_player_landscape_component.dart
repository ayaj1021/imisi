import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerLandScapeComponent extends StatefulWidget {
  const VideoPlayerLandScapeComponent({
    super.key,
    required this.controller,
    // required this.artistName,
    // required this.songName
  });

  final VideoPlayerController controller;
  // final String artistName;
  // final String songName;

  @override
  State<VideoPlayerLandScapeComponent> createState() =>
      _VideoPlayerLandScapeComponentState();
}

class _VideoPlayerLandScapeComponentState
    extends State<VideoPlayerLandScapeComponent> {
  Future _landScapeMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void initState() {
    super.initState();
    _landScapeMode();
  }

  Future _setAllOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void dispose() {
    _setAllOrientation();
    super.dispose();
  }

  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          VideoPlayer(widget.controller),
          Column(
            children: [
              Row(
                children: [
                  const Column(
                    children: [
                      //   Text(widget.artistName),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.fullscreen_exit_rounded,
                      color: AppColors.onPrimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
