// To parse this JSON data, do
//
//     final getAllChatRoom = getAllChatRoomFromJson(jsonString);

import 'dart:convert';

GetAllChatRoom getAllChatRoomFromJson(String str) => GetAllChatRoom.fromJson(json.decode(str));

String getAllChatRoomToJson(GetAllChatRoom data) => json.encode(data.toJson());

class GetAllChatRoom {
  List<ChatRoom>? chatRoom;

  GetAllChatRoom({
    this.chatRoom,
  });

  factory GetAllChatRoom.fromJson(Map<String, dynamic> json) => GetAllChatRoom(
    chatRoom: json["chatRoom"] == null ? [] : List<ChatRoom>.from(json["chatRoom"]!.map((x) => ChatRoom.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chatRoom": chatRoom == null ? [] : List<dynamic>.from(chatRoom!.map((x) => x.toJson())),
  };
}

class ChatRoom {
  String? id;
  String? chatroomId;
  List<Participant>? participants;
  String? lastMessage;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ChatRoom({
    this.id,
    this.chatroomId,
    this.participants,
    this.lastMessage,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
    id: json["_id"],
    chatroomId: json["chatroomID"],
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    lastMessage: json["lastMessage"],
    active: json["active"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chatroomID": chatroomId,
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "lastMessage": lastMessage,
    "active": active,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Participant {
  String? id;
  String? name;
  String? email;
  List<String>? images;
  int? isOnline;
  DateTime? updatedAt;

  Participant({
    this.id,
    this.name,
    this.email,
    this.images,
    this.isOnline,
    this.updatedAt,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isOnline: json["isOnline"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "isOnline": isOnline,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
