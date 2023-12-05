import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imisi/Constants/url_constants.dart';
import 'package:imisi/Database/database.dart';

class AuthService {
  Future<void> signUp(
      {required String name,
      required String email,
      required String password,
      BuildContext? context}) async {
    String url = AppConstants.baseUrl + AppConstants.register;

    Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "password": password,
    };
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    debugPrint(body.toString());

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        //  body: body,
        headers: headers,
      );
      var json = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        SharedPref().saveUserToken('token', json['token']);
        // showSnackBar(isError: true, context: context, message: "Successful");
        debugPrint(response.body);
        return json;
      } else {
        debugPrint(json['message']);
        // ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        //     backgroundColor: Colors.red, content: Text(json['message'])));
        //   debugPrint(response.body);
        // showSnackBar(
        //     isError: true, context: context, message: "${json['message']}");

        debugPrint(response.statusCode.toString());

        //  var json = jsonDecode(response.body);
      }
    } catch (e) {
      log('Error $e');
    }
  }

  Future<void> login({required String email, required String password}) async {
    // String url = AppConstants.baseUrl + AppConstants.login;
    String url = 'https://imisi-backend-service.onrender.com/api/users/login';
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    debugPrint(body.toString());
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        // body: body,
        headers: headers,
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        debugPrint(response.body);
        debugPrint(response.statusCode.toString());
        return data;
      } else {
        debugPrint(data);
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      log('Error $e');
    }
  }
}
