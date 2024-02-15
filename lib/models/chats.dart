class ChatsModel {
  List<Chat>? chat;

  ChatsModel({this.chat});

  ChatsModel.fromJson(Map<String, dynamic> json) {
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chat != null) {
      data['chat'] = chat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chat {
  String? sId;
  String? senderID;
  String? msg;
  bool? seen;
  String? messageID;
  String? chatroomID;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? iV;
  String? data;

  Chat(
      {this.sId,
      this.senderID,
      this.msg,
      this.seen,
      this.messageID,
      this.chatroomID,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.iV});

  Chat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderID = json['senderID'];
    msg = json['msg'];
    seen = json['seen'];
    messageID = json['messageID'];
    chatroomID = json['chatroomID'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    data = json['data'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['senderID'] = senderID;
    data['msg'] = msg;
    data['seen'] = seen;
    data['messageID'] = messageID;
    data['chatroomID'] = chatroomID;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['status'] = status;
    data['__v'] = iV;
    return data;
  }
}
