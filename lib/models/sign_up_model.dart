// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

// SignUpModel signUpModelFromJson(String str) =>
//     SignUpModel.fromJson(json.decode(str));
//
// String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());
//
// class SignUpModel {
//   User? user;
//   BasicInfo? basicInfo;
//   String? jwtToken;
//
//   SignUpModel({
//     this.user,
//     this.basicInfo,
//     this.jwtToken,
//   });
//
//   factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//         basicInfo: json["basicInfo"] == null
//             ? null
//             : BasicInfo.fromJson(json["basicInfo"]),
//         jwtToken: json["jwtToken"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "user": user?.toJson(),
//         "basicInfo": basicInfo?.toJson(),
//         "jwtToken": jwtToken,
//       };
// }
//
// class BasicInfo {
//   String? user;
//   String? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   BasicInfo({
//     this.user,
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory BasicInfo.fromJson(Map<String, dynamic> json) => BasicInfo(
//         user: json["user"],
//         id: json["_id"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "user": user,
//         "_id": id,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }
//
// class User {
//   String? name;
//   String? email;
//   String? password;
//   List<String>? deviceTokens;
//   List<dynamic>? images;
//   int? profileScore;
//   String? gender;
//   DateTime? dob;
//   int? height;
//   String? live;
//   String? relationStatus;
//   String? degree;
//   String? designation;
//   String? company;
//   String? income;
//   List<dynamic>? describe;
//   int? visibility;
//   int? spark;
//   int? isOnline;
//   String? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   User({
//     this.name,
//     this.email,
//     this.password,
//     this.deviceTokens,
//     this.images,
//     this.profileScore,
//     this.gender,
//     this.dob,
//     this.height,
//     this.live,
//     this.relationStatus,
//     this.degree,
//     this.designation,
//     this.company,
//     this.income,
//     this.describe,
//     this.visibility,
//     this.spark,
//     this.isOnline,
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//         name: json["name"],
//         email: json["email"],
//         password: json["password"],
//         deviceTokens: json["device_tokens"] == null
//             ? []
//             : List<String>.from(json["device_tokens"]!.map((x) => x)),
//         images: json["images"] == null
//             ? []
//             : List<dynamic>.from(json["images"]!.map((x) => x)),
//         profileScore: json["profileScore"],
//         gender: json["gender"],
//         dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//         height: json["height"],
//         live: json["live"],
//         relationStatus: json["relationStatus"],
//         degree: json["degree"],
//         designation: json["designation"],
//         company: json["company"],
//         income: json["income"],
//         describe: json["describe"] == null
//             ? []
//             : List<dynamic>.from(json["describe"]!.map((x) => x)),
//         visibility: json["visibility"],
//         spark: json["spark"],
//         isOnline: json["isOnline"],
//         id: json["_id"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "email": email,
//         "password": password,
//         "device_tokens": deviceTokens == null
//             ? []
//             : List<dynamic>.from(deviceTokens!.map((x) => x)),
//         "images":
//             images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//         "profileScore": profileScore,
//         "gender": gender,
//         "dob": dob?.toIso8601String(),
//         "height": height,
//         "live": live,
//         "relationStatus": relationStatus,
//         "degree": degree,
//         "designation": designation,
//         "company": company,
//         "income": income,
//         "describe":
//             describe == null ? [] : List<dynamic>.from(describe!.map((x) => x)),
//         "visibility": visibility,
//         "spark": spark,
//         "isOnline": isOnline,
//         "_id": id,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

//---------------------New sign up modek json5 postmane based-------------------------//
// To parse this JSON data, do
//
//     final signup = signupFromJson(jsonString);

Signup signupFromJson(String str) => Signup.fromJson(json.decode(str));

String signupToJson(Signup data) => json.encode(data.toJson());

class Signup {
  String? name;
  String? email;
  String? password;
  DateTime? dob;
  String? type;

  Signup({
    this.name,
    this.email,
    this.password,
    this.dob,
    this.type,
  });

  factory Signup.fromJson(Map<String, dynamic> json) => Signup(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    dob: DateTime.parse(json["dob"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "dob": "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
    "type": type,
  };
}
