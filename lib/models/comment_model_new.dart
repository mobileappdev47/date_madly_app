// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  Comment? comment;

  CommentModel({
    this.comment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        comment:
            json["comment"] == null ? null : Comment.fromJson(json["comment"]),
      );

  Map<String, dynamic> toJson() => {
        "comment": comment?.toJson(),
      };
}

class Comment {
  String? userId;
  String? commenterId;
  String? imageUrl;
  String? text;
  String? id;
  DateTime? createdAt;
  int? v;

  Comment({
    this.userId,
    this.commenterId,
    this.imageUrl,
    this.text,
    this.id,
    this.createdAt,
    this.v,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userId: json["userId"],
        commenterId: json["commenterId"],
        imageUrl: json["imageUrl"],
        text: json["text"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "commenterId": commenterId,
        "imageUrl": imageUrl,
        "text": text,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
