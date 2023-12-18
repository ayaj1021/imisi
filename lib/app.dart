import 'package:flutter/material.dart';
import 'package:imisi/Provider/artiste_provider.dart';
import 'package:imisi/Services/upload_file_service.dart';

import 'package:imisi/onboard/Onboard%20Screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:scaled_size/scaled_size.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScaledSize(
        allowTextScaling: true,
        builder: () {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => ArtistProvider()),
              ChangeNotifierProvider(create: (context) => UploadFileService()),
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
        });
  }
}
