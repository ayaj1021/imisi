import 'package:flutter/material.dart';
import 'package:imisi/Models/get_all_music_model.dart';
import 'package:imisi/Services/get_single_playlist_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/show_alert_dialog.dart';
import 'package:imisi/Utils/show_modal_bottom_sheet_widget.dart';

class DisplaySongsInPlayListScreen extends StatelessWidget {
  const DisplaySongsInPlayListScreen(
      {super.key,
      required this.playListTitle,
      required this.allSongs,
      required this.playListId});
  final String playListTitle;
  final String playListId;

  final List allSongs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              //nextPage(const PlayListScreen(), context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.onPrimaryColor,
            )),
        title: Text(
          playListTitle,
          style: AppStyles.agTitle3Bold.copyWith(
            color: AppColors.onPrimaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder(
              future:
                  GetSinglePlaylist().getSinglePlaylist(playlistId: playListId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                } else if (snapshot.data.isEmpty) {
                  return Center(
                    child: Text(
                      'You have no song in this playlist',
                      style: AppStyles.bodyBold
                          .copyWith(color: AppColors.onPrimaryColor),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final List<GetAllMusicModel> data = snapshot.data;
                  return ListView.builder(
                    itemCount: allSongs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          gapHeight(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            data[index].image!.filePath ?? ""),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  gapWidth(10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].name ?? "",
                                        style: AppStyles.agTitle3Bold.copyWith(
                                          color: AppColors.onPrimaryColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        data[index].artist ?? "",
                                        style: AppStyles.title4Bold.copyWith(
                                          color: AppColors.onPrimaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheetWidget(context, [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showAlertDialog(
                                          context,
                                          message:
                                              'Are you sure you want to remove from this playlist?',
                                          yesTextOnTap: () {
                                            //  print(snapshot.data["id"]);
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.delete_outline,
                                            color: AppColors.primaryColor,
                                            size: 35,
                                          ),
                                          gapWidth(10),
                                          Text(
                                            'Remove song from playlist',
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
                                child: const Icon(
                                  Icons.more_vert,
                                  color: AppColors.onPrimaryColor,
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }
}
