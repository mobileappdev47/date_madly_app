import 'package:date_madly_app/db/chat.dart';
import 'package:date_madly_app/db/chatroom.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveChatroom(List<Map<String, dynamic>> newCourse) async {
    final isar = await db;
    isar.writeTxn(() => isar.chatrooms.importJson(newCourse));
  }

  Future<void> saveChat(List<Map<String, dynamic>> newChat) async {
    final isar = await db;
    isar.writeTxn(() => isar.chats.importJson(newChat));
  }

  // Future<void> saveTeacher(Teacher newTeacher) async {
  //   final isar = await db;
  //   isar.writeTxnSync<int>(() => isar.teachers.putSync(newTeacher));
  // }

  Future<List<Chat>> getAllChat() async {
    final isar = await db;
    return await isar.chats.where().findAll();
  }

  // Stream<List<Chatroom>> listenToCourses() async* {
  //   final isar = await db;
  //   yield* isar.chatrooms.where().watch(initialReturn: true);
  // }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  // Future<List<Student>> getStudentsFor(Course course) async {
  //   final isar = await db;
  //   return await isar.students
  //       .filter()
  //       .courses((q) => q.idEqualTo(course.id))
  //       .findAll();
  // }

  // Future<List<Chatroom>> getChatroomFor(Chat chat) async {
  //   final isar = await db;
  //   return await isar.chatrooms
  //       .filter()
  //       .((q) => q.idEqualTo(chat.id))
  //       .findAll();
  // }

  // Future<List<Chat?>> getChatFor(Chat chat) async {
  //   final isar = await db;

  //   final teacher = await isar.chats
  //       .filter()
  //       .chatroom((q) => q.idEqualTo(chat.id))
  //       .findAll();

  //   return teacher;
  // }

  // Future<Teacher?> getTeacherFor(Course course) async {
  //   final isar = await db;

  //   final teacher = await isar.teachers
  //       .filter()
  //       .course((q) => q.idEqualTo(course.id))
  //       .findFirst();

  //   return teacher;
  // }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [ChatSchema, ChatroomSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
