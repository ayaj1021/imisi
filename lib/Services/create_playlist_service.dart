// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imisi/Screens/playlist_screen.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePlayListService {
  Future<void> createPlayList(
      {required String name, required BuildContext context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    print(token);
    String url =
        'https://imisi-backend-service.onrender.com/api/playlists/create';

    Map<String, dynamic> body = {
      "name": name,
    };

    try {
      var response = await http.post(Uri.parse(url), body: body, headers: {
        // 'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      });
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        print(data);
        showSnackBar(
            context: context, message: "Playlist Created", isError: false);
        nextPageAndremoveUntil(const PlayListScreen(), context);

        return data;
      } else {
        print(data);
        showSnackBar(
            context: context,
            message: "Unable to create playlist",
            isError: false);
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
