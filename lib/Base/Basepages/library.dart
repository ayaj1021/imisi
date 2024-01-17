import 'package:flutter/material.dart';
import 'package:imisi/Screens/favorites_screen.dart';
import 'package:imisi/Screens/playlist_screen.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          'Library',
          style: AppStyles.agTitle3Bold.copyWith(
            color: AppColors.onPrimaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => nextPage(
                    const PlayListScreen(
                      isAddingSong: false,
                    ),
                    context),
                child: Row(
                  children: [
                    const Icon(
                      Icons.queue_music_outlined,
                      color: AppColors.primaryColor,
                    ),
                    gapWidth(10),
                    Text(
                      'Playlists',
                      style: AppStyles.agTitle3Bold
                          .copyWith(color: AppColors.onPrimaryColor),
                    ),
                  ],
                ),
              ),
              gapHeight(20),
              GestureDetector(
                onTap: () => nextPage(const FavoriteScreen(), context),
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite_outline,
                      color: AppColors.primaryColor,
                    ),
                    gapWidth(10),
                    Text(
                      'Favorites',
                      style: AppStyles.agTitle3Bold
                          .copyWith(color: AppColors.onPrimaryColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
