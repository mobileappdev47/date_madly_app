// To parse this JSON data, do
//
//     final getLikeDislikeModel = getLikeDislikeModelFromJson(jsonString);

import 'dart:convert';

GetLikeDislikeModel getLikeDislikeModelFromJson(String str) =>
    GetLikeDislikeModel.fromJson(json.decode(str));

String getLikeDislikeModelToJson(GetLikeDislikeModel data) =>
    json.encode(data.toJson());

class GetLikeDislikeModel {
  List<LikedProfile>? likedProfiles;

  GetLikeDislikeModel({
    this.likedProfiles,
  });

  factory GetLikeDislikeModel.fromJson(Map<String, dynamic> json) =>
      GetLikeDislikeModel(
        likedProfiles: json["likedProfiles"] == null
            ? []
            : List<LikedProfile>.from(
                json["likedProfiles"]!.map((x) => LikedProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "likedProfiles": likedProfiles == null
            ? []
            : List<dynamic>.from(likedProfiles!.map((x) => x.toJson())),
      };
}

class LikedProfile {
  String? id;
  UserId? userId;
  String? likedId;
  int? status;
  int? v;

  LikedProfile({
    this.id,
    this.userId,
    this.likedId,
    this.status,
    this.v,
  });

  factory LikedProfile.fromJson(Map<String, dynamic> json) => LikedProfile(
        id: json["_id"],
        userId: json["userID"] == null ? null : UserId.fromJson(json["userID"]),
        likedId: json["likedID"],
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userID": userId?.toJson(),
        "likedID": likedId,
        "status": status,
        "__v": v,
      };
}

class UserId {
  String? id;
  String? name;
  List<dynamic>? deviceTokens;
  List<String>? images;
  DateTime? dob;

  UserId({
    this.id,
    this.name,
    this.deviceTokens,
    this.images,
    this.dob,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
        deviceTokens: json["device_tokens"] == null
            ? []
            : List<dynamic>.from(json["device_tokens"]!.map((x) => x)),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "device_tokens": deviceTokens == null
            ? []
            : List<dynamic>.from(deviceTokens!.map((x) => x)),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "dob": dob?.toIso8601String(),
      };
}
