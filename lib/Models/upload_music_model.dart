class UploadMusicModel {
  String? user;
  String? name;
  String? genre;
  String? artist;
  String? description;
  Image? image;
  Audio? audio;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UploadMusicModel({
    this.user,
    this.name,
    this.genre,
    this.artist,
    this.description,
    this.image,
    this.audio,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UploadMusicModel.fromJson(Map<String, dynamic> json) =>
      UploadMusicModel(
        user: json["user"],
        name: json["name"],
        genre: json["genre"],
        artist: json["artist"],
        description: json["description"],
        image: Image.fromJson(json["image"]),
        audio: Audio.fromJson(json["audio"]),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class Audio {
  String? fileName;
  String? filePath;
  String? fileType;
  String? fileSize;

  Audio({
    this.fileName,
    this.filePath,
    this.fileType,
    this.fileSize,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        fileName: json["fileName"],
        filePath: json["filePath"],
        fileType: json["fileType"],
        fileSize: json["fileSize"],
      );
}

class Image {
  String? fileName;
  String? filePath;
  String? fileType;
  String? fileSize;

  Image({
    this.fileName,
    this.filePath,
    this.fileType,
    this.fileSize,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        fileName: json["fileName"],
        filePath: json["filePath"],
        fileType: json["fileType"],
        fileSize: json["fileSize"],
      );
}
