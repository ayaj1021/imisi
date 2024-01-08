// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imisi/Models/get_all_music_model.dart';
import 'package:logger/logger.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

// Function to request and check storage permission
OnAudioQuery onAudioQuery = OnAudioQuery();
Future<void> accessStorage() async =>
    await Permission.storage.status.isGranted.then(
      (granted) async {
        if (granted == false) {
          // request  storage permission and open app settings if denied permanently

          PermissionStatus permissionStatus =
              await Permission.storage.request();
          if (permissionStatus == PermissionStatus.permanentlyDenied) {
            await openAppSettings();
          }
        }
      },
    );

class GetAllMusicService with ChangeNotifier {
  String? id;
  Future<List<GetAllMusicModel>> getAllMusic() async {
    List<GetAllMusicModel> allMusicList = [];
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // String? token = pref.getString("token");
    String url = 'https://imisi-backend-service.onrender.com/api/musics/';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        //  'Authorization': "Bearer $token",
      });

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);

        allMusicList =
            body.map((music) => GetAllMusicModel.fromJson(music)).toList();
      } else {
        //  nextPage(const LoginPage(), context);
    
        Logger().e(response.body);
      }
    } catch (e) {
      Logger().e(e);
      throw Exception('Error $e');
    }
    return allMusicList;
  }
}

Future<Uint8List?> art({required int id}) async {
  return await onAudioQuery.queryArtwork(id, ArtworkType.AUDIO, quality: 100);
}

class FetchSongs {
  // static method to execute fetching songs asynchronously
  static Future<List<MediaItem>> execute() async {
    // Initialize an empty list to store MediaItems
    List<MediaItem> items = [];

    // Ensure storage permission is granted before proceeding
    await accessStorage().then(
      (_) async {
        // Query songs using OnAudioQuery
        List<SongModel> songs = await onAudioQuery.querySongs();

        // loop through the retrieved songs and convert them to MediaItem
        for (SongModel song in songs) {
          if (song.isMusic == true) {
            // Retrieve artwork for the song
            Uint8List? uint8list = await art(id: song.id);
            List<int> bytes = [];
            if (uint8list != null) {
              bytes = uint8list.toList();
            }

            // add the converted song to the list of MediaItems
            items.add(
              MediaItem(
                id: song.uri!,
                title: song.title,
                artist: song.artist,
                duration: Duration(milliseconds: song.duration!),
                artUri: uint8list == null ? null : Uri.dataFromBytes(bytes),
              ),
            );
          }
        }
      },
    );
    return items;
  }
}
