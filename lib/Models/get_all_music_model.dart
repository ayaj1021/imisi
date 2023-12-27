class GetAllMusicModel {
  String? id;
  String? user;
  String? name;
  String? genre;
  String? artist;
  String? description;
  Image? image;
  Audio? audio;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetAllMusicModel(
      {this.id,
      this.user,
      this.name,
      this.genre,
      this.artist,
      this.description,
      this.image,
      this.audio,
      this.createdAt,
      this.updatedAt,
      this.iV});

   GetAllMusicModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = json['user'];
    name = json['name'];
    genre = json['genre'];
    artist = json['artist'];
    description = json['description'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    audio = json['audio'] != null ? Audio.fromJson(json['audio']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['user'] = user;
    data['name'] = name;
    data['genre'] = genre;
    data['artist'] = artist;
    data['description'] = description;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (audio != null) {
      data['audio'] = audio!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Image {
  String? fileName;
  String? filePath;
  String? fileType;
  String? fileSize;

  Image({this.fileName, this.filePath, this.fileType, this.fileSize});

  Image.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    filePath = json['filePath'];
    fileType = json['fileType'];
    fileSize = json['fileSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileName'] = fileName;
    data['filePath'] = filePath;
    data['fileType'] = fileType;
    data['fileSize'] = fileSize;
    return data;
  }
}

class Audio {
  String? fileName;
  String? filePath;
  String? fileType;
  String? fileSize;

  Audio({this.fileName, this.filePath, this.fileType, this.fileSize});

  Audio.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    filePath = json['filePath'];
    fileType = json['fileType'];
    fileSize = json['fileSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileName'] = fileName;
    data['filePath'] = filePath;
    data['fileType'] = fileType;
    data['fileSize'] = fileSize;
    return data;
  }
}

