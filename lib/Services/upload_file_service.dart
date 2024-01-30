// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Utils/navigator.dart';
import 'package:imisi/Utils/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadFileService with ChangeNotifier {
  Dio dio = Dio();
  String status = "";
  int? selectedFile;
  bool isUploading = false;
  double _uploadSent = 0;
  double _uploadTotal = 0;

  double get uploadSent => _uploadSent;
  double get uploadTotal => _uploadTotal;

  // print('$sent, $total');

  Future sendSong(
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
    String url = 'https://imisi-backend-service.onrender.com/api/musics/';
    try {
      var headers = {
        'Authorization': "Bearer $token",
        'cookie': token,
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
            filename: name,
            contentType: MediaType("image", "jpeg"),
          ),
          'audio': await MultipartFile.fromFile(
            audioPath,
            filename: name,
            contentType: MediaType("audio", "mp3"),
          ),
          'artist': artist,
        }),
        onSendProgress: (int sent, int total) {
          _uploadSent = ((sent / total) * 100);
          print(((sent / total) * 100));
          // _uploadSent = sent;
          _uploadTotal = ((total / total) * 100);
          ;
          notifyListeners();
          print('$sent, $total');
        },
      );

      final body = response.data;

      if (response.statusCode == 201) {
        isUploading = false;
        showSnackBar(
            context: context, message: body["message"], isError: false);

        nextPageAndremoveUntil(const BasePage(), context);

        notifyListeners();
        return body;
      } else {
        isUploading = false;
        showSnackBar(context: context, message: body["message"], isError: true);
        notifyListeners();
      }
    } catch (e) {
      isUploading = false;

      throw '$e';
    }
  }

  Future sendVideo(
    BuildContext context, {
    required String name,
    required String genre,
    required String description,
    required String imagePath,
    required String videoPath,
    required String artist,
  }) async {
    isUploading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String url = 'https://imisi-backend-service.onrender.com/api/videos/';
    try {
      var headers = {
        'Authorization': "Bearer $token",
        'cookie': token,
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
            filename: name,
            contentType: MediaType("image", "jpeg"),
          ),
          'video': await MultipartFile.fromFile(
            videoPath,
            filename: name,
            contentType: MediaType("audio", "mp3"),
          ),
          'artist': artist,
        }),
        onSendProgress: (int sent, int total) {
          _uploadSent = ((sent / total) * 100);
          print(((sent / total) * 100));
          // _uploadSent = sent;
          _uploadTotal = ((total / total) * 100);
          notifyListeners();
        
          // _uploadSent = ((sent / total) * 100);

          // _uploadTotal = total;
          // notifyListeners();
          // print('$sent, $total');
        },
      );

      final body = response.data;

      if (response.statusCode == 201) {
        isUploading = false;
        showSnackBar(
            context: context, message: body["message"], isError: false);

        nextPageAndremoveUntil(const BasePage(), context);

        notifyListeners();
        return body;
      } else {
        isUploading = false;
        showSnackBar(context: context, message: body["message"], isError: true);
        notifyListeners();
      }
    } catch (e) {
      isUploading = false;

      throw '$e';
    }
  }
}
