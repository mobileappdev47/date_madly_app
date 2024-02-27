// To parse this JSON data, do
//
//     final additinalDetail = additinalDetailFromJson(jsonString);

import 'dart:convert';

AdditinalDetail additinalDetailFromJson(String str) => AdditinalDetail.fromJson(json.decode(str));

String additinalDetailToJson(AdditinalDetail data) => json.encode(data.toJson());

class AdditinalDetail {
  String? id;
  String? user;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? favPastime;
  String? religion;
  String? sunSign;
  String? cuisine;

  AdditinalDetail({
    this.id,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.favPastime,
    this.religion,
    this.sunSign,
    this.cuisine,
  });

  factory AdditinalDetail.fromJson(Map<String, dynamic> json) => AdditinalDetail(
    id: json["_id"],
    user: json["user"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    favPastime: json["fav_pastime"],
    religion: json["religion"],
    sunSign: json["sun_sign"],
    cuisine: json["cuisine"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "fav_pastime": favPastime,
    "religion": religion,
    "sun_sign": sunSign,
    "cuisine": cuisine,
  };
}
