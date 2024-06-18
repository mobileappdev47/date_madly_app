//
//
// import 'dart:convert';
//
// GetNotificationModel getNotificationModelFromJson(String str) =>
//     GetNotificationModel.fromJson(json.decode(str));
//
// String getNotificationModelToJson(GetNotificationModel data) =>
//     json.encode(data.toJson());
//
// class GetNotificationModel {
//   List<Notification>? notifications;
//
//   GetNotificationModel({
//     this.notifications,
//   });
//
//   factory GetNotificationModel.fromJson(Map<String, dynamic> json) =>
//       GetNotificationModel(
//         notifications: json["notifications"] == null
//             ? []
//             : List<Notification>.from(
//                 json["notifications"]!.map((x) => Notification.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "notifications": notifications == null
//             ? []
//             : List<dynamic>.from(notifications!.map((x) => x.toJson())),
//       };
// }
//
// class Notification {
//   String? id;
//   String? userId;
//   String? title;
//   String? body;
//   String? imageUrl;
//   String? commenterId;
//   DateTime? createdAt;
//   int? v;
//
//   Notification({
//     this.id,
//     this.userId,
//     this.title,
//     this.body,
//     this.imageUrl,
//     this.commenterId,
//     this.createdAt,
//     this.v,
//   });
//
//   factory Notification.fromJson(Map<String, dynamic> json) => Notification(
//         id: json["_id"],
//         userId: json["userId"],
//         title: json["title"],
//         body: json["body"],
//         imageUrl: json["imageUrl"],
//         commenterId: json["commenterId"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         v: json["__v"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userId": userId,
//         "title": title,
//         "body": body,
//         "imageUrl": imageUrl,
//         "commenterId": commenterId,
//         "createdAt": createdAt?.toIso8601String(),
//         "__v": v,
//       };
// }
// To parse this JSON data, do
//
//     final getNotificationModel = getNotificationModelFromJson(jsonString);

import 'dart:convert';

GetNotificationModel getNotificationModelFromJson(String str) => GetNotificationModel.fromJson(json.decode(str));

String getNotificationModelToJson(GetNotificationModel data) => json.encode(data.toJson());

class GetNotificationModel {
  List<Notification>? notifications;

  GetNotificationModel({
    this.notifications,
  });

  factory GetNotificationModel.fromJson(Map<String, dynamic> json) => GetNotificationModel(
    notifications: json["notifications"] == null ? [] : List<Notification>.from(json["notifications"]!.map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}

class Notification {
  String? id;
  String? userId;
  LikedId? likedId;
  String? title;
  String? body;
  DateTime? createdAt;
  int? v;

  Notification({
    this.id,
    this.userId,
    this.likedId,
    this.title,
    this.body,
    this.createdAt,
    this.v,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["_id"],
    userId: json["userId"],
    likedId: json["likedId"] == null ? null : LikedId.fromJson(json["likedId"]),
    title: json["title"],
    body: json["body"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "likedId": likedId?.toJson(),
    "title": title,
    "body": body,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}

class LikedId {
  String? id;
  String? name;
  String? profilephoto;

  LikedId({
    this.id,
    this.name,
    this.profilephoto,
  });

  factory LikedId.fromJson(Map<String, dynamic> json) => LikedId(
    id: json["_id"],
    name: json["name"],
    profilephoto: json["profilephoto"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "profilephoto": profilephoto,
  };
}
