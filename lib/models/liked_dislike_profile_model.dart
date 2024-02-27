// To parse this JSON data, do
//
//     final likedDislikeProfile = likedDislikeProfileFromJson(jsonString);

import 'dart:convert';

LikedDislikeProfile likedDislikeProfileFromJson(String str) => LikedDislikeProfile.fromJson(json.decode(str));

String likedDislikeProfileToJson(LikedDislikeProfile data) => json.encode(data.toJson());

class LikedDislikeProfile {
  List<LikedDislikeProfileElement>? likedDislikeProfile;

  LikedDislikeProfile({
    this.likedDislikeProfile,
  });

  factory LikedDislikeProfile.fromJson(Map<String, dynamic> json) => LikedDislikeProfile(
    likedDislikeProfile: json["likedDislikeProfile"] == null ? [] : List<LikedDislikeProfileElement>.from(json["likedDislikeProfile"]!.map((x) => LikedDislikeProfileElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "likedDislikeProfile": likedDislikeProfile == null ? [] : List<dynamic>.from(likedDislikeProfile!.map((x) => x.toJson())),
  };
}

class LikedDislikeProfileElement {
  String? id;
  String? userId;
  LikedId? likedId;
  int? status;
  int? v;

  LikedDislikeProfileElement({
    this.id,
    this.userId,
    this.likedId,
    this.status,
    this.v,
  });

  factory LikedDislikeProfileElement.fromJson(Map<String, dynamic> json) => LikedDislikeProfileElement(
    id: json["_id"],
    userId: json["userID"],
    likedId: json["likedID"] == null ? null : LikedId.fromJson(json["likedID"]),
    status: json["status"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userID": userId,
    "likedID": likedId?.toJson(),
    "status": status,
    "__v": v,
  };
}

class LikedId {
  String? id;
  String? name;
  List<dynamic>? images;
  DateTime? dob;

  LikedId({
    this.id,
    this.name,
    this.images,
    this.dob,
  });

  factory LikedId.fromJson(Map<String, dynamic> json) => LikedId(
    id: json["_id"],
    name: json["name"],
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "dob": dob?.toIso8601String(),
  };
}
