import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';

class SongDetailsScreen extends StatelessWidget {
  const SongDetailsScreen(
      {super.key,
      required this.artist,
      required this.name,
      required this.genre,
      required this.description});
  final String artist;
  final String name;
  final String genre;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.onPrimaryColor,
            )),
        title: Text(
          'Song details',
          style: AppStyles.agTitle3Bold.copyWith(
            color: AppColors.onPrimaryColor,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Artiste:',
                  style: AppStyles.title4Bold.copyWith(
                    color: AppColors.onPrimaryColor,
                  ),
                ),
                gapWidth(10),
                Text(
                  artist,
                  style: AppStyles.title4Bold.copyWith(
                    color: AppColors.onPrimaryColor,
                  ),
                ),
              ],
            ),
            gapHeight(20),
            Row(
              children: [
                Text(
                  'Song title:',
                  style: AppStyles.title4Bold.copyWith(
                    color: AppColors.onPrimaryColor,
                  ),
                ),
                gapWidth(10),
                Text(
                  name,
                  style: AppStyles.title4Bold.copyWith(
                    color: AppColors.onPrimaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

// "name": "Oluwa otobi",
//         "genre": "Gospel",
//         "artist": "Sola Allyson",
//         "description": "This song produced by Sola",