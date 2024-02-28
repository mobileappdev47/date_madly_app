// To parse this JSON data, do
//
//     final changePasswordModel = changePasswordModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) => ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel data) => json.encode(data.toJson());

class ChangePasswordModel {
  String? message;
  String? jwtToken;

  ChangePasswordModel({
    this.message,
    this.jwtToken,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
    message: json["message"],
    jwtToken: json["jwtToken"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "jwtToken": jwtToken,
  };
}
