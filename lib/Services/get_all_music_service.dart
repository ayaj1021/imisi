// import 'dart:convert';

// import 'package:imisi/Models/get_all_music_model.dart';
// import 'package:http/http.dart' as http;

// class GetMusicService {
//   Future<GetAllMusicModel> getAllMusic() async {
//     String url = 'https://imisi-backend-service.onrender.com/api/musics';

//     final List<GetAllMusicModel> allMusic = [];

//     try {
//       var response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
        
//       }
//     } catch (e) {
//       throw Exception('Error $e');
//     }
//   }
// }
