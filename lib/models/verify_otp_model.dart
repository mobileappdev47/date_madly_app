

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  String? message;
  User? user;
  String? jwtToken;

  VerifyOtpModel({
    this.message,
    this.user,
    this.jwtToken,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
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
  List<dynamic>? images;
  int? profileScore;
  int? likes;
  List<dynamic>? describe;
  int? visibility;
  int? spark;
  int? isOnline;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.images,
    this.profileScore,
    this.likes,
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
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    profileScore: json["profileScore"],
    likes: json["likes"],
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
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "profileScore": profileScore,
    "likes": likes,
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
