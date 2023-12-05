import 'package:flutter/material.dart';

import 'package:imisi/Onboard/Screens/splash_screen.dart';
import 'package:scaled_size/scaled_size.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScaledSize(
        allowTextScaling: true,
        builder: () {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            
         
            home: SplashScreen(),
          );
        });
  }
}
