// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imisi/Utils/snackBar.dart';
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
        // postFile(
        //   file: imageFile!.path,
        //   context: context,

        // );
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
    String? file,
    BuildContext? context,
    String? name,
    String? genre,
    String? description,
    String? image,
    String? artist,
  }) async {
    isUploading = true;
    status = "Uploading file";
    notifyListeners();
    String url = "https://imisi-backend-service.onrender.com/api/musics";
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    Map<String, dynamic> body = {
      "name": name,
      "genre": genre,
      "description": description,
      "image": image,
      "audio": file,
      "artist": artist,
    };

    var response = await http.post(Uri.parse(url),
        body: body,
        //  {
        //   "name": "chima",
        //   "genre": "xoxo",
        //   "description": "xoxo",
        //   "image": "assets/images/ad.png",
        //   "audio": file,
        //   "artist": "Chima",
        // },
        headers: {
          "Authorization": "Bearer $token",
        });

    if (response.statusCode != 200 || response.statusCode != 201) {
      isUploading = false;
      status = "Upload unsuccessful";
      notifyListeners();
      showSnackBar(context: context!, message: status, isError: true);
    } else {
      isUploading = false;
      status = "Upload Successful";
      showSnackBar(context: context!, message: status);
      notifyListeners();
    }
  }
}
