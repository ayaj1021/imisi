import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShowPointsService {
  Future<void> showPoints() async {
    String url = 'https://imisi-backend-service.onrender.com/api/listen/points';
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    var headers = {
      'Authorization': "Bearer $token",
    };
    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else {}
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
