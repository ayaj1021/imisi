// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/snack_bar.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadFileService with ChangeNotifier {
  Dio dio = Dio();
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
    isUploading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String url = 'https://imisi-backend-service.onrender.com/api/musics';
    var headers = {
      'Authorization': "Bearer $token",
      // 'cookie':
      //     'token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1N2IxOTU2MDI3NDY2MDk0M2MwZDAxOCIsImlhdCI6MTcwMjU2NjIzMSwiZXhwIjoxNzAyNjUyNjMxfQ.UW7VU6fyU5decUFIaJTR07mfu-mdbmbFLIbT66nDVZ4'
    };
    notifyListeners();
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      final imageStream = http.ByteStream(image.openRead());
      final imageLength = await image.length();
      Uint8List bytes = await image.readAsBytes();
      String encodedByte = base64Encode(bytes);

      request.files.add(
        http.MultipartFile(
          'image',
          imageStream,
          imageLength,
          filename: image.path,
        ),
      );
      print('request image $image');
      print('request $request');
      final audioStream = http.ByteStream(audio.openRead());
      final audioLength = await audio.length();
      Uint8List dytes = await audio.readAsBytes();
      String encodedDyte = base64Encode(dytes);
      request.files.add(
        http.MultipartFile(
          'audio',
          audioStream,
          audioLength,
          filename: audio.path,
        ),
      );
      print('request audio $audio');
      print('request $request');

      request.fields.addAll({
        'name': name,
        'genre': genre,
        'description': description,
        'image': encodedByte,
        // const Base64Encoder()
        //     .convert(File(image.path.split('/').last).readAsBytesSync()),

        'audio': encodedDyte,
        // const Base64Encoder()
        //     .convert(File(audio.path.split('/').last).readAsBytesSync()),

        'artist': artist,
      });
      // for (final key in fields.entries) {
      //   request.fields[key.key] = key.value.toString();
      // }
      print('request fields:  $request ');

      //  http.StreamedResponse response = await request.send();
      var streamedResponse = await request.send();
      request.headers.addAll(headers);

      final response = await http.Response.fromStream(streamedResponse);
      print('response ${response.body}');
      print('response result $response');

      if (response.statusCode == 201) {
        isUploading = false;
        status = "Upload Successful";

        showSnackBar(context: context, message: status, isError: false);

        nextPageAndremoveUntil(const BasePage(), context);

        notifyListeners();
        return response.body;
      } else {
        isUploading = false;

        status = "Upload Unsuccessful ";

        showSnackBar(context: context, message: response.body, isError: true);
        notifyListeners();
      }
    } catch (e) {
      isUploading = false;
      notifyListeners();
      Logger().e('Error while send $e');
    }
  }

  Future sendFiles(
    BuildContext context, {
    required String name,
    required String genre,
    required String description,
    required String imagePath,
    required String audioPath,
    required String artist,
  }) async {
    isUploading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String url = 'https://imisi-backend-service.onrender.com/api/musics';
    try {
      var headers = {
        'Authorization': "Bearer $token",
        // 'cookie':
        //     'token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1N2IxOTU2MDI3NDY2MDk0M2MwZDAxOCIsImlhdCI6MTcwMjU2NjIzMSwiZXhwIjoxNzAyNjUyNjMxfQ.UW7VU6fyU5decUFIaJTR07mfu-mdbmbFLIbT66nDVZ4'
      };
      notifyListeners();
      var response = await dio.post(
        options: Options(
          headers: headers,
          contentType: Headers.jsonContentType,
        ),
        url,
        data: FormData.fromMap({
          'name': name,
          'genre': genre,
          'description': description,
          'image': await MultipartFile.fromFile(
            imagePath,
            filename: '',
            contentType: MediaType("image", "jpeg"),
          ),
          'audio': await MultipartFile.fromFile(
            audioPath,
            filename: '',
            contentType: MediaType("audio", "mp3"),
          ),
          'artist': artist,
        }),
      );
      print(response.data);
      print(response.statusCode);
    } catch (e) {
      isUploading = false;
      print(e);
      throw '$e';
    }
  }
}
