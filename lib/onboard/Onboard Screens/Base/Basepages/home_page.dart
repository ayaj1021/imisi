import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:imisi/Models/get_all_music_model.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/Styles/app_text_styles.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:imisi/Widget/top_artist_widget.dart';

import 'package:http/http.dart' as http;
import 'package:scaled_size/scaled_size.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<GetAllMusicModel>> getMusic() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    print(token);

    String url = 'https://imisi-backend-service.onrender.com/api/musics';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    });
    var body = jsonDecode(response.body);
    List<GetAllMusicModel> allMusic = [];
    for (var music in body) {
      GetAllMusicModel getAllMusicModel = GetAllMusicModel.fromJson(music);
      allMusic.add(getAllMusicModel);
    }
    print(body);
    return allMusic;
  }

  List<GetAllMusicModel> allMusic = [];

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
                    //  Image.asset("assets/images/point.png"),
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

              FutureBuilder<List<GetAllMusicModel>>(
                  future: getMusic(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      //     shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              snapshot.data![index].image == null
                                  ? Container(
                                      //  height: 130.rw,
                                      width: 110.rh,
                                      color: Colors.blue,
                                    )
                                  : Container(
                                      //height: 130.rw,
                                      width: 110.rh,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(snapshot
                                              .data![index].image!.filePath
                                              .toString()),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                              gapHeight(5),
                              Text(snapshot.data![index].artist!,
                                  style: AppStyles.bodyBold.copyWith(
                                      color: AppColors.onPrimaryColor)),
                              gapHeight(2),
                              Text("Excess love",
                                  style: AppStyles.bodyRegularText.copyWith(
                                      color: AppColors.onPrimaryColor))
                            ],
                          ),
                        );
                      },
                    );
                  }),
              // const SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 15.0),
              //     child: Row(
              //       children: [
              //         TopSongsWidget(),
              //         TopSongsWidget(),
              //         TopSongsWidget(),
              //         TopSongsWidget(),
              //       ],
              //     ),
              //   ),
              // ),
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
