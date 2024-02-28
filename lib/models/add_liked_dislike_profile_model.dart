// To parse this JSON data, do
//
//     final addLikeDislikeProfile = addLikeDislikeProfileFromJson(jsonString);

import 'dart:convert';

AddLikeDislikeProfile addLikeDislikeProfileFromJson(String str) => AddLikeDislikeProfile.fromJson(json.decode(str));

String addLikeDislikeProfileToJson(AddLikeDislikeProfile data) => json.encode(data.toJson());

class AddLikeDislikeProfile {
  String? userId;
  String? likedId;
  int? status;
  String? id;
  int? v;

  AddLikeDislikeProfile({
    this.userId,
    this.likedId,
    this.status,
    this.id,
    this.v,
  });

  factory AddLikeDislikeProfile.fromJson(Map<String, dynamic> json) => AddLikeDislikeProfile(
    userId: json["userID"],
    likedId: json["likedID"],
    status: json["status"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userId,
    "likedID": likedId,
    "status": status,
    "_id": id,
    "__v": v,
  };
}
