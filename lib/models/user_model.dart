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
  String? password;
  List<String>? deviceTokens;
  List<String>? images;
  int? profileScore;
  int? phoneNo;
  String? gender;
  DateTime? dob;
  int? height;
  String? live;
  String? relationStatus;
  String? degree;
  String? designation;
  String? company;
  String? income;
  List<dynamic>? describe;
  int? visibility;
  int? spark;
  int? isOnline;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? basicInfo;
  String? email;
  String? about;
  String? college;
  String? job;
  String? location;
  String? profilePhoto;

  User({
    this.id,
    this.name,
    this.password,
    this.deviceTokens,
    this.images,
    this.profileScore,
    this.phoneNo,
    this.gender,
    this.dob,
    this.height,
    this.live,
    this.relationStatus,
    this.degree,
    this.designation,
    this.company,
    this.income,
    this.describe,
    this.visibility,
    this.spark,
    this.isOnline,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.basicInfo,
    this.email,
    this.about,
    this.college,
    this.job,
    this.location,
    this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    password: json["password"],
    deviceTokens: json["device_tokens"] == null ? [] : List<String>.from(json["device_tokens"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    profileScore: json["profileScore"],
    phoneNo: json["phoneNo"],
    gender: json["gender"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    height: json["height"],
    live: json["live"],
    relationStatus: json["relationStatus"],
    degree: json["degree"],
    designation: json["designation"],
    company: json["company"],
    income: json["income"],
    describe: json["describe"] == null ? [] : List<dynamic>.from(json["describe"]!.map((x) => x)),
    visibility: json["visibility"],
    spark: json["spark"],
    isOnline: json["isOnline"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    basicInfo: json["basic_Info"],
    email: json["email"],
    about: json["about"],
    college: json["college"],
    job: json["job"],
    location: json["location"],
    profilePhoto: json["profilePhoto"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "password": password,
    "device_tokens": deviceTokens == null ? [] : List<dynamic>.from(deviceTokens!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "profileScore": profileScore,
    "phoneNo": phoneNo,
    "gender": gender,
    "dob": dob?.toIso8601String(),
    "height": height,
    "live": live,
    "relationStatus": relationStatus,
    "degree": degree,
    "designation": designation,
    "company": company,
    "income": income,
    "describe": describe == null ? [] : List<dynamic>.from(describe!.map((x) => x)),
    "visibility": visibility,
    "spark": spark,
    "isOnline": isOnline,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "basic_Info": basicInfo,
    "email": email,
    "about": about,
    "college": college,
    "job": job,
    "location": location,
    "profilePhoto": profilePhoto,
  };
}
