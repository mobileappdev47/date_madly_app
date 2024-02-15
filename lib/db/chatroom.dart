import 'package:isar/isar.dart';

part 'chatroom.g.dart';

@Collection()
class Chatroom {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Index()
  String? chatroomID;

  List<Participants>? participants;

  String? lastMessage;

  bool? active;

  String? createdAt;

  String? updatedAt;


// final chatrooms = IsarLinks<Chat>();
}

@embedded
class Participants {
  String? name;
  List<String>? images = [];
  String? updatedAt;
  int? isOnline;
}
