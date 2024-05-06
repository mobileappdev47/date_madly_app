// To parse this JSON data, do
//
//     final socialLoginModel = socialLoginModelFromJson(jsonString);

import 'dart:convert';

SocialLoginModel socialLoginModelFromJson(String str) => SocialLoginModel.fromJson(json.decode(str));

String socialLoginModelToJson(SocialLoginModel data) => json.encode(data.toJson());

class SocialLoginModel {
  String? message;
  User? user;
  String? jwtToken;

  SocialLoginModel({
    this.message,
    this.user,
    this.jwtToken,
  });

  factory SocialLoginModel.fromJson(Map<String, dynamic> json) => SocialLoginModel(
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
  String? id;
  String? email;
  String? deviceTokens;
  List<dynamic>? images;
  int? profileScore;
  int? likes;
  double? latitude;
  double? longitude;
  List<dynamic>? describe;
  int? visibility;
  int? spark;
  int? isOnline;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.id,
    this.email,
    this.deviceTokens,
    this.images,
    this.profileScore,
    this.likes,
    this.latitude,
    this.longitude,
    this.describe,
    this.visibility,
    this.spark,
    this.isOnline,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    email: json["email"],
    deviceTokens: json["device_tokens"],
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    profileScore: json["profileScore"],
    likes: json["likes"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    describe: json["describe"] == null ? [] : List<dynamic>.from(json["describe"]!.map((x) => x)),
    visibility: json["visibility"],
    spark: json["spark"],
    isOnline: json["isOnline"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "device_tokens": deviceTokens,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "profileScore": profileScore,
    "likes": likes,
    "latitude": latitude,
    "longitude": longitude,
    "describe": describe == null ? [] : List<dynamic>.from(describe!.map((x) => x)),
    "visibility": visibility,
    "spark": spark,
    "isOnline": isOnline,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
