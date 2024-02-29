// To parse this JSON data, do
//
//     final updateRequestModel = updateRequestModelFromJson(jsonString);

import 'dart:convert';

UpdateRequestModel updateRequestModelFromJson(String str) =>
    UpdateRequestModel.fromJson(json.decode(str));

String updateRequestModelToJson(UpdateRequestModel data) =>
    json.encode(data.toJson());

class UpdateRequestModel {
  String? userId;
  String? likedId;
  int? status;
  String? id;
  int? v;

  UpdateRequestModel({
    this.userId,
    this.likedId,
    this.status,
    this.id,
    this.v,
  });

  factory UpdateRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateRequestModel(
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
