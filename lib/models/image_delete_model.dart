// To parse this JSON data, do
//
//     final imageDeleteModel = imageDeleteModelFromJson(jsonString);

import 'dart:convert';

ImageDeleteModel imageDeleteModelFromJson(String str) =>
    ImageDeleteModel.fromJson(json.decode(str));

String imageDeleteModelToJson(ImageDeleteModel data) =>
    json.encode(data.toJson());

class ImageDeleteModel {
  String? message;
  Profile? profile;

  ImageDeleteModel({
    this.message,
    this.profile,
  });

  factory ImageDeleteModel.fromJson(Map<String, dynamic> json) =>
      ImageDeleteModel(
        message: json["message"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "profile": profile?.toJson(),
      };
}

class Profile {
  Loc? loc;
  int? likes;
  String? id;
  String? name;
  String? email;
  String? password;
  List<dynamic>? deviceTokens;
  List<dynamic>? images;
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
  String? about;
  String? college;
  String? company;
  String? gender;
  String? job;
  String? location;

  Profile({
    this.loc,
    this.likes,
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
    this.about,
    this.college,
    this.company,
    this.gender,
    this.job,
    this.location,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        loc: json["loc"] == null ? null : Loc.fromJson(json["loc"]),
        likes: json["likes"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        deviceTokens: json["device_tokens"] == null
            ? []
            : List<dynamic>.from(json["device_tokens"]!.map((x) => x)),
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
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
        about: json["about"],
        college: json["college"],
        company: json["company"],
        gender: json["gender"],
        job: json["job"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "loc": loc?.toJson(),
        "likes": likes,
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
        "about": about,
        "college": college,
        "company": company,
        "gender": gender,
        "job": job,
        "location": location,
      };
}

class Loc {
  String? type;

  Loc({
    this.type,
  });

  factory Loc.fromJson(Map<String, dynamic> json) => Loc(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}
