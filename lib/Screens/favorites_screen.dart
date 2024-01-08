import 'package:flutter/material.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Models/get_all_favorite_model.dart';
import 'package:imisi/Screens/playing_music_screen.dart';
import 'package:imisi/Services/get_favorites_service.dart';
import 'package:imisi/Services/remove_song_from_favorite.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/audio_id.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/show_alert_dialog.dart';
import 'package:imisi/Utils/show_modal_bottom_sheet_widget.dart';
import 'package:imisi/provider/audio_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future getFavorites = GetFavoriteService().getFavorite();
  @override
  void initState() {
    super.initState();
    getFavorites;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
            onPressed: () {
              nextPage(const BasePage(), context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.onPrimaryColor,
            )),
        title: Text(
          'Favorites',
          style: AppStyles.agTitle3Bold.copyWith(
            color: AppColors.onPrimaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder(
            future: getFavorites,
            //GetFavoriteService().getFavorite(),
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
                          'You have no favorite songs yet',
                          style: AppStyles.bodyBold
                              .copyWith(color: AppColors.onPrimaryColor),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  final List<GetAllFavoriteMusicModel> favoriteList =
                      snapshot.data;
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: favoriteList.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<AudioProvider>().setIndex(index);
                                nextPage(
                                    PlayingMusicScreen(
                                      //  id: data["id"],
                                    //  index: index,
                                      songs: snapshot.data,
                                    ),
                                    context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                favoriteList[index]
                                                        .image!
                                                        .filePath ??
                                                    ""),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      gapWidth(10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            favoriteList[index].name ?? "",
                                            style:
                                                AppStyles.agTitle3Bold.copyWith(
                                              color: AppColors.onPrimaryColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            favoriteList[index].artist ?? "",
                                            style:
                                                AppStyles.title4Bold.copyWith(
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
                                                  'Are you sure you want to remove from favorite?',
                                              yesTextOnTap: () {
                                                Navigator.pop(context);
                                                AudioId.audioId =
                                                    favoriteList[index].id ??
                                                        "";
                                                RemoveSongFavoriteService()
                                                    .removeSongFromFavorite(
                                                        context);
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
                                                'Remove song from favorite',
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
                                    child: const Icon(
                                      Icons.more_vert,
                                      color: AppColors.onPrimaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            gapHeight(20),
                          ],
                        );
                      });
                }
                return const Text('Something Went Wrong!!!');
              }
            },
          ),
        ),
      ),
    );
  }
}

class SidePopupMenuItems extends StatelessWidget {
  const SidePopupMenuItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          color: Colors.white,
          child: const Text(
            'Click me',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
