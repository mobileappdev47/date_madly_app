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
//   String? id;
//   String? name;
//   String? email;
//   String? password;
//   List<String>? images;
//   int? profileScore;
//   DateTime? dob;
//   BasicInfo? basicInfo;
//   String? about;
//   String? college;
//   String? company;
//   String? gender;
//   String? job;
//   String? location;
//
//   Profile({
//     this.id,
//     this.name,
//     this.email,
//     this.password,
//     this.images,
//     this.profileScore,
//     this.dob,
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
//         id: json["_id"],
//         name: json["name"],
//         email: json["email"],
//         password: json["password"],
//         images: json["images"] == null
//             ? []
//             : List<String>.from(json["images"]!.map((x) => x)),
//         profileScore: json["profileScore"],
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         basicInfo: json["basic_Info"] == null
//             ? null
//             : BasicInfo.fromJson(json["basic_Info"]),
//         about: json["about"],
//         college: json["college"],
//         company: json["company"],
//         gender: json["gender"],
//         job: json["job"],
//         location: json["location"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "email": email,
//         "password": password,
//         "images":
//             images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//         "profileScore": profileScore,
//         "dob": dob?.toIso8601String(),
//         "basic_Info": basicInfo?.toJson(),
//         "about": about,
//         "college": college,
//         "company": company,
//         "gender": gender,
//         "job": job,
//         "location": location,
//       };
// }
//
// class BasicInfo {
//   String? id;
//
//   BasicInfo({
//     this.id,
//   });
//
//   factory BasicInfo.fromJson(Map<String, dynamic> json) => BasicInfo(
//         id: json["_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//       };
// }
// To parse this JSON data, do
//
//     final getSingleProfileModel = getSingleProfileModelFromJson(jsonString);

import 'dart:convert';

GetSingleProfileModel getSingleProfileModelFromJson(String str) =>
    GetSingleProfileModel.fromJson(json.decode(str));

String getSingleProfileModelToJson(GetSingleProfileModel data) =>
    json.encode(data.toJson());

class GetSingleProfileModel {
  List<Profile>? profile;

  GetSingleProfileModel({
    this.profile,
  });

  factory GetSingleProfileModel.fromJson(Map<String, dynamic> json) =>
      GetSingleProfileModel(
        profile: json["profile"] == null
            ? []
            : List<Profile>.from(
                json["profile"]!.map((x) => Profile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile == null
            ? []
            : List<dynamic>.from(profile!.map((x) => x.toJson())),
      };
}

class Profile {
  Loc? loc;
  String? id;
  String? name;
  String? email;
  String? password;
  List<String>? images;
  int? profileScore;
  DateTime? dob;
  BasicInfo? basicInfo;
  String? about;
  String? college;
  String? company;
  String? gender;
  String? job;
  String? location;

  Profile({
    this.loc,
    this.id,
    this.name,
    this.email,
    this.password,
    this.images,
    this.profileScore,
    this.dob,
    this.basicInfo,
    this.about,
    this.college,
    this.company,
    this.gender,
    this.job,
    this.location,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        loc: json["loc"] == null ? null : Loc.fromJson(json["loc"]),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        profileScore: json["profileScore"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        basicInfo: json["basic_Info"] == null
            ? null
            : BasicInfo.fromJson(json["basic_Info"]),
        about: json["about"],
        college: json["college"],
        company: json["company"],
        gender: json["gender"],
        job: json["job"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "loc": loc?.toJson(),
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "profileScore": profileScore,
        "dob": dob?.toIso8601String(),
        "basic_Info": basicInfo?.toJson(),
        "about": about,
        "college": college,
        "company": company,
        "gender": gender,
        "job": job,
        "location": location,
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

class Loc {
  String? type;
  List<double>? coordinates;

  Loc({
    this.type,
    this.coordinates,
  });

  factory Loc.fromJson(Map<String, dynamic> json) => Loc(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
