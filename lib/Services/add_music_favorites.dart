// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imisi/Utils/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMusicToFavorite with ChangeNotifier {
  bool isAdded = false;
  Future addMusicToFavorite(BuildContext context, {required String id}) async {
    isAdded = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    String url = 'https://imisi-backend-service.onrender.com/api/favorites/$id';
    var headers = {
      'Authorization': "Bearer $token",
    };

    try {
      var response = await http.post(Uri.parse(url), headers: headers);
      var data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        isAdded = true;
        showSnackBar(context: context, message: data["message"]);
        notifyListeners();
        return data;
      } else {
        isAdded = false;
        showSnackBar(context: context, message: data["message"]);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
