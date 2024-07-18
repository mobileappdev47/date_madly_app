import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/chat/chat_message.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../service/notification_service.dart';
import '../../utils/endpoint.dart';
import 'package:http/http.dart' as http;

class NewChatProvider extends ChangeNotifier {
  String userEmail = PrefService.getString(PrefKeys.email).toString();
  String? roomId;
  DateTime lastMsg = DateTime.now();
  String otherEmail = '';
  Timer? timer;
  int _counter = 0;

  int get counter => _counter;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _counter++;
      notifyListeners();
      print("-=-=-=-=-=-=-: ${_counter}");
    });
  }

  void stopTimer() {
    timer?.cancel();
    _counter = 0;
    notifyListeners();
  }

  String get formattedTime {
    final minutes = (_counter ~/ 60).toString().padLeft(2, '0');
    final seconds = (_counter % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

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

  bool isEnterChatScreen = false;

  void gotoChatScreen(BuildContext context, String otherUid, email, userImage,
      otherUsername) async {
    await getRoomId(otherUid);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => NewChatScreen(
    //             roomId: roomId,
    //             email: email,
    //             otherEmail: otherUid,
    //             userEmail: userEmail)));
    print("userEmailuserEmail ${userEmail}");
    print("otherUidotherUid ${otherUid}");
    print("roomIdroomId ${roomId}");
    print("emailemail ${email}");
    print("userImageuserImage ${userImage}");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(
                  image: userImage,
                  roomId: roomId,
                  email: email,
                  otherUid: otherUid,
                  userEmail: userEmail,
                  name: otherUsername,
                )));
  }

  Future<void> sendMessage(String roomId, otherUid) async {
    // void sendMessage(String roomId, otherUid) async {
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

  pickImage(context, roomId,
      {required String otherUserId,
      required String name,
      required String currentUID,
      required String otherUserProfileImage,
      required String otherUID}) async {
    // pickImage(context, roomId) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageChat = File(pickedFile!.path);

      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, s) {
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
                                  child: CircularProgressIndicator(
                                    color: ColorRes.appColor,
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        imageChat = null;
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(
                                0xffED1E79,
                              ),
                              Color(
                                0xffC1272D,
                              ),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: ColorRes.white, fontSize: 15),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        loader = true;
                        s.call(() {});

                        await uploadImage(roomId);

                        final FirebaseFirestore fireStore =
                            FirebaseFirestore.instance;
                        var fcmToken2;

                        await fireStore
                            .collection("Auth")
                            .doc(otherUserId)
                            .get()
                            .then((value) async {
                          if (value.exists) {
                            fcmToken2 = value.data()?['fcmToken'];
                            print('fcmToken: ${fcmToken2}');
                          } else {
                            print('Document for does not exist');
                          }
                        });

                        await fireStore
                            .collection("Auth")
                            .doc(PrefService.getString(PrefKeys.email))
                            .update({
                          'fcmToken':
                              PrefService.getString(PrefKeys.deviceToken)
                        });

                        if (fcmToken2 != null && fcmToken2 != "") {
                          // second user token = fcmToken2
                          NotificationService().sendNotification(
                              currentUID: currentUID,
                              otherUID: otherUID,
                              currentUserProfileImage: PrefService.getString(
                                  PrefKeys.currentUserImage),
                              recipientToken: fcmToken2,
                              title: PrefService.getString(PrefKeys.userName),
                              imageUrl: downloadUrl,
                              roomId: roomId,);
                        }

                        Navigator.pop(context);

                        loader = false;
                        s.call(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(
                                0xffED1E79,
                              ),
                              Color(
                                0xffC1272D,
                              ),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Send",
                          style: TextStyle(color: ColorRes.white, fontSize: 15),
                        ),
                      ),
                    )
                  ]);
            });
          });
      print(pickedFile.path);
      notifyListeners();
    }
  }

  String downloadUrl="";

  Future<void> uploadImage(String roomId) async {
    if (imageChat == null) return;

    String fileName =
        'chat_images/${DateTime.now().millisecondsSinceEpoch}_${userEmail}_${imageChat!.path.split('/').last}';
    Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

    try {
      TaskSnapshot snapshot = await storageRef.putFile(imageChat!);

      downloadUrl = await snapshot.ref.getDownloadURL();
      // String downloadUrl = await snapshot.ref.getDownloadURL();

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

  Future membershipSubscribeApi(Map<String, dynamic> body, context) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse(EndPoints.membershipSubscribe));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        print("datadatadata ${data}");
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<bool> selectedBoolValue = [];
  List<Package> myProductList = [];
  List<Package> selectedProduct = [];

  selectedPlanList() {
    selectedBoolValue = List<bool>.generate(3, (index) {
      if (index == 1) {
        return true;
      } else {
        return false;
      }
    });
  }

  updatedPlanList(int index, bool value) {
    selectedBoolValue = List<bool>.generate(3, (index) {
      return false;
    });
    selectedBoolValue[index] = value;
    notifyListeners();
  }

  productData(Package productData) {
    selectedProduct.clear();
    selectedProduct.add(productData);
    notifyListeners();
  }
//
// addPlanEventToFirebase(String identifier) {
//   if (identifier == 'face26_1y_3999') {
//     FirebaseAnalyticsService().logEvent(AnalyticsEvent.purchaseOneYearPlan,
//         parameters: {'uniqueId': uniqueId});
//   } else if (identifier == 'face26_1m_899') {
//     FirebaseAnalyticsService().logEvent(AnalyticsEvent.purchaseOneMonthPlan,
//         parameters: {'uniqueId': uniqueId});
//   } else if (identifier == 'face26_1m_free_899') {
//     FirebaseAnalyticsService().logEvent(AnalyticsEvent.purchaseFreeTrailPlan,
//         parameters: {'uniqueId': uniqueId});
//   } else {
//     FirebaseAnalyticsService().logEvent(AnalyticsEvent.purchaseOneYearPlan,
//         parameters: {'uniqueId': uniqueId});
//   }
// }
//
// activeSubscriptionDetail(String identifier) async {
//   ActiveSubscriptionDetail subscriptionDetail;
//   if (identifier == 'face26_1y_3999') {
//     subscriptionDetail = ActiveSubscriptionDetail(
//         myProductList[1].storeProduct.description.toString());
//     box.put(activeSubscription, subscriptionDetail);
//   } else if (identifier == 'face26_1m_899') {
//     subscriptionDetail = ActiveSubscriptionDetail(
//         myProductList[0].storeProduct.description.toString());
//     box.put(activeSubscription, subscriptionDetail);
//   } else if (identifier == 'face26_1m_free_899') {
//     subscriptionDetail = ActiveSubscriptionDetail(
//         myProductList[2].storeProduct.description.toString());
//     box.put(activeSubscription, subscriptionDetail);
//   } else {
//     subscriptionDetail = ActiveSubscriptionDetail(
//         myProductList[1].storeProduct.description.toString());
//     box.put(activeSubscription, subscriptionDetail);
//   }
//   notifyListeners();
// }
}
