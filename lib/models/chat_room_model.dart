class ChatRoomModel {
  List<ChatRoom>? chatRoom;

  ChatRoomModel({this.chatRoom});

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    if (json['chatRoom'] != null) {
      chatRoom = <ChatRoom>[];
      json['chatRoom'].forEach((v) {
        chatRoom!.add(ChatRoom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chatRoom != null) {
      data['chatRoom'] = chatRoom!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatRoom {
  String? sId;
  String? chatroomID;
  List<Participants>? participants;
  String? lastMessage;
  String? messageBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ChatRoom(
      {this.sId,
      this.chatroomID,
      this.participants,
      this.lastMessage,
      this.messageBy,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chatroomID = json['chatroomID'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
    lastMessage = json['lastMessage'];
    messageBy = json['messageBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['chatroomID'] = chatroomID;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    data['lastMessage'] = lastMessage;
    data['messageBy'] = messageBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Participants {
  String? sId;
  List<String>? images;
  String? name;
  int? isOnline;
  String? updatedAt;

  Participants(
      {this.sId, this.images, this.name, this.isOnline, this.updatedAt});

  Participants.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    images = json['images'].cast<String>();
    isOnline = json['isOnline'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['images'] = images;
    data['name'] = name;
    data['isOnline'] = isOnline;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
