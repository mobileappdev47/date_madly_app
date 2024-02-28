// To parse this JSON data, do
//
//     final addLikeDislikeModel = addLikeDislikeModelFromJson(jsonString);

import 'dart:convert';

AddLikeDislikeModel addLikeDislikeModelFromJson(String str) =>
    AddLikeDislikeModel.fromJson(json.decode(str));

String addLikeDislikeModelToJson(AddLikeDislikeModel data) =>
    json.encode(data.toJson());

class AddLikeDislikeModel {
  String? id;
  String? userId;
  String? likedId;
  int? status;
  int? v;

  AddLikeDislikeModel({
    this.id,
    this.userId,
    this.likedId,
    this.status,
    this.v,
  });

  factory AddLikeDislikeModel.fromJson(Map<String, dynamic> json) =>
      AddLikeDislikeModel(
        id: json["_id"],
        userId: json["userID"],
        likedId: json["likedID"],
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userID": userId,
        "likedID": likedId,
        "status": status,
        "__v": v,
      };
}
