import 'package:flutter/material.dart';
import 'package:imisi/Services/get_playlist_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        title: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.onPrimaryColor,
            )),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: GetPlayList().getPlayList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'You have no playlist yet',
                          style: AppStyles.bodyBold
                              .copyWith(color: AppColors.onPrimaryColor),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Create playlist ',
                            style: AppStyles.bodyBold
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString(),
                      style: AppStyles.bodyBold
                          .copyWith(color: AppColors.onPrimaryColor));
                } else {
                  return Text(snapshot.data.toString(),
                      style: AppStyles.bodyBold
                          .copyWith(color: AppColors.onPrimaryColor));
                }
              })
        ],
      )),
    );
  }
}
