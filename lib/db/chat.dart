import 'package:isar/isar.dart';

part 'chat.g.dart';

@Collection()
class Chat {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Index()
  late String senderID;

  late String msg;

  late String seen;

  late String messageID;

// @Backlink(to: "chatrooms")
// final chatroom = IsarLinks<Chatroom>();
}
