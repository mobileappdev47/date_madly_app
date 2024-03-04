// To parse this JSON data, do
//
//     final getAllUser = getAllUserFromJson(jsonString);

import 'dart:convert';

GetAllUser getAllUserFromJson(String str) =>
    GetAllUser.fromJson(json.decode(str));

String getAllUserToJson(GetAllUser data) => json.encode(data.toJson());

class GetAllUser {
  List<User>? users;

  GetAllUser({
    this.users,
  });

  factory GetAllUser.fromJson(Map<String, dynamic> json) => GetAllUser(
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  Loc? loc;
  String? id;
  String? name;
  String? email;
  String? password;
  List<String>? deviceTokens;
  List<String>? images;
  int? profileScore;
  String? gender;
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
  String? job;
  String? location;
  String? type;
  String? profilePhoto;
  int? boy;

  User({
    this.loc,
    this.id,
    this.name,
    this.email,
    this.password,
    this.deviceTokens,
    this.images,
    this.profileScore,
    this.gender,
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
    this.job,
    this.location,
    this.type,
    this.profilePhoto,
    this.boy,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        loc: json["loc"] == null ? null : Loc.fromJson(json["loc"]),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        deviceTokens: json["device_tokens"] == null
            ? []
            : List<String>.from(json["device_tokens"]!.map((x) => x)),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        profileScore: json["profileScore"],
        gender: json["gender"],
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
        job: json["job"],
        location: json["location"],
        type: json["type"],
        profilePhoto: json["profilePhoto"],
        boy: json["boy"],
      );

  Map<String, dynamic> toJson() => {
        "loc": loc?.toJson(),
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
        "gender": gender,
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
        "job": job,
        "location": location,
        "type": type,
        "profilePhoto": profilePhoto,
        "boy": boy,
      };
}

class Loc {
  String? type;
  List<double>? coordinates;

  Loc({
    this.type,
    this.coordinates,
  });

  factory Loc.fromJson(Map<String, dynamic> json) => Loc(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
