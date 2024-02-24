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
  String? id;
  String? name;
  List<String>? images;
  int? phoneNo;
  DateTime? dob;
  int? height;
  String? live;
  String? degree;
  String? designation;
  String? company;
  String? income;
  BasicInfo? basicInfo;

  Profile({
    this.id,
    this.name,
    this.images,
    this.phoneNo,
    this.dob,
    this.height,
    this.live,
    this.degree,
    this.designation,
    this.company,
    this.income,
    this.basicInfo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        name: json["name"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        phoneNo: json["phoneNo"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        height: json["height"],
        live: json["live"],
        degree: json["degree"],
        designation: json["designation"],
        company: json["company"],
        income: json["income"],
        basicInfo: json["basic_Info"] == null
            ? null
            : BasicInfo.fromJson(json["basic_Info"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "phoneNo": phoneNo,
        "dob": dob?.toIso8601String(),
        "height": height,
        "live": live,
        "degree": degree,
        "designation": designation,
        "company": company,
        "income": income,
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
