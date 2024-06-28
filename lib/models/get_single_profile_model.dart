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
  SubscriptionDetails? subscriptionDetails;
  String? id;
  bool? isAdmin;
  List<dynamic>? images;
  int? profileScore;
  String? phoneNo;
  int? likes;
  List<String>? friends;
  List<String>? friendRequests;
  bool? isSubscribed;
  bool? isBlocked;
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
  String? email;
  String? gender;
  String? job;
  String? location;
  String? name;

  Profile({
    this.subscriptionDetails,
    this.id,
    this.isAdmin,
    this.images,
    this.profileScore,
    this.phoneNo,
    this.likes,
    this.friends,
    this.friendRequests,
    this.isSubscribed,
    this.isBlocked,
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
    this.email,
    this.gender,
    this.job,
    this.location,
    this.name,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    subscriptionDetails: json["subscriptionDetails"] == null ? null : SubscriptionDetails.fromJson(json["subscriptionDetails"]),
    id: json["_id"],
    isAdmin: json["isAdmin"],
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    profileScore: json["profileScore"],
    phoneNo: json["phoneNo"],
    likes: json["likes"],
    friends: json["friends"] == null ? [] : List<String>.from(json["friends"]!.map((x) => x)),
    friendRequests: json["friendRequests"] == null ? [] : List<String>.from(json["friendRequests"]!.map((x) => x)),
    isSubscribed: json["isSubscribed"],
    isBlocked: json["isBlocked"],
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
    email: json["email"],
    gender: json["gender"],
    job: json["job"],
    location: json["location"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "subscriptionDetails": subscriptionDetails?.toJson(),
    "_id": id,
    "isAdmin": isAdmin,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "profileScore": profileScore,
    "phoneNo": phoneNo,
    "likes": likes,
    "friends": friends == null ? [] : List<dynamic>.from(friends!.map((x) => x)),
    "friendRequests": friendRequests == null ? [] : List<dynamic>.from(friendRequests!.map((x) => x)),
    "isSubscribed": isSubscribed,
    "isBlocked": isBlocked,
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
    "email": email,
    "gender": gender,
    "job": job,
    "location": location,
    "name": name,
  };
}

class SubscriptionDetails {
  String? name;
  int? price;
  int? daysSubscribed;
  DateTime? startDate;
  DateTime? endDate;
  bool? blindDate;

  SubscriptionDetails({
    this.name,
    this.price,
    this.daysSubscribed,
    this.startDate,
    this.endDate,
    this.blindDate,
  });

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) => SubscriptionDetails(
    name: json["name"],
    price: json["price"],
    daysSubscribed: json["daysSubscribed"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    blindDate: json["blindDate"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "daysSubscribed": daysSubscribed,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "blindDate": blindDate,
  };
}
