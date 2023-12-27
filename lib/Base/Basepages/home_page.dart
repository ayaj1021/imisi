import 'package:flutter/material.dart';
import 'package:imisi/Models/get_all_music_model.dart';
import 'package:imisi/Screens/drawer.dart';
import 'package:imisi/Screens/playing_music_screen.dart';
import 'package:imisi/Services/get_all_music_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Widget/top_artist_widget.dart';
import 'package:scaled_size/scaled_size.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getAllMusic = GetAllMusicService().getAllMusic();
  @override
  void initState() {
    // isLoading = true;
    // Future.delayed(const Duration(seconds: 4), () {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    super.initState();
    getAllMusic;
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
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
                FutureBuilder(
                    future: getAllMusic,
                    //GetAllMusicService().getAllMusic(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData) {
                        return Text(
                          'No data',
                          style: AppStyles.bodyBold
                              .copyWith(color: AppColors.primaryColor),
                        );
                      } else if (snapshot.hasData) {
                        final List<GetAllMusicModel> musicList = snapshot.data!;
                        return SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: musicList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  nextPage(
                                      PlayingMusicScreen(
                                          songs: musicList, index: index),
                                      context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, right: 10),
                                  height: 150.rh,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 150.rh,
                                        width: 130.rw,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(musicList[index]
                                                    .image!
                                                    .filePath ??
                                                ""),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        // child: Image.network(
                                        //     musicList[index]
                                        //             .image!
                                        //             .filePath ??
                                        //         ""),
                                      ),
                                      gapHeight(5),
                                      Text(
                                        musicList[index].artist ?? "",
                                        style: AppStyles.bodyBold.copyWith(
                                          color: AppColors.onPrimaryColor,
                                        ),
                                      ),
                                      gapHeight(2),
                                      Text(
                                        musicList[index].name ?? "",
                                        style:
                                            AppStyles.bodyRegularText.copyWith(
                                          color: AppColors.onPrimaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Container();
                    }),
                gapHeight(20),
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
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TopArtisteWidget(),
                        TopArtisteWidget(),
                        TopArtisteWidget(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
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
