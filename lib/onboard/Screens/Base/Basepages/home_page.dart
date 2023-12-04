import 'package:flutter/material.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Widget/top_artist_widget.dart';
import 'package:imisi/Widget/top_songs_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                  ),
                  color: Colors.white,
                ),
              ),
              gapHeight(40),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      "Top Songs",
                      style: AppStyles.agTitle3Bold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Image.asset("assets/images/point.png"),
                    gapWidth(5),
                    Text(
                      "8 Points",
                      style: AppStyles.bodyBold.copyWith(color: Colors.white),
                    ),
                    gapWidth(15)
                  ],
                ),
              ),
              gapHeight(20),

              // TODO: WHEN FETCHING API WE CHANGE IT TO LISTVIEW BUILDER😒
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      TopSongsWidget(),
                      TopSongsWidget(),
                      TopSongsWidget(),
                      TopSongsWidget(),
                    ],
                  ),
                ),
              ),
              gapHeight(20),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Top Artistes",
                  style: AppStyles.agTitle3Bold.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              gapHeight(20),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TopArtisteWidget(),
                      TopArtisteWidget(),
                      TopArtisteWidget(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
