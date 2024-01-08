import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:imisi/Models/listen_to_earn_points_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetPointsService extends ChangeNotifier {
  String message = '';
  bool playAdvert = false;

  Future getPoints({required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    var headers = {
      'Authorization': "Bearer $token",
    };
    String url = 'https://imisi-backend-service.onrender.com/api/listen/$id';

    try {
      var response = await http.post(Uri.parse(url), headers: headers);
      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        message = data["message"];

        notifyListeners();

        return data;
      } else {
        //  print(data);
        // showSnackBar(
        //     context: context, message: data["message"], isError: false);
      }
    } catch (e) {

   //   throw Exception('Error $e');
    }
    // return listenToPoints;
  }
}
