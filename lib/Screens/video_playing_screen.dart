import 'package:flutter/material.dart';
import 'package:imisi/Models/get_all_video_model.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/components/video_player_landscape_component.dart';
import 'package:video_player/video_player.dart';

class VideoPlayingScreen extends StatefulWidget {
  const VideoPlayingScreen(
      {super.key, required this.url, required this.videos});
  final String url;
  final List<GetAllVideoModel> videos;

  @override
  State<VideoPlayingScreen> createState() => _VideoPlayingScreenState();
}

class _VideoPlayingScreenState extends State<VideoPlayingScreen> {
  late VideoPlayerController _controller;
  late Future<void> initializeVideoPlayerFuture;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  int currentIndex = 0;
  final List<GetAllVideoModel> videos = [];

  void playVideo({int index = 0, bool init = false}) {
    if (index < 0 || index >= widget.videos.length) return;
    if (!init) {
      _controller.pause();
    }

    setState(() {
      currentIndex = index;
    });

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _controller.play());
  }

  @override
  void initState() {
    super.initState();
    playVideo(init: true);
    // _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    // initializeVideoPlayerFuture = _controller.initialize().then((_) {
    //   _controller.play();
    //   _controller.setLooping(false);
    //   // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool onTap = false;
  @override
  Widget build(BuildContext context) {
    // final isMuted = _controller.value.volume == 0;

    return Scaffold(
      appBar: AppBar(
        title: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            //  nextPage(const BasePage(), context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.onPrimaryColor,
            )),
        actions: [
          IconButton(
              onPressed: () {
                nextPage(
                    VideoPlayerLandScapeComponent(
                      // songName: videos[currentIndex].name ?? "",
                      // artistName: videos[currentIndex].artist ?? "",
                      controller: _controller,
                    ),
                    context);
              },
              icon: const Icon(
                Icons.fullscreen,
                color: AppColors.onPrimaryColor,
              ))
        ],
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
      ),
      backgroundColor: AppColors.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Center(
                          child: Container(
                              // child: CircularProgressIndicator(
                              //   color: AppColors.primaryColor,
                              // ),
                              ),
                        ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                VideoProgressIndicator(_controller, allowScrubbing: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, VideoPlayerValue value, child) {
                          return Text(
                            _videoDuration(value.position),
                            style: AppStyles.bodyRegularText.copyWith(
                              color: AppColors.onPrimaryColor,
                            ),
                          );
                        }),
                    IconButton(
                      onPressed: () {},
                      icon:
                          const Icon(Icons.skip_previous, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //  _controller.setPlaybackSpeed(2.0);
                      },
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _videoDuration(_controller.value.duration -
                          _controller.value.position),
                      style: AppStyles.bodyRegularText.copyWith(
                        color: AppColors.onPrimaryColor,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     _controller.setVolume(isMuted ? 1 : 0);
                    //   },
                    //   icon: Icon(
                    //     isMuted ? Icons.volume_mute : Icons.volume_up,
                    //     color: Colors.white,
                    //   ),
                    // )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '',
                      // formatTime(position),
                      style: AppStyles.bodyRegularText.copyWith(
                        color: AppColors.onPrimaryColor,
                      ),
                    ),
                    Text(
                      '',
                      // position.toString(),
                      style: AppStyles.bodyRegularText.copyWith(
                        color: AppColors.onPrimaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
            gapHeight(90),
          ],
        ),
      ),
    );
  }
}

//  VideoProgressIndicator(_controller,allowScrubbing: true)),
