import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/get_all_music_model.dart';

class GetAllMusicService {
  Future<List<GetAllMusicModel>> getAllMusic() async {
    List<GetAllMusicModel> allMusicList = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String url = 'https://imisi-backend-service.onrender.com/api/musics';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      });

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        // Logger().i(response.body);
        // Logger().i(response.statusCode);
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

Future getMusic() async {}
