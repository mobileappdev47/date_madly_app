class Call {
  String? callerId;
  String? callerName;
  String? callerPic;
  String? receiverId;
  String? receiverName;
  String? receiverPic;
  String? groupId;
  List<dynamic>? members;
  late bool isGroup;
  String? channelId;
  bool? hasDialled;
  bool? voiceCall;

  Call({
    this.callerId,
    this.callerName,
    this.callerPic,
    this.receiverId,
    this.receiverName,
    this.receiverPic,
    this.channelId,
    this.hasDialled,
    this.groupId,
    this.members,
    required this.isGroup,
    this.voiceCall,
  });

  // to map
  Map<String, dynamic> toMap() {
    return {
      "caller_id": callerId,
      "caller_name": callerName,
      "caller_pic": callerPic,
      "receiver_id": receiverId,
      "receiver_name": receiverName,
      "receiver_pic": receiverPic,
      "channel_id": channelId,
      "has_dialled": hasDialled,
      "group_id": groupId,
      "members": members,
      "is_group": isGroup,
      "voice_call": voiceCall,
    };
  }

  Call.fromMap(Map<String, dynamic> callMap) {
    callerId = callMap["caller_id"];
    callerName = callMap["caller_name"];
    callerPic = callMap["caller_pic"];
    receiverId = callMap["receiver_id"];
    receiverName = callMap["receiver_name"];
    receiverPic = callMap["receiver_pic"];
    channelId = callMap["channel_id"];
    hasDialled = callMap["has_dialled"];
    groupId = callMap["group_id"];
    members = callMap["members"];
    isGroup = callMap["is_group"] ?? false;
    voiceCall = callMap["voice_call"];
  }
}
