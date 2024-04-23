//
//
// import 'dart:convert';
//
// GetSingleProfileModel getSingleProfileModelFromJson(String str) =>
//     GetSingleProfileModel.fromJson(json.decode(str));
//
// String getSingleProfileModelToJson(GetSingleProfileModel data) =>
//     json.encode(data.toJson());
//
// class GetSingleProfileModel {
//   List<Profile>? profile;
//
//   GetSingleProfileModel({
//     this.profile,
//   });
//
//   factory GetSingleProfileModel.fromJson(Map<String, dynamic> json) =>
//       GetSingleProfileModel(
//         profile: json["profile"] == null
//             ? []
//             : List<Profile>.from(
//                 json["profile"]!.map((x) => Profile.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "profile": profile == null
//             ? []
//             : List<dynamic>.from(profile!.map((x) => x.toJson())),
//       };
// }
//
// class Profile {
//   Loc? loc;
//   int? likes;
//   String? id;
//   String? name;
//   String? email;
//   String? password;
//   List<dynamic>? deviceTokens;
//   List<String>? images;
//   int? profileScore;
//   DateTime? dob;
//   List<dynamic>? describe;
//   int? visibility;
//   int? spark;
//   int? isOnline;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//   String? basicInfo;
//   String? about;
//   String? college;
//   String? company;
//   String? gender;
//   String? job;
//   String? location;
//
//   Profile({
//     this.loc,
//     this.likes,
//     this.id,
//     this.name,
//     this.email,
//     this.password,
//     this.deviceTokens,
//     this.images,
//     this.profileScore,
//     this.dob,
//     this.describe,
//     this.visibility,
//     this.spark,
//     this.isOnline,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.basicInfo,
//     this.about,
//     this.college,
//     this.company,
//     this.gender,
//     this.job,
//     this.location,
//   });
//
//   factory Profile.fromJson(Map<String, dynamic> json) => Profile(
//         loc: json["loc"] == null ? null : Loc.fromJson(json["loc"]),
//         likes: json["likes"],
//         id: json["_id"],
//         name: json["name"],
//         email: json["email"],
//         password: json["password"],
//         deviceTokens: json["device_tokens"] == null
//             ? []
//             : List<dynamic>.from(json["device_tokens"]!.map((x) => x)),
//         images: json["images"] == null
//             ? []
//             : List<String>.from(json["images"]!.map((x) => x)),
//         profileScore: json["profileScore"],
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         describe: json["describe"] == null
//             ? []
//             : List<dynamic>.from(json["describe"]!.map((x) => x)),
//         visibility: json["visibility"],
//         spark: json["spark"],
//         isOnline: json["isOnline"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         basicInfo: json["basic_Info"],
//         about: json["about"],
//         college: json["college"],
//         company: json["company"],
//         gender: json["gender"],
//         job: json["job"],
//         location: json["location"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "loc": loc?.toJson(),
//         "likes": likes,
//         "_id": id,
//         "name": name,
//         "email": email,
//         "password": password,
//         "device_tokens": deviceTokens == null
//             ? []
//             : List<dynamic>.from(deviceTokens!.map((x) => x)),
//         "images":
//             images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//         "profileScore": profileScore,
//         "dob": dob?.toIso8601String(),
//         "describe":
//             describe == null ? [] : List<dynamic>.from(describe!.map((x) => x)),
//         "visibility": visibility,
//         "spark": spark,
//         "isOnline": isOnline,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//         "basic_Info": basicInfo,
//         "about": about,
//         "college": college,
//         "company": company,
//         "gender": gender,
//         "job": job,
//         "location": location,
//       };
// }
//
// class Loc {
//   String? type;
//
//   Loc({
//     this.type,
//   });
//
//   factory Loc.fromJson(Map<String, dynamic> json) => Loc(
//         type: json["type"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "type": type,
//       };
// }
// To parse this JSON data, do
//
//     final getSingleProfileModel = getSingleProfileModelFromJson(jsonString);

import 'dart:convert';

GetSingleProfileModel getSingleProfileModelFromJson(String str) => GetSingleProfileModel.fromJson(json.decode(str));

String getSingleProfileModelToJson(GetSingleProfileModel data) => json.encode(data.toJson());

class GetSingleProfileModel {
  List<Profile>? profile;

  GetSingleProfileModel({
    this.profile,
  });

  factory GetSingleProfileModel.fromJson(Map<String, dynamic> json) => GetSingleProfileModel(
    profile: json["profile"] == null ? [] : List<Profile>.from(json["profile"]!.map((x) => Profile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile == null ? [] : List<dynamic>.from(profile!.map((x) => x.toJson())),
  };
}

class Profile {
  String? id;
  String? deviceTokens;
  List<String>? images;
  int? profileScore;
  String? phoneNo;
  String? name;
  int? likes;
  double? latitude;
  double? longitude;
  List<dynamic>? describe;
  int? visibility;
  int? spark;
  int? isOnline;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? about;
  String? college;
  String? company;
  DateTime? dob;
  String? gender;
  String? job;
  String? location;

  Profile({
    this.id,
    this.deviceTokens,
    this.images,
    this.profileScore,
    this.phoneNo,
    this.name,
    this.likes,
    this.latitude,
    this.longitude,
    this.describe,
    this.visibility,
    this.spark,
    this.isOnline,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.about,
    this.college,
    this.company,
    this.dob,
    this.gender,
    this.job,
    this.location,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["_id"],
    deviceTokens: json["device_tokens"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    profileScore: json["profileScore"],
    phoneNo: json["phoneNo"],
    name: json["name"],
    likes: json["likes"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    describe: json["describe"] == null ? [] : List<dynamic>.from(json["describe"]!.map((x) => x)),
    visibility: json["visibility"],
    spark: json["spark"],
    isOnline: json["isOnline"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    about: json["about"],
    college: json["college"],
    company: json["company"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    gender: json["gender"],
    job: json["job"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "device_tokens": deviceTokens,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "profileScore": profileScore,
    "phoneNo": phoneNo,
    "name": name,
    "likes": likes,
    "latitude": latitude,
    "longitude": longitude,
    "describe": describe == null ? [] : List<dynamic>.from(describe!.map((x) => x)),
    "visibility": visibility,
    "spark": spark,
    "isOnline": isOnline,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "about": about,
    "college": college,
    "company": company,
    "dob": dob?.toIso8601String(),
    "gender": gender,
    "job": job,
    "location": location,
  };
}
