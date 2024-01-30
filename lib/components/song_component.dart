// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:imisi/Connection_controller/connection_controller.dart';
import 'package:imisi/Models/get_all_music_model.dart';
import 'package:imisi/Screens/music_playing_screen.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';

import 'package:provider/provider.dart';
import 'package:scaled_size/scaled_size.dart';


class SongsComponent extends StatefulWidget {
  final AudioPlayer player;
  const SongsComponent({
    Key? key,
    required this.player,
    required this.getAllMusic,
    required this.index,
    required this.image,
  }) : super(key: key);
  final int index;
  final String image;
  final Future getAllMusic;

  @override
  State<SongsComponent> createState() => _SongsComponentState();
}

class _SongsComponentState extends State<SongsComponent> {
  bool isPlaying = false;
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    return networkStatus == NetworkStatus.online
        ? FutureBuilder(
            future: widget.getAllMusic,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor),
                );
              } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                return SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      'No data',
                      style: AppStyles.bodyBold
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                  snapshot.error.toString(),
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
                        setState(() {
                          selectedIndex = index;
                        });
                        nextPage(
                            MusicPlayingScreen(
                              // id: musicList[index].id!,
                              // isPlaying: isPlaying,
                              index: index,
                              songs: musicList,
                              // player: widget.player,
                              // audioPath:
                              //     "${musicList[index].audio!.filePath}"),
                            ),
                            context);

                        // nextPage(
                        //     PlayingMusicScreen(
                        //       id: musicList[index].id!,
                        //       songs: musicList,
                        //       image: musicList[index].image!.filePath!,
                        //       audioPath:
                        //           '${musicList[index].audio!.filePath}',
                        //       index: index, songName:  musicList[index].name!,
                        //       //index: index
                        //     ),
                        //     context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          left: 25,
                          right: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70.rh,
                              width: 100.rw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      musicList[index].image!.filePath ?? ""),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            gapWidth(5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
            })
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
