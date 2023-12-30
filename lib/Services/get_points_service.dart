// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imisi/Utils/audio_id.dart';
import 'package:imisi/Utils/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetPointsService with ChangeNotifier {
  Future getPoints() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    final notId = AudioId.audioId;
    var headers = {
      'Authorization': "Bearer $token",
    };
    String url = 'https://imisi-backend-service.onrender.com/api/listen/$notId';

    try {
      var response = await http.post(Uri.parse(url), headers: headers);
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        return data;
      } else {
        print(data);
        // showSnackBar(
        //     context: context, message: data["message"], isError: false);
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
