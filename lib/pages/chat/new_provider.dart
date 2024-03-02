import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/chat/chat_message.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewChatProvider extends ChangeNotifier {
  String userEmail = PrefService.getString(PrefKeys.email).toString();
  String? roomId;
  DateTime lastMsg = DateTime.now();
  String otherEmail = '';

  TextEditingController msController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  @override
  Future<void> onInit() async {
    getUid();
    notifyListeners();
  }

  getUid() async {
    userEmail = PrefService.getString(PrefKeys.email).toString();
    notifyListeners();
  }

  String getChatId(String uid1, String uid2) {
    if (uid1.hashCode > uid2.hashCode) {
      return '${uid1}_$uid2';
    } else {
      return '${uid2}_$uid1';
    }
  }

  getRoomId(String otherUid) async {
    DocumentReference doc = FirebaseFirestore.instance
        .collection("chats")
        .doc(getChatId(userEmail.toString(), otherUid));

    await doc
        .collection(getChatId(userEmail.toString(), otherUid))
        .get()
        .then((value) async {
      DocumentSnapshot<Object?> i = await doc.get();
      if (i.exists == false) {
        await doc.set({
          "uidList": [userEmail, otherUid],
        });
      }
      if (value.docs.isNotEmpty) {
        roomId = getChatId(userEmail.toString(), otherUid);
      } else {
        await FirebaseFirestore.instance
            .collection("chats")
            .doc(getChatId(userEmail.toString(), otherUid))
            .collection(getChatId(userEmail.toString(), otherUid))
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            roomId = getChatId(userEmail.toString(), otherUid);
          } else {
            roomId = getChatId(userEmail.toString(), otherUid);
          }
        });
      }
    });
  }

  List chatUsers = [];

  TextEditingController searchController = TextEditingController();
  List filterList = [];
  void searching(value, chatUsersList) {
    filterList = (chatUsersList.where((element) {
      return element['name']
          .toString()
          .toLowerCase()
          .contains(value.toString().toLowerCase());
    }).toList());
    notifyListeners();
    print(filterList);
  }

  List image = [
    'assets/icons/Add Image (1).png',
    'assets/icons/Add Image_04.png',
    'assets/icons/Add Image_06.png',
    'assets/icons/Add Image (1).png',
    'assets/icons/Add Image_04.png',
    'assets/icons/Add Image_06.png',
  ];

  List boolList = [];

  bool isImage = false;

  onTapDelete(int index) {
    isImage = false;

    boolList[index] = false;
    image.removeAt(index);
  }

  int deleteIndex = 0;
  void gotoChatScreen(
    BuildContext context,
    String otherUid,
    email,
      userImage
  ) async {
    await getRoomId(otherUid);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => NewChatScreen(
    //             roomId: roomId,
    //             email: email,
    //             otherEmail: otherUid,
    //             userEmail: userEmail)));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(
              image:userImage,
                roomId: roomId,
                email: email,
                otherEmail: otherUid,
                userEmail: userEmail)));
  }

  void sendMessage(String roomId, otherUid) async {
    String msg = msController.text;

    if (isToday(lastMsg) == false) {
      await sendAlertMsg();
    }
    await setMessage(roomId, msg, userEmail);
    setLastMsgInDoc(msg);
    notifyListeners();
  }

  Future<void> setLastMsgInDoc(String msg) async {
    await FirebaseFirestore.instance.collection("chats").doc(roomId).update({
      "lastMessage": msg,
      "lastMessageSender": userEmail,
      "lastMessageTime": DateTime.now(),
      "lastMessageRead": false,
    });
  }

  Future<void> sendAlertMsg() async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(roomId)
        .collection(roomId!)
        .doc()
        .set({
      "content": "new Day",
      "senderUid": userEmail,
      "type": "alert",
      "time": DateTime.now()
    });
  }

  Future<void> setMessage(String roomId, msg, userEmail) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(roomId)
        .collection(roomId)
        .doc()
        .set({
      "content": msg,
      "type": "text",
      "senderUid": userEmail,
      "time": DateTime.now(),
      "read": false,
    });
    msController.clear();
    notifyListeners();
  }

  Future<void> setReadTrue(String docId) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(roomId)
        .collection(roomId!)
        .doc(docId)
        .update({"read": true});
    await setReadInChatDoc(true);
  }

  Future<void> setReadInChatDoc(bool status) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(roomId)
        .update({"lastMessageRead": status});
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  bool isToday(DateTime time) {
    DateTime now = DateTime.now();

    if (now.year == time.year &&
        now.month == time.month &&
        now.day == time.day) {
      return true;
    }
    return false;
  }

  var imageChat;
bool loader = false;
  pickImage(context, roomId) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageChat = File(pickedFile!.path);

      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context,s) {
                return AlertDialog(
                    title: Text("Send Image"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Image.file(File(pickedFile.path))),
                            loader == true
                                ? Center(
                              child: CircularProgressIndicator(color: ColorRes.appColor,),
                            )
                                : SizedBox()
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
                          imageChat = null;
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorRes.appColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: ColorRes.white, fontSize: 15),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          loader =true;
                          s.call((){});

                          await uploadImage(roomId);
                          Navigator.pop(context);

                          loader =false;
                          s.call((){});

                        },
                        child: Container(
                          height: 40,
                          width: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorRes.appColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Send",
                            style: TextStyle(color: ColorRes.white, fontSize: 15),
                          ),
                        ),
                      )
                    ]);
              }
            );
          });
      print(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage(String roomId) async {
    if (imageChat == null) return;

    String fileName =
        'chat_images/${DateTime.now().millisecondsSinceEpoch}_${userEmail}_${imageChat!.path.split('/').last}';
    Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

    try {
      TaskSnapshot snapshot = await storageRef.putFile(imageChat!);

      String downloadUrl = await snapshot.ref.getDownloadURL();

      await sendImageMessage(roomId, userEmail, downloadUrl);

      imageChat = null;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> sendImageMessage(
      String roomId, String senderUid, String imageUrl) async {
    final messagesRef = FirebaseFirestore.instance
        .collection("chats")
        .doc(roomId)
        .collection(roomId);

    await messagesRef.add({
      "content": imageUrl,
      "type": "image",
      "senderUid": senderUid,
      "time": DateTime.now(),
      "read": false,
    });

    await setLastMsgInDoc(
      imageUrl,
    );
  }
}
