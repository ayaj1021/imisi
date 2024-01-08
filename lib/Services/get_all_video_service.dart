import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imisi/Models/get_all_video_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class GetAllVideoService extends ChangeNotifier {
  Future<List<GetAllVideoModel>> getAllVideos() async {
    List<GetAllVideoModel> getAllVideosList = [];

    String url = 'https://imisi-backend-service.onrender.com/api/videos';
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        //  'Authorization': "Bearer $token",
      });

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);

        getAllVideosList =
            body.map((video) => GetAllVideoModel.fromJson(video)).toList();
      } else {
        Logger().e(response.body);
      }
    } catch (e) {
      throw Exception('Error $e');
    }
    return getAllVideosList;
  }
}
