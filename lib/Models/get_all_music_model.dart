// To parse this JSON data, do
//
//     final getAllMusicModel = getAllMusicModelFromJson(jsonString);

import 'dart:convert';

List<GetAllMusicModel> getAllMusicModelFromJson(String str) => List<GetAllMusicModel>.from(json.decode(str).map((x) => GetAllMusicModel.fromJson(x)));

String getAllMusicModelToJson(List<GetAllMusicModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllMusicModel {
    final String? id;
    final String? user;
    final Name? name;
    final Genre? genre;
    final String? artist;
    final Description? description;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final AudioClass? image;
    final dynamic audio;

    GetAllMusicModel({
        this.id,
        this.user,
        this.name,
        this.genre,
        this.artist,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.image,
        this.audio,
    });

    factory GetAllMusicModel.fromJson(Map<String, dynamic> json) => GetAllMusicModel(
        id: json["_id"],
        user: json["user"],
        name: nameValues.map[json["name"]]!,
        genre: genreValues.map[json["genre"]]!,
        artist: json["artist"],
        description: descriptionValues.map[json["description"]]!,
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        image: json["image"] == null ? null : AudioClass.fromJson(json["image"]),
        audio: json["audio"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "name": nameValues.reverse[name],
        "genre": genreValues.reverse[genre],
        "artist": artist,
        "description": descriptionValues.reverse[description],
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "image": image?.toJson(),
        "audio": audio,
    };
}

class AudioClass {
    final String? fileName;
    final String? filePath;
    final FileType? fileType;
    final String? fileSize;

    AudioClass({
        this.fileName,
        this.filePath,
        this.fileType,
        this.fileSize,
    });

    factory AudioClass.fromJson(Map<String, dynamic> json) => AudioClass(
        fileName: json["fileName"],
        filePath: json["filePath"],
        fileType: fileTypeValues.map[json["fileType"]]!,
        fileSize: json["fileSize"],
    );

    Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "filePath": filePath,
        "fileType": fileTypeValues.reverse[fileType],
        "fileSize": fileSize,
    };
}

enum FileType {
    AUDIO_MPEG,
    IMAGE_JPEG,
    IMAGE_PNG, media
}

final fileTypeValues = EnumValues({
    "audio/mpeg": FileType.AUDIO_MPEG,
    "image/jpeg": FileType.IMAGE_JPEG,
    "image/png": FileType.IMAGE_PNG
});

enum Description {
    SASA,
    XOXO,
    XXX
}

final descriptionValues = EnumValues({
    "sasa": Description.SASA,
    "xoxo": Description.XOXO,
    "xxx": Description.XXX
});

enum Genre {
    HIPHOP,
    XOX,
    XOXO
}

final genreValues = EnumValues({
    "hiphop": Genre.HIPHOP,
    "xox": Genre.XOX,
    "xoxo": Genre.XOXO
});

enum Name {
    BABAARA,
    BABA_ARA,
    XXO
}

final nameValues = EnumValues({
    "babaara": Name.BABAARA,
    "baba ara": Name.BABA_ARA,
    "xxo": Name.XXO
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
