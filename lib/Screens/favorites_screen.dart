import 'package:flutter/material.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Services/get_favorites_service.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Utils/navigator.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        title: IconButton(
            onPressed: () {
              nextPage(const BasePage(), context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.onPrimaryColor,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder(
            future: GetFavoriteService().getFavorite(),
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
                          'You have no songs yet',
                          style: AppStyles.bodyBold
                              .copyWith(color: AppColors.onPrimaryColor),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        final data = snapshot.data[index];
                        return Column(
                          children: [
                            SizedBox(
                              height: 48,
                              width: 48,
                              child: ClipRRect(
                                child: Image.network(data["image"]["filePath"]),
                              ),
                            ),
                            gapWidth(10),
                            Text(
                              data["artist"],
                              style: AppStyles.bodyBold.copyWith(
                                color: AppColors.onPrimaryColor,
                              ),
                            ),
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
