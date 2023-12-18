import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetAllMusicService {
  Future getAllMusic() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String url = 'https://imisi-backend-service.onrender.com/api/musics';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      });

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        // print(response.body);
        // print(response.statusCode);
        return body;
      } else {
        print(response.body);
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}

Future getMusic() async {}
