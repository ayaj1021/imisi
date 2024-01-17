import 'dart:convert';

import 'package:imisi/Models/get_all_music_model.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetSinglePlaylist {
  Future getSinglePlaylist({required String playlistId}) async {
    List<GetAllMusicModel> allMusicList = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    final String url =
        'https://imisi-backend-service.onrender.com/api/playlists/$playlistId';
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
        //'Authorization': " $token",
      });

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        allMusicList =
            body.map((music) => GetAllMusicModel.fromJson(music)).toList();
      } else {
        Logger().e(response.body);
      }
    } catch (e) {
      Logger().e(e);
      throw Exception('Error $e');
    }
    return allMusicList;
  }
}
