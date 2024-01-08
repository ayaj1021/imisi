// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imisi/Utils/audio_id.dart';
import 'package:imisi/Utils/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMusicToPlaylistService with ChangeNotifier {
  bool isAddMusic = false;
  Future addMusicToPlaylist(BuildContext context,
      {required String playListId}) async {
    isAddMusic = true;
    notifyListeners();
     final musicId = AudioId.audioId;
    String url =
        'https://imisi-backend-service.onrender.com/api/playlists/$playListId/addMusic/$musicId';

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    try {
      var response = await http.post(Uri.parse(url), headers: {
        // 'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      });
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isAddMusic = false;

        showSnackBar(
            context: context, message: data["message"], isError: false);
        notifyListeners();
        return data;
      } else {
        isAddMusic = false;
        showSnackBar(context: context, message: data["message"], isError: true);

        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
