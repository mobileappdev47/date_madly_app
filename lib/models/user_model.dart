// To parse this JSON data, do
//
//     final getAllUser = getAllUserFromJson(jsonString);

import 'dart:convert';

GetAllUser getAllUserFromJson(String str) => GetAllUser.fromJson(json.decode(str));

String getAllUserToJson(GetAllUser data) => json.encode(data.toJson());

class GetAllUser {
  List<User>? users;

  GetAllUser({
    this.users,
  });

  factory GetAllUser.fromJson(Map<String, dynamic> json) => GetAllUser(
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  String? id;
  String? name;
  String? email;
  List<String>? images;
  int? profileScore;
  int? likes;
  DateTime? dob;
  int? boy;
  Loc? loc;
  List<dynamic>? describe;
  int? visibility;
  int? spark;
  int? isOnline;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? basicInfo;
  String? about;
  String? college;
  String? company;
  String? gender;
  String? job;
  String? location;
  String? phoneNo;
  String? deviceTokens;
  double? latitude;
  double? longitude;

  User({
    this.id,
    this.name,
    this.email,
    this.images,
    this.profileScore,
    this.likes,
    this.dob,
    this.boy,
    this.loc,
    this.describe,
    this.visibility,
    this.spark,
    this.isOnline,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.basicInfo,
    this.about,
    this.college,
    this.company,
    this.gender,
    this.job,
    this.location,
    this.phoneNo,
    this.deviceTokens,
    this.latitude,
    this.longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    profileScore: json["profileScore"],
    likes: json["likes"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    boy: json["boy"],
    loc: json["loc"] == null ? null : Loc.fromJson(json["loc"]),
    describe: json["describe"] == null ? [] : List<dynamic>.from(json["describe"]!.map((x) => x)),
    visibility: json["visibility"],
    spark: json["spark"],
    isOnline: json["isOnline"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    basicInfo: json["basic_Info"],
    about: json["about"],
    college: json["college"],
    company: json["company"],
    gender: json["gender"],
    job: json["job"],
    location: json["location"],
    phoneNo: json["phoneNo"],
    deviceTokens: json["device_tokens"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "profileScore": profileScore,
    "likes": likes,
    "dob": dob?.toIso8601String(),
    "boy": boy,
    "loc": loc?.toJson(),
    "describe": describe == null ? [] : List<dynamic>.from(describe!.map((x) => x)),
    "visibility": visibility,
    "spark": spark,
    "isOnline": isOnline,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "basic_Info": basicInfo,
    "about": about,
    "college": college,
    "company": company,
    "gender": gender,
    "job": job,
    "location": location,
    "phoneNo": phoneNo,
    "device_tokens": deviceTokens,
    "latitude": latitude,
    "longitude": longitude,
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
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}



/*
import 'dart:convert';

List<GetAllUser> getAllUserFromJson(String str) => List<GetAllUser>.from(json.decode(str).map((x) => GetAllUser.fromJson(x)));

String getAllUserToJson(List<GetAllUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllUser {
  String? id;
  String? name;
  String? email;
  List<String>? images;
  int? profileScore;
  int? likes;
  DateTime? dob;
  int? boy;
  Loc? loc;
  List<dynamic>? describe;
  int? visibility;
  int? spark;
  int? isOnline;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? basicInfo;
  String? about;
  String? college;
  String? company;
  String? gender;
  String? job;
  String? location;
  String? phoneNo;
  String? deviceTokens;
  double? latitude;
  double? longitude;

  GetAllUser({
    this.id,
    this.name,
    this.email,
    this.images,
    this.profileScore,
    this.likes,
    this.dob,
    this.boy,
    this.loc,
    this.describe,
    this.visibility,
    this.spark,
    this.isOnline,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.basicInfo,
    this.about,
    this.college,
    this.company,
    this.gender,
    this.job,
    this.location,
    this.phoneNo,
    this.deviceTokens,
    this.latitude,
    this.longitude,
  });

  factory GetAllUser.fromJson(Map<String, dynamic> json) => GetAllUser(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    profileScore: json["profileScore"],
    likes: json["likes"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    boy: json["boy"],
    loc: json["loc"] == null ? null : Loc.fromJson(json["loc"]),
    describe: json["describe"] == null ? [] : List<dynamic>.from(json["describe"]!.map((x) => x)),
    visibility: json["visibility"],
    spark: json["spark"],
    isOnline: json["isOnline"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    basicInfo: json["basic_Info"],
    about: json["about"],
    college: json["college"],
    company: json["company"],
    gender: json["gender"],
    job: json["job"],
    location: json["location"],
    phoneNo: json["phoneNo"],
    deviceTokens: json["device_tokens"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "profileScore": profileScore,
    "likes": likes,
    "dob": dob?.toIso8601String(),
    "boy": boy,
    "loc": loc?.toJson(),
    "describe": describe == null ? [] : List<dynamic>.from(describe!.map((x) => x)),
    "visibility": visibility,
    "spark": spark,
    "isOnline": isOnline,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "basic_Info": basicInfo,
    "about": about,
    "college": college,
    "company": company,
    "gender": gender,
    "job": job,
    "location": location,
    "phoneNo": phoneNo,
    "device_tokens": deviceTokens,
    "latitude": latitude,
    "longitude": longitude,
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
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
*/
