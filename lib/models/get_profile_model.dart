// To parse this JSON data, do
//
//     final getProfile = getProfileFromJson(jsonString);

import 'dart:convert';

GetProfile getProfileFromJson(String str) => GetProfile.fromJson(json.decode(str));

String getProfileToJson(GetProfile data) => json.encode(data.toJson());

class GetProfile {
  List<Profile>? profile;

  GetProfile({
    this.profile,
  });

  factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
    profile: json["profile"] == null ? [] : List<Profile>.from(json["profile"]!.map((x) => Profile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile == null ? [] : List<dynamic>.from(profile!.map((x) => x.toJson())),
  };
}

class Profile {
  String? id;
  String? name;
  List<String>? images;
  String? gender;
  DateTime? dob;
  int? height;
  String? live;
  BasicInfo? basicInfo;

  Profile({
    this.id,
    this.name,
    this.images,
    this.gender,
    this.dob,
    this.height,
    this.live,
    this.basicInfo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["_id"],
    name: json["name"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    gender: json["gender"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    height: json["height"],
    live: json["live"],
    basicInfo: json["basic_Info"] == null ? null : BasicInfo.fromJson(json["basic_Info"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "gender": gender,
    "dob": dob?.toIso8601String(),
    "height": height,
    "live": live,
    "basic_Info": basicInfo?.toJson(),
  };
}

class BasicInfo {
  String? id;

  BasicInfo({
    this.id,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> json) => BasicInfo(
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
  };
}
