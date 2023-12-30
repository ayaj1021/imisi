import 'package:flutter/material.dart';
import 'package:imisi/Models/get_all_music_model.dart';
import 'package:imisi/Screens/drawer.dart';
import 'package:imisi/Screens/playing_music_screen.dart';
import 'package:imisi/Services/get_all_music_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';

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
          child: Stack(
        children: [
          ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
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
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
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
                                  left: 15, right: 10, bottom: 10),
                              // height: 150.rh,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 80.rh,
                                    width: 80.rw,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            musicList[index].image!.filePath ??
                                                ""),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  gapWidth(5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        musicList[index].name ?? "",
                                        style: AppStyles.agTitle3Bold.copyWith(
                                          color: AppColors.onPrimaryColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                      gapHeight(3),
                                      Text(
                                        musicList[index].artist ?? "",
                                        style: AppStyles.title4Bold.copyWith(
                                          color: AppColors.onPrimaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  }),

              // gapHeight(20),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15),
              //   child: Text(
              //     "Videos",
              //     style: AppStyles.agTitle3Bold.copyWith(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // gapHeight(20),
              // const Padding(
              //   padding: EdgeInsets.only(left: 15),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: [
              //         TopArtisteWidget(),
              //         TopArtisteWidget(),
              //         TopArtisteWidget(),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
          // Positioned(
          //   // top: 10,
          //   bottom: 0,
          //   child: Container(
          //     height: 70,
          //     width: MediaQuery.of(context).size.width,
          //     decoration: BoxDecoration(
          //       color: AppColors.upLoadContainerColor.withOpacity(
          //         0.5,
          //       ),
          //     ),
          //     child: Column(
          //       children: [
          //         //Slider.adaptive(value: 0.0, onChanged: (value) {}),
          //         Row(
          //           children: [
          //             Container(
          //               height: 50,
          //               width: 80,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(8),
          //                 image: const DecorationImage(
          //                   image: NetworkImage(
          //                 //      musicList[index].image!.filePath ??
          //                           ""),
          //                   fit: BoxFit.cover,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
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
