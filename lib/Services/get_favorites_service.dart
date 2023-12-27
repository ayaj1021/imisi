import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetFavoriteService {
  Future getFavorite() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    try {
      String url =
          'https://imisi-backend-service.onrender.com/api/favorites/music';
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      });
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else {
        print(data);
        print(response.statusCode);
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
