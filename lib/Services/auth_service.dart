// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imisi/Constants/url_constants.dart';
import 'package:imisi/Database/database.dart';
import 'package:imisi/Utils/navigator.dart';

import 'package:imisi/Base/base_page.dart';

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
      var json = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        
        SharedPref().saveUserToken(json['token']);
        nextPage(const BasePage(), context);
        // showSnackBar(isError: true, context: context, message: "Successful");
        debugPrint(response.body);
        return json;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              json['message'],
              style: const TextStyle(color: Colors.white),
            )));
        //showSnackBar(isError: true, context: context, message: json['message']);
        debugPrint(json['message']);

        debugPrint(response.statusCode.toString());

        //  var json = jsonDecode(response.body);
      }
    } catch (e) {
      log('Error $e');
    }
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    // String url = AppConstants.baseUrl + AppConstants.login;
    String url = 'https://imisi-backend-service.onrender.com/api/users/login';
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    print(body.toString());
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        // body: body,
        headers: headers,
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

          SharedPref().saveUserToken(data['token']);
         nextPage(const BasePage(), context);

        return data;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              data['message'],
              style: const TextStyle(color: Colors.white),
            )));
        debugPrint(response.body);
        debugPrint(response.statusCode.toString());
        // var json = jsonDecode(response.body);

        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("h")));
      }
    } catch (e) {
      log('Error $e');
    }
  }
}
