class GetAllFavoriteMusicModel {
  String? id;
  String? name;
  String? artist;
  Audio? audio;
  Image? image;

  GetAllFavoriteMusicModel(
      {this.id, this.name, this.artist, this.audio, this.image});

  GetAllFavoriteMusicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    artist = json['artist'];
    audio = json['audio'] != null ? Audio.fromJson(json['audio']) : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['artist'] = artist;
    if (audio != null) {
      data['audio'] = audio!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
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
