import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ArtistProvider with ChangeNotifier{
  bool isUploading = false;
  File? imageFile;
  bool sendingImage = false;
  bool sendingImageFailed = false;

  Future<File?> getImageGallery() async {
    try {
      final FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowCompression: true, type: FileType.audio);
      if (result != null) {

          imageFile = File(result.files.first.path!);
          sendingImage = true;
        notifyListeners();
      }
    } catch (e) {
      sendingImageFailed = true;
    }
    return null;
  }

  postFile({String? file}) async {
    isUploading = true;
    notifyListeners();
    String url = "https://imisi-backend-service.onrender.com/api/musics";
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    var response = await http.post(Uri.parse(url), body: {
      "name": "chima",
      "genre": "xoxo",
      "description": "xoxo",
      "image": "assets/images/ad.png",
      "audio": file,
      "artist": "Chima"
    }, headers: {
      "Authorization": "Bearer $token",
    });
   notifyListeners();

  }
}