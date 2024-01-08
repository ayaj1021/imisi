import 'dart:convert';

import 'package:imisi/Models/get_all_favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetFavoriteService {
  Future<List<GetAllFavoriteMusicModel>> getFavorite() async {
    List<GetAllFavoriteMusicModel> allFavoriteMusic = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    try {
      String url =
          'https://imisi-backend-service.onrender.com/api/favorites/music';
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      });
      List<dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        allFavoriteMusic = data
            .map((music) => GetAllFavoriteMusicModel.fromJson(music))
            .toList();
      } else {

      }
    } catch (e) {
      throw Exception('Error $e');
    }
    return allFavoriteMusic;
  }
}
