import 'package:flutter/material.dart';
import 'package:imisi/Screens/create_playlist_screen.dart';
import 'package:imisi/Screens/display_songs_inplaylist_screen.dart';
import 'package:imisi/Services/add_music_to_playlist_service.dart';
import 'package:imisi/Services/delete_playlist_service.dart';
import 'package:imisi/Services/get_all_music_service.dart';
import 'package:imisi/Services/get_playlist_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/audio_id.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/show_alert_dialog.dart';
import 'package:imisi/Utils/show_modal_bottom_sheet_widget.dart';
import 'package:provider/provider.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key, this.musicId});
  final String? musicId;
  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  final getMusic = GetAllMusicService().getAllMusic();
  bool isLoading = false;
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
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data[index];
                        return Column(
                          children: [
                            gapHeight(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => nextPage(
                                      DisplaySongsInPlayListScreen(allSongs: [
                                        snapshot.data[index]["musics"],
                                      ], playListTitle: data["name"]),
                                      context),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.queue_music_rounded,
                                        color: AppColors.primaryColor,
                                        size: 45,
                                      ),
                                      gapWidth(10),
                                      Consumer<AddMusicToPlaylistService>(
                                          builder: (context, addMusicToPlaylist,
                                              child) {
                                        return GestureDetector(
                                          onTap: () {
                                            addMusicToPlaylist
                                                .addMusicToPlaylist(
                                              context,
                                              playListId: data["_id"],

                                              //  musicId: getMusic.
                                            );
                                            AudioId.audioId =
                                                "${widget.musicId}";
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
                                                  color:
                                                      AppColors.onPrimaryColor,
                                                ),
                                              ),
                                              Text(
                                                '${snapshot.data[index]["musics"].length} songs',
                                                style: AppStyles.captionText
                                                    .copyWith(
                                                  color:
                                                      AppColors.onPrimaryColor,
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
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.edit_note_outlined,
                                              color: AppColors.primaryColor,
                                              size: 35,
                                            ),
                                            gapWidth(10),
                                            Text(
                                              'Edit playlist name',
                                              style: AppStyles.title2.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.onPrimaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        gapHeight(10),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            showAlertDialog(
                                              context,
                                              message:
                                                  'Are you sure you want to delete playlist?',
                                              yesTextOnTap: () {
                                                Navigator.pop(context);
                                                AudioId.audioId =
                                                    "${data["_id"]}";
                                                setState(() {
                                                  isLoading = true;
                                                });

                                                DeletePlaylistService()
                                                    .deletePlayList(
                                                  context,
                                                );
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.delete_outline,
                                                color: AppColors.primaryColor,
                                                size: 30,
                                              ),
                                              gapWidth(10),
                                              Text(
                                                'Delete playlist',
                                                style:
                                                    AppStyles.title2.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.onPrimaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]);
                                    },
                                    icon: const Icon(
                                      Icons.more_vert_outlined,
                                      color: AppColors.onPrimaryColor,
                                    ))
                              ],
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
