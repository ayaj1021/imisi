// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Base/base_page.dart';
import '../Utils/navigator.dart';
import '../Utils/snack_bar.dart';

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

    try {
      /* var headers = {'Authorization': 'Bearer $token'};
      var data = FormData.fromMap({
        'files': [
          await MultipartFile.fromFile(image.path,
              filename: image.path.split("/").last),
          await MultipartFile.fromFile(audio.path,
              filename: audio.path.split("/").last)
        ],
        'name': name,
        'genre': genre,
        'description': description,
        'artist': artist
      });

      var dio = Dio();
      var response = await dio.post(
        url,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Logger().i(json.encode(response.data));
      } else {
        Logger().e(response.statusCode);
        Logger().e(response.statusMessage);
      }
      */
      var request = http.MultipartRequest('POST',
          Uri.parse(url));

      /*Logger().i(token);
      Logger().i(name);
      Logger().i(genre);
      Logger().i(description);
      Logger().i(artist);
      Logger().i(image.path.split("/").last);
      Logger().i(audio.path.split("/").last);*/

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/x-www-form-urlencoded';

      request.fields['name'] = name;
      request.fields['genre'] = genre;
      request.fields['description'] = description;
      request.fields['customer'] = artist;

      request.files.add(await http.MultipartFile.fromPath("image", image.path));
      request.files.add(await http.MultipartFile.fromPath("audio", audio.path));

     // Logger().w(request.files.map((e) => e.filename));
      //Logger().w(request.toString());*/

      http.StreamedResponse response = await request.send();
      final dataRetrieved = await http.Response.fromStream(response);

      if (dataRetrieved.statusCode >= 200 && dataRetrieved.statusCode < 300) {
        Logger().i(json.decode(dataRetrieved.body));

        isUploading = true;
        status = "Upload Successful";

        showSnackBar(context: context, message: status, isError: false);

        nextPageAndremoveUntil(const BasePage(), context);
        isUploading = false;
        notifyListeners();
        return response;
      } else {
        isUploading = false;
        Logger().e(dataRetrieved.statusCode);
        Logger().e(dataRetrieved.reasonPhrase);
        final responseJson = jsonDecode(dataRetrieved.body);
        Logger().w(responseJson);
        status = "Upload Unsuccessful ";
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
