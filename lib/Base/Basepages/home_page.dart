import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:imisi/Screens/drawer.dart';
import 'package:imisi/Services/get_all_music_service.dart';
import 'package:imisi/Services/get_all_video_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/page_manager.dart';
import 'package:imisi/audio_player_service/audio_handler.dart';
import 'package:imisi/components/song_component.dart';
import 'package:imisi/components/video_component.dart';

class HomePage extends StatefulWidget {
  final MyAudioHandler audioHandler;
  const HomePage({super.key, required this.audioHandler});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getAllMusic = GetAllMusicService().getAllMusic();
  //List<GetAllMusicModel> songs = [];
  List<MediaItem> songs = [];
  late final PageManager pageManager;
  Future getAllVideo = GetAllVideoService().getAllVideos();

  @override
  void initState() {
    super.initState();
    // getAllMusic;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.onPrimaryColor,
        backgroundColor: AppColors.secondaryColor,
      ),
      drawer: const DrawerWidget(),
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Songs",
                style: AppStyles.agTitle3Bold.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            gapHeight(20),
            SongsComponent(getAllMusic: getAllMusic),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Videos",
                style: AppStyles.agTitle3Bold.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            gapHeight(20),
            VideoComponent(getAllVideo: getAllVideo),
          ],
        ),
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
