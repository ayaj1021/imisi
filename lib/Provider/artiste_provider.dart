// ignore_for_file: use_build_context_synchronous, use_build_context_synchronously

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imisi/Base/base_page.dart';
import 'package:imisi/Utils/navigator.dart';

import 'package:imisi/Utils/snack_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ArtistProvider with ChangeNotifier {
  String status = "";
  bool isUploading = false;
  File? imageFile;
  bool sendingImageFailed = false;

  Future<File?> getImageGallery(
    BuildContext context,
  ) async {
    try {
      final FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowCompression: true, type: FileType.audio);
      if (result != null) {
        imageFile = File(result.files.first.path!);

        notifyListeners();
      } else {
        status = "Image problem";
        notifyListeners();
        showSnackBar(context: context, message: status);
      }
    } catch (e) {
      isUploading = false;
      notifyListeners();
    }
    return null;
  }

  postFile({
    // required String file,
    BuildContext? context,
    required String name,
    required String genre,
    required String description,
    required File image,
    required File audio,
    required String artist,
  }) async {
    isUploading = true;
    status = "Uploading file";
    notifyListeners();
    String url = "https://imisi-backend-service.onrender.com/api/musics";
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    // Map<String, dynamic> body = {
    //   "name": name,
    //   "genre": genre,
    //   "description": description,
    //   "image": image,
    //   "audio": imageFile.path,
    //   "artist": artist,
    // };

    // final mimeTypeData = lookupMimeType(imageFile!.path);
    var request = http.MultipartRequest("POST", Uri.parse(url))
      ..fields['name'] = name
      ..fields['genre'] = genre
      ..fields['description'] = description
      ..fields['artist'] = artist
      ..files.add(http.MultipartFile(
        'image',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: 'image.jpg',
      ))
      ..files.add(http.MultipartFile(
        'audio',
        audio.readAsBytes().asStream(),
        audio.lengthSync(),
        filename: 'audio.mp3',
      ));

    // var response = await http.post(Uri.parse(url), body: body, headers: {
    //   "Authorization": "Bearer $token",
    // });
    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        isUploading = false;
        status = "Upload Successful";

        showSnackBar(context: context!, message: status, isError: false);
        notifyListeners();
        nextPageAndremoveUntil(const BasePage(), context);
        return response;
      } else {
        isUploading = false;
        status = "Upload Unsuccessful ";
        showSnackBar(context: context!, message: status, isError: true);
        // showSnackBar(context: context, message: data["message"], isError: true);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error uploading files: $e');
    }
  }
}
