// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imisi/Constants/url_constants.dart';

import 'package:imisi/Utils/snackBar.dart';

class AuthService {
  signUp(
      {required String name,
      required String email,
      required String password,
      required BuildContext context}) async {
    String url = AppConstants.baseUrl + AppConstants.register;

    Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "password": password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        var json = jsonDecode(response.body);
        showSnackBar(isError: true, context: context, message: "Successful");
        return json;
      } else {
        // var json = jsonDecode(response.body);
        print("problem");
        showSnackBar(isError: false, context: context, message: 'message');
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("h")));
      }
    } catch (e) {
      log('Error $e');
    }
  }
}
