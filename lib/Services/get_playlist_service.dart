import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetPlayList {
  Future getPlayList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    String url =
        'https://imisi-backend-service.onrender.com/api/playlists/list';

    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
      //'Authorization': " $token",
    });

    var data = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return data;
    } else {
     
    }

    return data;
  }
}
