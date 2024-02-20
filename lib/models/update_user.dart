// To parse this JSON data, do
//
//     final updateUsers = updateUsersFromJson(jsonString);

import 'dart:convert';

UpdateUsers updateUsersFromJson(String str) => UpdateUsers.fromJson(json.decode(str));

String updateUsersToJson(UpdateUsers data) => json.encode(data.toJson());

class UpdateUsers {
  String? id;
  String? name;
  DateTime? dob;
  String? gender;
  String? location;
  String? job;
  String? company;
  String? college;
  String? about;

  UpdateUsers({
    this.id,
    this.name,
    this.dob,
    this.gender,
    this.location,
    this.job,
    this.company,
    this.college,
    this.about,
  });

  factory UpdateUsers.fromJson(Map<String, dynamic> json) => UpdateUsers(
    id: json["_id"],
    name: json["name"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    gender: json["gender"],
    location: json["location"],
    job: json["job"],
    company: json["company"],
    college: json["college"],
    about: json["about"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "location": location,
    "job": job,
    "company": company,
    "college": college,
    "about": about,
  };
}
