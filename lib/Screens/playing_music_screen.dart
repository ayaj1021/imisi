import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Models/get_all_music_model.dart';
import 'package:imisi/Screens/playlist_screen.dart';
import 'package:imisi/Screens/song_details_screen.dart';
import 'package:imisi/Services/add_music_favorites.dart';
import 'package:imisi/Services/get_all_music_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/show_modal_bottom_sheet_widget.dart';
import 'package:provider/provider.dart';
import 'package:scaled_size/scaled_size.dart';

class PlayingMusicScreen extends StatefulWidget {
  const PlayingMusicScreen({
    super.key,
    required this.songs,
    required this.index,
  });
  final List<GetAllMusicModel> songs;
  final int index;
  @override
  State<PlayingMusicScreen> createState() => _PlayingMusicScreenState();
}

class _PlayingMusicScreenState extends State<PlayingMusicScreen> {
  Future getAllMusic = GetAllMusicService().getAllMusic();
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  void setAudio(String urlToPlay) {
    audioPlayer.setReleaseMode(ReleaseMode.stop);
    audioPlayer.play(UrlSource(urlToPlay));
  }

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

  @override
  void initState() {
    super.initState();

    setState(() {
      allSongs = widget.songs;
      index = widget.index;
    });

    setAudio(widget.songs[widget.index].audio!.filePath!);
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
        if (formatTime(duration - position) == "00:00") {
          index++;
          audioPlayer.play(
            (UrlSource(
              allSongs[index].audio!.filePath ?? "",
            )),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: IconButton(
            onPressed: () => nextPage(const BasePage(), context),
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
                  //child:   Image.network(allSongs[index].image!.filePath!),
                ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  child: Consumer<AddMusicToFavorite>(
                      builder: (context, addMusicFavorite, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allSongs[index].name ?? "",
                              style: AppStyles.title4Bold
                                  .copyWith(color: AppColors.onPrimaryColor),
                            ),
                            gapWidth(250),
                            Text(
                              allSongs[index].artist ?? "",
                              style: AppStyles.captionTextBold
                                  .copyWith(color: AppColors.onPrimaryColor),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              addMusicFavorite.addMusicToFavorite(
                                id: allSongs[index].id ?? "",
                                context,
                              );
                            },
                            icon: Icon(
                              addMusicFavorite.isAdded == true
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: addMusicFavorite.isAdded == true
                                  ? AppColors.primaryColor
                                  : AppColors.onPrimaryColor,
                            ))
                      ],
                    );
                  }),
                )
              ],
            ),
            gapHeight(50),
            Slider.adaptive(
              activeColor: AppColors.primaryColor,
              min: 0,
              max: duration.inSeconds.toDouble() < 2
                  ? 2.0
                  : duration.inSeconds.toDouble(),
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
                  onPressed: index == 0
                      ? null
                      : () async {
                          setState(() {
                            index--;
                            duration = Duration.zero;
                            position = Duration.zero;
                            audioPlayer.play(
                              (UrlSource(
                                allSongs[index].audio!.filePath ?? "",
                              )),
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
                        await audioPlayer.pause();
                      } else {
                        audioPlayer.resume();
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
                            audioPlayer.play(
                              (UrlSource(
                                allSongs[index].audio!.filePath ?? "",
                              )),
                            );
                          });
                        },
                  icon: Icon(
                    Icons.skip_next,
                    color: index == allSongs.length
                        ? AppColors.upLoadContainerColor
                        : AppColors.onPrimaryColor,
                    size: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheetWidget(context, [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          nextPage(
                              PlayListScreen(
                                musicId: allSongs[index].id ?? "",
                              ),
                              context);
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit_note_outlined,
                              color: AppColors.primaryColor,
                              size: 35,
                            ),
                            gapWidth(5),
                            Text(
                              'Add to playlist',
                              style: AppStyles.title2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.onPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      gapHeight(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          nextPage(
                              SongDetailsScreen(
                                artist: allSongs[index].artist ?? "",
                                name: allSongs[index].name ?? "",
                                genre: '',
                                description: '',
                              ),
                              context);
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline_rounded,
                              color: AppColors.primaryColor,
                              size: 30,
                            ),
                            gapWidth(10),
                            Text(
                              'Song details',
                              style: AppStyles.title2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.onPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  },
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
