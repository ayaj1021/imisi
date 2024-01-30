import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:imisi/Models/get_all_music_model.dart';
import 'package:imisi/Screens/drawer.dart';
import 'package:imisi/Screens/music_playing_screen.dart';
import 'package:imisi/Services/get_all_music_service.dart';
import 'package:imisi/Services/get_all_video_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/components/song_component.dart';
import 'package:imisi/components/video_component.dart';

import 'package:scaled_size/scaled_size.dart';

class HomePage extends StatefulWidget {
  final AudioPlayer player;

  const HomePage({
    super.key,
    required this.player,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getAllMusic = GetAllMusicService().getAllMusic();
  //List<GetAllMusicModel> songs = [];
  Future getAllVideo = GetAllVideoService().getAllVideos();

  final List<GetAllMusicModel>? allMusic = [];

  @override
  void initState() {
    super.initState();
    // getAllMusic;
  }

  bool isPlaying = false;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: AppColors.onPrimaryColor,
          backgroundColor: AppColors.secondaryColor,
          bottom: TabBar(indicatorColor: AppColors.primaryColor, tabs: [
            Tab(
              child: Text(
                'Songs',
                style: AppStyles.agTitle3Bold.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Videos',
                style: AppStyles.agTitle3Bold.copyWith(
                  color: Colors.white,
                ),
              ),
            )
          ]),
        ),
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.secondaryColor,
        body: TabBarView(children: [
          Stack(
            children: [
              SongsComponent(
                image: '',
                // allMusic![selectedIndex !]
                //     .image!
                //     .filePath
                //     .toString(),
                index: selectedIndex ?? 0,
                getAllMusic: getAllMusic,
                player: widget.player,
              ),
              if (selectedIndex != null)
                Positioned(
                  // bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      nextPage(
                          MusicPlayingScreen(
                            songs: [],
                            index: selectedIndex!,
                          ),
                          context);
                    },
                    child: Container(
                      height: 50.rh,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.upLoadContainerColor.withOpacity(
                          0.9,
                        ),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: 45,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        allMusic![selectedIndex!]
                                            .image!
                                            .filePath
                                            .toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      allMusic![selectedIndex ?? 0]
                                          .name
                                          .toString(),
                                      style: AppStyles.agTitle3Bold.copyWith(
                                        color: AppColors.onPrimaryColor,
                                      ),
                                    ),
                                    Text(
                                      allMusic![selectedIndex ?? 0]
                                          .artist
                                          .toString(),
                                      style: AppStyles.title4Bold.copyWith(
                                        color: AppColors.onPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  isPlaying
                                      ? widget.player.pause()
                                      : widget.player.resume();
                                  // if (isPlaying == true) {
                                  //   widget.player.pause();
                                  // } else {
                                  //   widget.player.resume();
                                  // }
                                },
                                icon: Icon(
                                  isPlaying == true
                                      ? Icons.play_arrow
                                      : Icons.pause,
                                  color: AppColors.onPrimaryColor,
                                ))
                          ]),
                    ),
                  ),
                )
              else
                SizedBox(),
            ],
          ),
          VideoComponent(getAllVideo: getAllVideo),
        ]),
      ),
    );
  }
}

class SkeletonLoadingWidget extends StatelessWidget {
  const SkeletonLoadingWidget({
    super.key,
    this.height,
    this.width,
  });
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16)),
    );
  }
}
