import 'package:flutter/material.dart';
import 'package:imisi/Screens/favorites_screen.dart';
import 'package:imisi/Screens/playlist_screen.dart';
import 'package:imisi/Screens/points_screen.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:scaled_size/scaled_size.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 225.rw,
      shadowColor: Colors.black87,
      elevation: 10,
      backgroundColor: AppColors.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 23),
        child: ListView(
          children: [
            Center(
              child: SizedBox(
                height: 60,
                width: 40,
                child: Image.asset(
                  'assets/logos/Imisi_logo1.png',
                ),
              ),
            ),
            gapHeight(33),

            // CircleAvatar(
            //   radius: 50,
            //   child: Image.asset('assets/images/drawer_image.png'),
            // ),
            // gapHeight(28),

            ListTile(
              onTap: () => nextPage(const PointsScreen(), context),
              contentPadding: const EdgeInsets.symmetric(horizontal: 28),
              leading: const Icon(
                Icons.workspace_premium_rounded,
                color: AppColors.onPrimaryColor,
              ),
              title: Text(
                'Points',
                style: AppStyles.agTitle3Bold
                    .copyWith(color: AppColors.onPrimaryColor),
              ),
            ),
            ListTile(
              onTap: () => nextPage(const PlayListScreen(), context),
              contentPadding: const EdgeInsets.symmetric(horizontal: 28),
              leading: const Icon(
                Icons.queue_music_outlined,
                color: AppColors.onPrimaryColor,
              ),
              title: Text(
                'Playlists',
                style: AppStyles.agTitle3Bold
                    .copyWith(color: AppColors.onPrimaryColor),
              ),
            ),
            ListTile(
              onTap: () => nextPage(const FavoriteScreen(), context),
              contentPadding: const EdgeInsets.symmetric(horizontal: 28),
              leading: const Icon(
                Icons.favorite_outline,
                color: AppColors.onPrimaryColor,
              ),
              title: Text(
                'Favorites',
                style: AppStyles.agTitle3Bold
                    .copyWith(color: AppColors.onPrimaryColor),
              ),
            ),
            // ListTile(
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 28),
            //   leading: const Icon(
            //     Icons.person_outline,
            //     color: AppColors.onPrimaryColor,
            //   ),
            //   title: Text(
            //     'Profile',
            //     style: AppStyles.agTitle3Bold
            //         .copyWith(color: AppColors.onPrimaryColor),
            //   ),
            // ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 28),
              leading: const Icon(
                Icons.logout_outlined,
                color: AppColors.onPrimaryColor,
              ),
              title: Text(
                'Logout',
                style: AppStyles.agTitle3Bold
                    .copyWith(color: AppColors.onPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
