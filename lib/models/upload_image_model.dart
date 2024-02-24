// To parse this JSON data, do
//
//     final uploadImageModel = uploadImageModelFromJson(jsonString);

import 'dart:convert';

UploadImageModel uploadImageModelFromJson(String str) =>
    UploadImageModel.fromJson(json.decode(str));

String uploadImageModelToJson(UploadImageModel data) =>
    json.encode(data.toJson());

class UploadImageModel {
  String? message;
  String? imageUrl;
  Profile? profile;

  UploadImageModel({
    this.message,
    this.imageUrl,
    this.profile,
  });

  factory UploadImageModel.fromJson(Map<String, dynamic> json) =>
      UploadImageModel(
        message: json["message"],
        imageUrl: json["imageUrl"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "imageUrl": imageUrl,
        "profile": profile?.toJson(),
      };
}

class Profile {
  String? id;
  String? name;
  String? email;
  String? password;
  List<dynamic>? deviceTokens;
  List<String>? images;
  int? profileScore;
  DateTime? dob;
  List<dynamic>? describe;
  int? visibility;
  int? spark;
  int? isOnline;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? basicInfo;

  Profile({
    this.id,
    this.name,
    this.email,
    this.password,
    this.deviceTokens,
    this.images,
    this.profileScore,
    this.dob,
    this.describe,
    this.visibility,
    this.spark,
    this.isOnline,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.basicInfo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        deviceTokens: json["device_tokens"] == null
            ? []
            : List<dynamic>.from(json["device_tokens"]!.map((x) => x)),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        profileScore: json["profileScore"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        describe: json["describe"] == null
            ? []
            : List<dynamic>.from(json["describe"]!.map((x) => x)),
        visibility: json["visibility"],
        spark: json["spark"],
        isOnline: json["isOnline"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        basicInfo: json["basic_Info"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "device_tokens": deviceTokens == null
            ? []
            : List<dynamic>.from(deviceTokens!.map((x) => x)),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "profileScore": profileScore,
        "dob": dob?.toIso8601String(),
        "describe":
            describe == null ? [] : List<dynamic>.from(describe!.map((x) => x)),
        "visibility": visibility,
        "spark": spark,
        "isOnline": isOnline,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "basic_Info": basicInfo,
      };
}
