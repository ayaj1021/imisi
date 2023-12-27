// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:imisi/Screens/playlist_screen.dart';
import 'package:imisi/Utils/audio_id.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/snack_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DeletePlaylistService {
  Future<void> deletePlayList(BuildContext? context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    final notId = AudioId.audioId;
   
    String url =
        'https://imisi-backend-service.onrender.com/api/playlists/$notId';
    try {
      var response = await http.delete(Uri.parse(url), headers: {
        'Authorization': "Bearer $token",
      });
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
       
        showSnackBar(context: context!, message: data["message"]);
        nextPageAndremoveUntil(const PlayListScreen(), context);
    

      
      } else {
        showSnackBar(context: context!, message: data["message"]);
       
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
