// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Constants/url_constants.dart';
import 'package:imisi/Database/database.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  String? accountTypes;
  bool isLoggingIn = false;

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
      if (response.statusCode == 201) {
        SharedPref().saveUserToken(json['token']);
        nextPage(const BasePage(), context);
        // showSnackBar(isError: true, context: context, message: "Successful");
        debugPrint(response.body);
        return json;
      } else {
        // ScaffoldMessenger.of(context!).showSnackBar(
        //   SnackBar(

        showSnackBar(context: context, message: json['message']);
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(

        //     backgroundColor: Colors.red,
        //     content: Text(
        //       json['message'],
        //       style: const TextStyle(color: Colors.white),

        //     ),
        //   ),
        // );
        showSnackBar(isError: true, context: context, message: json['message']);

        //     )));
        //showSnackBar(isError: true, context: context, message: json['message']);

        debugPrint(json['message']);

        debugPrint(response.statusCode.toString());

        //  var json = jsonDecode(response.body);
      }
    } catch (e) {
      log('Error $e');
    }
  }

  Future login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoggingIn = true;
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? accountType = sf.getString("account_type");

    if (accountType == "Artist") {
      accountTypes = "users";
      notifyListeners();
    } else if (accountType == "Listener") {
      accountTypes = "listeners";
      notifyListeners();
    } else if (accountType == null) {
      isLoggingIn = false;
      notifyListeners();

      showSnackBar(context: context, message: "message");
    }

    String url =
        'https://imisi-backend-service.onrender.com/api/$accountTypes/login';
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        SharedPref().saveUserToken(data['token']);
        print(response.body);
        showSnackBar(
            context: context,
            message: "Logged in Successfully",
            isError: false);
        nextPage(const BasePage(), context);
        isLoggingIn = false;
        notifyListeners();
        return data;
      } else {
        print(response.body);
        isLoggingIn = false;
        notifyListeners();
        showSnackBar(context: context, message: data['message'], isError: true);

        showSnackBar(context: context, message: "Logged in Successfully");
        nextPage(const BasePage(), context);
        return data;
      }
    } catch (e) {
      log('Error $e');
    }
  }
}
