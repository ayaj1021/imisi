import 'package:flutter/material.dart';
import 'package:imisi/Connection_controller/connection_controller.dart';
import 'package:imisi/Models/get_all_video_model.dart';
import 'package:imisi/Screens/video_playing_screen.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:provider/provider.dart';
import 'package:scaled_size/scaled_size.dart';

class VideoComponent extends StatelessWidget {
  const VideoComponent({super.key, required this.getAllVideo});
  final Future getAllVideo;
  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    return networkStatus == NetworkStatus.online
        ? FutureBuilder(
            future: getAllVideo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor),
                );
              } else if (snapshot.hasError) {
                return Text(
                  snapshot.error.toString(),
                  style: AppStyles.bodyBold
                      .copyWith(color: AppColors.primaryColor),
                );
              } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                return SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'No data',
                      style: AppStyles.bodyBold
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                final List<GetAllVideoModel> videoList = snapshot.data;
                return SizedBox(
                  height: 220.rh,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: videoList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            nextPage(
                                VideoPlayingScreen(
                                  videos: videoList,
                                  url: videoList[index].video!.filePath ?? "",
                                ),
                                context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              left: 25,
                              right: 10,
                              bottom: 10,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 10),
                                      height: 70.rh,
                                      width: 100.rw,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              videoList[index]
                                                      .image!
                                                      .filePath ??
                                                  "",
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Positioned(
                                      left: 100,
                                      top: 55,
                                      child: IconButton(
                                        onPressed: () {
                                          nextPage(
                                              VideoPlayingScreen(
                                                videos: videoList,
                                                url: videoList[index]
                                                        .video!
                                                        .filePath ??
                                                    "",
                                              ),
                                              context);
                                        },
                                        icon: const Icon(Icons.play_arrow),
                                        iconSize: 80,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                                gapHeight(5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      videoList[index].name ?? '',
                                      style: AppStyles.agTitle3Bold.copyWith(
                                        color: AppColors.onPrimaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      videoList[index].artist ?? '',
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
                      }),
                );
              }
              return Container();
            },
          )
        : Center(
            child: Text(
              "You are offline",
              style: AppStyles.agTitle3Bold.copyWith(
                color: AppColors.onPrimaryColor,
                fontSize: 18,
              ),
            ),
          );
  }
}
