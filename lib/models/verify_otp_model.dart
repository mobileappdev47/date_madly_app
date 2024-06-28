// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  String? message;
  User? user;
  String? jwtToken;

  VerifyOtpModel({
    this.message,
    this.user,
    this.jwtToken,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    jwtToken: json["jwtToken"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user?.toJson(),
    "jwtToken": jwtToken,
  };
}

class User {
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

  User({
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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
