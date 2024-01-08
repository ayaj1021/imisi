import 'package:flutter/material.dart';
import 'package:imisi/Models/get_all_music_model.dart';
import 'package:imisi/Services/get_points_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Utils/page_manager.dart';
import 'package:imisi/audio_player_service/audio_handler.dart';
import 'package:imisi/provider/audio_provider.dart';

import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:scaled_size/scaled_size.dart';

class MusicPlayingScreen extends StatefulWidget {
  final MyAudioHandler audioHandler;
  const MusicPlayingScreen({
    super.key,
    required this.audioHandler,
    required this.songs,
    //   required this.index
  });
  final List<dynamic> songs;
  //final List<GetAllMusicModel> songs;
  // final int index;
  @override
  State<MusicPlayingScreen> createState() => _MusicPlayingScreenState();
}

class _MusicPlayingScreenState extends State<MusicPlayingScreen> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  // void setAudio(String urlToPlay) {
  //   player.setReleaseMode(ReleaseMode.stop);
  //   player.play(urlToPlay);
  //   setState(() {});
  // }

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

  int index = 0;
  List<GetAllMusicModel> allSongs = [];

  late final PageManager pageManager;
  @override
  void initState() {
    super.initState();
    allSongs = widget.songs as List<GetAllMusicModel> ;
    index = context.read<AudioProvider>().currentIndex;
    // setState(() {
    //   allSongs = widget.songs;
    //   index = context.read<AudioProvider>().currentIndex;
    // });
    //  pageManager = PageManager(index, allSongs);
    //AudioSource.uri(Uri.parse(widget.songs[index].audio!.filePath!))

    if (player.playing) {
      player.seek(Duration.zero, index: index);
    } else {
      player.setAudioSource(
        ConcatenatingAudioSource(
          useLazyPreparation: true,
          children: allSongs
              .map((song) => AudioSource.uri(Uri.parse(song.audio!.filePath!)))
              .toList(),
        ),
        initialIndex: index,
        initialPosition: Duration.zero,
      );
      player.play();
    }

    //   player.setVolume(1);

    // final playerState = widget.songs[widget.index].audio!.filePath!;
    /// playerButton(widget.songs[widget.index].audio!.filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            // nextPage(const BasePage(), context),
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
                      image: DecorationImage(
                        image: NetworkImage(allSongs[index].image!.filePath!),
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shuffle,
                    color: AppColors.secondaryColor,
                    size: 25,
                  )),
              IconButton(
                onPressed: index == 0
                    ? null
                    : () async {
                        setState(() {
                          index--;
                          duration = Duration.zero;
                          position = Duration.zero;
                          player.play(
                              // (UrlSource(
                              //   allSongs[index].audio!.filePath ?? "",
                              // )),
                              );
                        });
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
                      await player.pause();
                    } else {
                      player.play();
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
                onPressed: index == allSongs.length
                    ? null
                    : () async {
                        setState(() {
                          index++;
                          duration = Duration.zero;
                          position = Duration.zero;
                          player.play(
                              // (UrlSource(
                              //   allSongs[index].audio!.filePath ?? "",
                              // )),
                              );
                        });
                        GetPointsService()
                            .getPoints(id: allSongs[index].id ?? "");
                      },
                icon: Icon(
                  Icons.skip_next,
                  color: index == allSongs.length
                      ? AppColors.upLoadContainerColor
                      : AppColors.onPrimaryColor,
                  size: 25,
                ),
              ),
            ])
          ],
        ),
      )),
    );
  }

  Widget playerButton(PlayerState playerState) {
    final processingState = playerState.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      // 2
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: 64.0,
        height: 64.0,
        child: const CircularProgressIndicator(),
      );
    } else if (player.playing != true) {
      // 3
      return IconButton(
        icon: const Icon(Icons.play_arrow),
        iconSize: 64.0,
        onPressed: player.play,
      );
    } else if (processingState != ProcessingState.completed) {
      // 4
      return IconButton(
        icon: const Icon(Icons.pause),
        iconSize: 64.0,
        onPressed: player.pause,
      );
    } else {
      // 5
      return IconButton(
        icon: const Icon(Icons.replay),
        iconSize: 64.0,
        onPressed: () =>
            player.seek(Duration.zero, index: player.effectiveIndices!.first),
      );
    }
  }
}
