// To parse this JSON data, do
//
//     final likedDislikeProfiles = likedDislikeProfilesFromJson(jsonString);

import 'dart:convert';

LikedDislikeProfiles likedDislikeProfilesFromJson(String str) => LikedDislikeProfiles.fromJson(json.decode(str));

String likedDislikeProfilesToJson(LikedDislikeProfiles data) => json.encode(data.toJson());

class LikedDislikeProfiles {
  List<LikedDislikeProfile>? likedDislikeProfile;

  LikedDislikeProfiles({
    this.likedDislikeProfile,
  });

  factory LikedDislikeProfiles.fromJson(Map<String, dynamic> json) => LikedDislikeProfiles(
    likedDislikeProfile: json["likedDislikeProfile"] == null ? [] : List<LikedDislikeProfile>.from(json["likedDislikeProfile"]!.map((x) => LikedDislikeProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "likedDislikeProfile": likedDislikeProfile == null ? [] : List<dynamic>.from(likedDislikeProfile!.map((x) => x.toJson())),
  };
}

class LikedDislikeProfile {
  String? id;
  String? userId;
  LikedId? likedId;
  int? status;
  int? v;

  LikedDislikeProfile({
    this.id,
    this.userId,
    this.likedId,
    this.status,
    this.v,
  });

  factory LikedDislikeProfile.fromJson(Map<String, dynamic> json) => LikedDislikeProfile(
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
