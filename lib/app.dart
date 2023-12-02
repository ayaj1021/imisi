import 'package:flutter/material.dart';
import 'package:imisi/Artiste/Screens/Base/base_page.dart';
import 'package:scaled_size/scaled_size.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScaledSize(
        allowTextScaling: true,
        builder: () {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: BasePage(),
          );
        });
  }
}
