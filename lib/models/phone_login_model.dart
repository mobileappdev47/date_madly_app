
// To parse this JSON data, do
//
//     final phoneLoginModel = phoneLoginModelFromJson(jsonString);

import 'dart:convert';

PhoneLoginModel phoneLoginModelFromJson(String str) => PhoneLoginModel.fromJson(json.decode(str));

String phoneLoginModelToJson(PhoneLoginModel data) => json.encode(data.toJson());

class PhoneLoginModel {
  String? message;
  User? user;
  String? jwtToken;

  PhoneLoginModel({
    this.message,
    this.user,
    this.jwtToken,
  });

  factory PhoneLoginModel.fromJson(Map<String, dynamic> json) => PhoneLoginModel(
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    jwtToken: json["jwtToken"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user?.toJson(),
    "jwtToken": jwtToken,
  };
}

class User {
  String? deviceTokens;
  List<dynamic>? images;
  int? profileScore;
  String? phoneNo;
  int? likes;
  double? latitude;
  double? longitude;
  List<dynamic>? describe;
  int? visibility;
  int? spark;
  int? isOnline;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.deviceTokens,
    this.images,
    this.profileScore,
    this.phoneNo,
    this.likes,
    this.latitude,
    this.longitude,
    this.describe,
    this.visibility,
    this.spark,
    this.isOnline,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    deviceTokens: json["device_tokens"],
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    profileScore: json["profileScore"],
    phoneNo: json["phoneNo"],
    likes: json["likes"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    describe: json["describe"] == null ? [] : List<dynamic>.from(json["describe"]!.map((x) => x)),
    visibility: json["visibility"],
    spark: json["spark"],
    isOnline: json["isOnline"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "device_tokens": deviceTokens,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "profileScore": profileScore,
    "phoneNo": phoneNo,
    "likes": likes,
    "latitude": latitude,
    "longitude": longitude,
    "describe": describe == null ? [] : List<dynamic>.from(describe!.map((x) => x)),
    "visibility": visibility,
    "spark": spark,
    "isOnline": isOnline,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
