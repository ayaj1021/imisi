import 'package:flutter/material.dart';

import 'package:imisi/Services/add_music_favorites.dart';
import 'package:imisi/Services/add_music_to_playlist_service.dart';

import 'package:imisi/Services/auth_service.dart';
import 'package:imisi/Services/delete_playlist_service.dart';
import 'package:imisi/Services/get_points_service.dart';

import 'package:imisi/Services/upload_file_service.dart';

import 'package:imisi/onboard/Onboard%20Screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:scaled_size/scaled_size.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaledSize(
      allowTextScaling: true,
      builder: () {
        return MultiProvider(
          providers: [

            ChangeNotifierProvider(create: (context) => AuthService()),
         
            ChangeNotifierProvider(create: (context) => UploadFileService()),
            ChangeNotifierProvider(create: (context) => AddMusicToFavorite()),
            ChangeNotifierProvider(create: (context) => AddMusicToPlaylistService()),
            ChangeNotifierProvider(create: (context) => DeletePlaylistService()),
           ChangeNotifierProvider(create: (context) => GetPointsService()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
