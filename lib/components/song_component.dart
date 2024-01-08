import 'package:flutter/material.dart';
import 'package:imisi/Models/get_all_music_model.dart';
import 'package:imisi/Screens/playing_music_screen.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/provider/audio_provider.dart';
import 'package:provider/provider.dart';
import 'package:scaled_size/scaled_size.dart';

class SongsComponent extends StatelessWidget {
  const SongsComponent({
    super.key,
    required this.getAllMusic,
  });

  final Future getAllMusic;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllMusic,
        //GetAllMusicService().getAllMusic(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
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
          } else if (snapshot.hasData) {
            final List<GetAllMusicModel> musicList = snapshot.data!;
            return SizedBox(
              height: 170.rh,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: musicList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.read<AudioProvider>().setIndex(index);

                      nextPage(
                          PlayingMusicScreen(
                            songs: musicList,
                            //index: index
                          ),
                          context);
                    },
                    child:
                        // ListTile(
                        //   leading: Container(
                        //     height: 80,
                        //     width: 80,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(8),
                        //       image: DecorationImage(
                        //         image: NetworkImage(
                        //             musicList[index].image!.filePath ?? ""),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        //   title: Text(
                        //     musicList[index].name ?? "",
                        //     style: AppStyles.title2.copyWith(
                        //       color: AppColors.onPrimaryColor,
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   subtitle: Text(
                        //     musicList[index].artist ?? "",
                        //     style: AppStyles.title4Bold.copyWith(
                        //       color: AppColors.onPrimaryColor,
                        //       fontSize: 14,
                        //     ),
                        //   ),
                        // )

                        Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120.rh,
                            width: 250.rw,
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
              ),
            );
          }
          return Container();
        });
  }
}
