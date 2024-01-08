class GetAllVideoModel {
  String? id;
  String? user;
  String? name;
  String? genre;
  String? artist;
  String? description;
  Image? image;
  Video? video;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetAllVideoModel(
      {this.id,
      this.user,
      this.name,
      this.genre,
      this.artist,
      this.description,
      this.image,
      this.video,
      this.createdAt,
      this.updatedAt,
      this.iV});

  GetAllVideoModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = json['user'];
    name = json['name'];
    genre = json['genre'];
    artist = json['artist'];
    description = json['description'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    video = json['video'] != null ? Video.fromJson(json['video']) : null;
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
    if (video != null) {
      data['video'] = video!.toJson();
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

class Video {
  String? fileName;
  String? filePath;
  String? fileType;
  String? fileSize;

  Video({this.fileName, this.filePath, this.fileType, this.fileSize});

  Video.fromJson(Map<String, dynamic> json) {
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
