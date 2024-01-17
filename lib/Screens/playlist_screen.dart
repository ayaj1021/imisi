import 'package:flutter/material.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Screens/create_playlist_screen.dart';
import 'package:imisi/Screens/display_songs_inplaylist_screen.dart';

import 'package:imisi/Services/add_music_to_playlist_service.dart';
import 'package:imisi/Services/delete_playlist_service.dart';
import 'package:imisi/Services/get_playlist_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/show_modal_bottom_sheet_widget.dart';
import 'package:provider/provider.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key, this.musicId, required this.isAddingSong});
  final String? musicId;
  final bool isAddingSong;
  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  //final getMusic = GetAllMusicService().getAllMusic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
              nextPage(const BasePage(), context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.onPrimaryColor,
            )),
        title: Text(
          'Playlists',
          style: AppStyles.agTitle3Bold.copyWith(
            color: AppColors.onPrimaryColor,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          future: GetPlayList().getPlayList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              );
            } else {
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You have no playlist yet',
                        style: AppStyles.bodyBold
                            .copyWith(color: AppColors.onPrimaryColor),
                      ),
                      TextButton(
                        onPressed: () =>
                            nextPage(const CreatePlayListScreen(), context),
                        child: Text(
                          'Create playlist',
                          style: AppStyles.bodyBold
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    Row(children: [
                      GestureDetector(
                        onTap: () =>
                            nextPage(const CreatePlayListScreen(), context),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: AppColors.upLoadContainerColor,
                          ),
                          child: const Icon(Icons.add,
                              color: AppColors.onPrimaryColor),
                        ),
                      ),
                      gapWidth(10),
                      Text(
                        'Create new playlist',
                        style: AppStyles.title2.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.onPrimaryColor,
                        ),
                      )
                    ]),

                    //Display all playlists
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        final data = snapshot.data[index];
                        return Column(
                          children: [
                            gapHeight(20),
                            GestureDetector(
                              onTap: () {
                                print('Tapped');
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print('Tapped');
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.queue_music_rounded,
                                          color: AppColors.primaryColor,
                                          size: 45,
                                        ),
                                        gapWidth(10),
                                        //This is where the add music to playlist is called
                                        Consumer<AddMusicToPlaylistService>(
                                            builder: (context,
                                                addMusicToPlaylist, child) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (widget.isAddingSong == true) {
                                                addMusicToPlaylist
                                                    .addMusicToPlaylist(
                                                  context,
                                                  musicId: "${widget.musicId}",
                                                  playListId: data["_id"],
                                                );
                                              } else {
                                                nextPage(
                                                    DisplaySongsInPlayListScreen(
                                                        playListId: data["_id"],
                                                        allSongs:
                                                            snapshot.data[index]
                                                                ["musics"],
                                                        playListTitle:
                                                            data["name"]),
                                                    context);
                                              }
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data["name"],
                                                  style:
                                                      AppStyles.title2.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .onPrimaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  '${snapshot.data[index]["musics"].length} songs',
                                                  style: AppStyles.captionText
                                                      .copyWith(
                                                    color: AppColors
                                                        .onPrimaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheetWidget(context, [
                                          // Row(
                                          //   children: [
                                          //     const Icon(
                                          //       Icons.edit_note_outlined,
                                          //       color: AppColors.primaryColor,
                                          //       size: 35,
                                          //     ),
                                          //     gapWidth(10),
                                          //     Text(
                                          //       'Edit playlist name',
                                          //       style: AppStyles.title2.copyWith(
                                          //         fontWeight: FontWeight.bold,
                                          //         color: AppColors.onPrimaryColor,
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          gapHeight(10),

                                          //This is where the delete playlist method is called

                                          Consumer<DeletePlaylistService>(
                                              builder: (context,
                                                  deletePlayListService,
                                                  child) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();

                                                showDialog(
                                                    barrierDismissible: false,
                                                    barrierColor: Colors.black
                                                        .withOpacity(0.5),
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              backgroundColor:
                                                                  AppColors
                                                                      .alertDialogColor,
                                                              content: Text(
                                                                'Are you sure you want to delete playlist?',
                                                                style: AppStyles
                                                                    .bodyBold
                                                                    .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .all(20),
                                                              actions: [
                                                                Center(
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            border: Border.all(color: Colors.white)),
                                                                        height:
                                                                            48,
                                                                        width:
                                                                            78,
                                                                        child:
                                                                            TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'No',
                                                                            style:
                                                                                AppStyles.buttonText.copyWith(
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      gapWidth(
                                                                          19),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              data["_id"]);
                                                                          deletePlayListService
                                                                              .deletePlayList(
                                                                            id: data["_id"].toString(),
                                                                            context,
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color:
                                                                                AppColors.primaryColor,
                                                                          ),
                                                                          height:
                                                                              48,
                                                                          width:
                                                                              78,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              'Yes',
                                                                              style: AppStyles.buttonText.copyWith(color: AppColors.secondaryColor),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ));
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.delete_outline,
                                                    color:
                                                        AppColors.primaryColor,
                                                    size: 30,
                                                  ),
                                                  gapWidth(10),
                                                  Text(
                                                    'Delete playlist',
                                                    style: AppStyles.title2
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .onPrimaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ]);
                                      },
                                      icon: const Icon(
                                        Icons.more_vert_outlined,
                                        color: AppColors.onPrimaryColor,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              }
            }
            return const Text('Something Went Wrong!!!');
          },
        ),
      )),
    );
  }
}
