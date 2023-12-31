
class ListenToSongToEarnPointsModel {
  String? message;
  bool? playAdvertisement;
  User? user;

  ListenToSongToEarnPointsModel({
    required this.message,
    required this.playAdvertisement,
     this.user,
  });

  factory ListenToSongToEarnPointsModel.fromJson(Map<String, dynamic> json) {
    return ListenToSongToEarnPointsModel(
      message: json['message'],
      playAdvertisement: json['playAdvertisement'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  String id;
  String name;
  String role;
  String email;
  String password;
  String photo;
  String bio;
  String phone;
  String createdAt;
  String updatedAt;
  int v;
  List<String> favorites;
  List<String> listenedSongs;
  int points;

  User({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.password,
    required this.photo,
    required this.bio,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.favorites,
    required this.listenedSongs,
    required this.points,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      role: json['role'],
      email: json['email'],
      password: json['password'],
      photo: json['photo'],
      bio: json['bio'],
      phone: json['phone'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      favorites: List<String>.from(json['favorites']),
      listenedSongs: List<String>.from(json['listenedSongs']),
      points: json['points'],
    );
  }
}
