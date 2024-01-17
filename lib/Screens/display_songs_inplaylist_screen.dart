import 'package:flutter/material.dart';

import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';

class DisplaySongsInPlayListScreen extends StatelessWidget {
  const DisplaySongsInPlayListScreen(
      {super.key, required this.playListTitle, required this.allSongs, required playListId});
  final String playListTitle;

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
        child: ListView.builder(
          itemCount: allSongs.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                gapHeight(20),
                const Row(
                  children: [
                    
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
