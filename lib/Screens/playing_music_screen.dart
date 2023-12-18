import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:scaled_size/scaled_size.dart';

class PlayingMusicScreen extends StatefulWidget {
  const PlayingMusicScreen({
    required this.index,
    required this.songs,
    super.key,
    required this.name,
    required this.artist,
    required this.image,
    required this.url,
  });
  final String name;
  final int index;
  final String artist;
  final String image;
  final List songs;
  final String url;

  @override
  State<PlayingMusicScreen> createState() => _PlayingMusicScreenState();
}

class _PlayingMusicScreenState extends State<PlayingMusicScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String currentSong = "";

  formatTime(Duration duration) {
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

  @override
  void initState() {
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    if (isPlaying) {
      audioPlayer.stop();
      audioPlayer.play(
        UrlSource(widget.url.toString()),
      );
    } else {
      audioPlayer.play(
        UrlSource(widget.url.toString()),
      );
    }
    audioPlayer.play(
      UrlSource(widget.url.toString()),
    );
    super.initState();
    //  audioPlayer.play(
    //   (UrlSource(url)),
    // );
    // audioPlayer.onPlayerStateChanged.listen((state) {
    //   isPlaying = state == PlayerState.playing;
    // });

    // audioPlayer.onDurationChanged.listen((newDuration) {
    //   setState(() {
    //     duration = newDuration;
    //   });
    // });
    // audioPlayer.onPositionChanged.listen((newPosition) {
    //   setState(() {
    //     position = newPosition;
    //   });
    // });
  }

  // @override
  // void dispose() {
  //   audioPlayer.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    String currentTitle = widget.name;
    String currentSinger = widget.artist;
    String currentImage = widget.image;
    // String currentSong = "";
    String url = widget.url;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.onPrimaryColor,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 340.rh,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.network(currentImage),
                ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentTitle,
                            style: AppStyles.title4Bold
                                .copyWith(color: AppColors.onPrimaryColor),
                          ),
                          gapWidth(250),
                          Text(
                            currentSinger,
                            style: AppStyles.captionTextBold
                                .copyWith(color: AppColors.onPrimaryColor),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: AppColors.onPrimaryColor,
                          ))
                    ],
                  ),
                )
              ],
            ),
            gapHeight(50),
            Slider.adaptive(
              activeColor: AppColors.primaryColor,
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                await audioPlayer.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatTime(position),
                    style: AppStyles.bodyRegularText.copyWith(
                      color: AppColors.onPrimaryColor,
                    ),
                  ),
                  Text(
                    formatTime(duration - position),
                    style: AppStyles.bodyRegularText.copyWith(
                      color: AppColors.onPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shuffle,
                      color: AppColors.onPrimaryColor,
                      size: 25,
                    )),
                IconButton(
                  onPressed: () async {
                    if (isPlaying) {
                      setState(() async {
                        await audioPlayer.stop();
                      });
                    } else {
                      setState(() async {
                        await audioPlayer.play(
                          (UrlSource(
                            widget.songs[widget.index - 1]["audio"]["filePath"],
                          )),
                        );
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.skip_previous,
                    color: AppColors.onPrimaryColor,
                    size: 25,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: AppColors.onPrimaryColor,
                  radius: 20,
                  child: IconButton(
                    onPressed: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } else {
                        audioPlayer.play(
                          (UrlSource(url)),
                        );
                      }
                    },
                    icon: Icon(
                      isPlaying == true ? Icons.pause : Icons.play_arrow,
                      color: AppColors.secondaryColor,
                      size: 25,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.stop();
                    } else {
                      setState(() {
                        audioPlayer.play(
                          (UrlSource(
                            widget.songs[widget.index + 1]["audio"]["filePath"],
                          )),
                        );
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.skip_next,
                    color: AppColors.onPrimaryColor,
                    size: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: AppColors.onPrimaryColor,
                    size: 25,
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
