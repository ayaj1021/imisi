import 'package:flutter/material.dart';
import 'package:imisi/app.dart';
import 'package:imisi/audio_player_service/audio_handler.dart';

MyAudioHandler audioHandler = MyAudioHandler();
Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // Initialize AudioService with MyAudioHandler as the audio handler
  // audioHandler = await AudioService.init(
  //   builder: () => MyAudioHandler(),
  //   config: const AudioServiceConfig(
  //     androidNotificationChannelId: 'com.mycompany.myapp.channel.audio',
  //     androidNotificationChannelName: 'Music playback',
  //   ),
  // );

  runApp(
    const MyApp(),
  );
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
