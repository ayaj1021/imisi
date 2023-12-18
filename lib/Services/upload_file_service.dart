// ignore_for_file: use_build_context_synchronously


import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadFileService with ChangeNotifier {
  String status = "";
  bool isUploading = false;
  Future uploadFile(
    BuildContext context, {
    required String name,
    required String genre,
    required String description,
    required File image,
    required File audio,
    required String artist,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String url = 'https://imisi-backend-service.onrender.com/api/musics';
    try {
      final body = {
        "name": name,
        "genre": genre,
        "description": description,
        "image": image,
        "audio": audio,
        "artist": artist,
      };
      print(body);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
        // body: body,
        // headers: {
        //   // 'Content-Type': 'application/json',
        //   'Authorization': "Bearer $token",
        // },
      );
      request.files.add(http.MultipartFile(
        'image',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: 'image.jpg',
      ));

      var response = await request.send();

      print(response);
      //final data = jsonDecode(response.);
      if (response.statusCode == 201) {
        isUploading = false;
        status = "Upload Successful";

        showSnackBar(context: context, message: status, isError: false);
        notifyListeners();
        nextPageAndremoveUntil(const BasePage(), context);
        return response;
      } else {
        isUploading = false;
        status = "Upload Unsuccessful ";
        //showSnackBar(context: context, message: status, isError: true);
        showSnackBar(context: context, message: status, isError: true);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
