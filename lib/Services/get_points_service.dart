import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imisi/Models/listen_to_earn_points_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetPointsService with ChangeNotifier {
  String message = '';
  bool playAdvert = false;
  int points = 0;
  Future getPoints({required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    // ListenToSongToEarnPointsModel listenToPoints =
    //     ListenToSongToEarnPointsModel(
    //         message: message, playAdvertisement: playAdvert);

    var headers = {
      'Authorization': "Bearer $token",
    };
    String url = 'https://imisi-backend-service.onrender.com/api/listen/$id';

    try {
      var response = await http.post(Uri.parse(url), headers: headers);
      var data = jsonDecode(response.body);

      print(data);
      if (response.statusCode == 200) {
       // listenToPoints = ListenToSongToEarnPointsModel.fromJson(data);
        points = data["user"]["points"];
        print(data["user"]["points"]);
        notifyListeners();
        return data;
      } else {
        print(data);
        // showSnackBar(
        //     context: context, message: data["message"], isError: false);
      }
    } catch (e) {
      //   throw Exception('Error $e');
    }
   // return listenToPoints;
  }
}
