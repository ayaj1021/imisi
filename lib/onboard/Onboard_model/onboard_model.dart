import 'package:flutter/material.dart';

class OnBoardModel {
  final String image;
  final String titleText;

  OnBoardModel({
    required this.image,
    required this.titleText,
  });
}

List<OnBoardModel> contents = [
  OnBoardModel(
    image: 'assets/images/onboard_image1.png',
    titleText: 'Enjoy the best gospel music from your favorite gospel artiste',
  ),
  OnBoardModel(
    image: 'assets/images/onboard_image2.png',
    titleText: 'Enjoy the best gospel music from your favorite gospel artiste',
  ),
    OnBoardModel(
    image: 'assets/images/onboard_image2.png',
    titleText: 'Enjoy the best gospel music from your favorite gospel artiste',
  ),
];

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
