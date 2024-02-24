// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  User? user;
  String? jwtToken;

  SignUpModel({
    this.user,
    this.jwtToken,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        jwtToken: json["jwtToken"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "jwtToken": jwtToken,
      };
}

class User {
  String? name;
  List<dynamic>? deviceTokens;
  List<dynamic>? images;
  List<dynamic>? describe;
  String? id;

  User({
    this.name,
    this.deviceTokens,
    this.images,
    this.describe,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        deviceTokens: json["device_tokens"] == null
            ? []
            : List<dynamic>.from(json["device_tokens"]!.map((x) => x)),
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        describe: json["describe"] == null
            ? []
            : List<dynamic>.from(json["describe"]!.map((x) => x)),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "device_tokens": deviceTokens == null
            ? []
            : List<dynamic>.from(deviceTokens!.map((x) => x)),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "describe":
            describe == null ? [] : List<dynamic>.from(describe!.map((x) => x)),
        "_id": id,
      };
}
