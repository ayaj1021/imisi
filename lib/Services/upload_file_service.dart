// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/snack_bar.dart';
import 'package:logger/logger.dart';
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
    //isUploading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String url = 'https://imisi-backend-service.onrender.com/api/musics';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    };
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      final imageStream = http.ByteStream(image.openRead());
      final imageLength = await image.length();
      Uint8List bytes = await image.readAsBytes();
      String encodedByte = base64Encode(bytes);
      Uint8List dytes = await audio.readAsBytes();
      String encodedDyte = base64Encode(dytes);
      request.files.add(
        http.MultipartFile(
          'image',
          imageStream,
          imageLength,
          filename: image.path,
        ),
      );
      print('request image ${image}');
      print('request ${request}');
      final audioStream = http.ByteStream(audio.openRead());
      final audioLength = await audio.length();
      request.files.add(
        http.MultipartFile(
          'audio',
          audioStream,
          audioLength,
          filename: audio.path,
        ),
      );
      print('request audio ${audio}');
      print('request ${request}');

      request.headers.addAll(headers);
      final fields = {
        'name': name,
        'genre': genre,
        'description': description,
        'artist': artist,
        'image': encodedByte,
        // const Base64Encoder().convert(File(image.path).readAsBytesSync()),
        'audio': encodedDyte,
        //  const Base64Encoder().convert(File(audio.path).readAsBytesSync()),
      };
      for (final key in fields.entries) {
        request.fields[key.key] = key.value;
      }
      print('request fields:  ${request.fields} ');

      http.StreamedResponse response = await request.send();
      final dataRetrieved = await http.Response.fromStream(response);
      print('response ${dataRetrieved.body}');

      if (response.statusCode == 201) {
        isUploading = true;
        status = "Upload Successful";

        showSnackBar(context: context, message: status, isError: false);

        nextPageAndremoveUntil(const BasePage(), context);
        isUploading = false;
        notifyListeners();
        return response;
      } else {
        isUploading = false;
        print(response.statusCode);
        print(response.reasonPhrase);
        status = "Upload Unsuccessful ";
        //showSnackBar(context: context, message: status, isError: true);
        showSnackBar(context: context, message: status, isError: true);
        notifyListeners();
      }
    } catch (e) {
      Logger().e('Error while send $e');
      //throw Exception('Error $e');
    }
  }
}
 // body: body,
        // headers: {
        //   // 'Content-Type': 'application/json',
        //   'Authorization': "Bearer $token",
        // },