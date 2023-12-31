import 'package:flutter/material.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Models/get_all_music_model.dart';
import 'package:imisi/Services/get_all_music_service.dart';
import 'package:imisi/Services/get_points_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:provider/provider.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  int index = 0;
  GetAllMusicModel? allSongs;
  final getAllMusic = GetAllMusicService().getAllMusic();
  //final points = GetPointsService.getPoints(id: '');
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
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            '${Provider.of<GetPointsService>(context, listen: false).points.toString()} points',
            // 'You have ${data!["user"]["points"]}points ',
            style: AppStyles.bodyBold.copyWith(
              color: AppColors.onPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
