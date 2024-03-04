import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/api/get_all_chat_api.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/models/get_all_chat_model.dart';
import 'package:date_madly_app/pages/chat/new_provider.dart';
import 'package:date_madly_app/pages/chat/my_matches.dart';
import 'package:date_madly_app/pages/login/profile_photo/profile_photo_screen.dart';
import 'package:date_madly_app/providers/chat_provider.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/body_builder.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// import 'package:timeago/timeago.dart' as timeago;
import '../../common/text_feild_common.dart';
import '../../network/api.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';
import '../map/map_page_1.dart';
import '../me/personal_info.dart';
import '../new/enter_personal_data/enter_personal_data_screen.dart';
import 'chat_message.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  String userEmail = PrefService.getString(PrefKeys.email).toString();

  @override
  void initState() {
    getAllChatApi();
    getCollectionLength();
    super.initState();
  }

  List boolList = [];
  List lastMessage = [];
  List lastMessageTime = [];
  bool isDelete = false;

  getCollectionLength() async {
    // await FirebaseFirestore.instance.collection('Auth').get().then((value) {
    //   print(value.docs.length);
    //   boolList = List.generate(value.docs.length, (index) => false);
    // });
    // setState(() {});
    fireStore
        .collection("Auth")
        .doc(PrefService.getString(PrefKeys.email))
        .get()
        .then((value) {
      var data = value.data();
      if (data != null) {
        boolList = List.generate(data['ChatUserList'].length, (index) => false);
        lastMessage = List.generate(data['ChatUserList'].length, (index) => '');
        lastMessageTime =
            List.generate(data['ChatUserList'].length, (index) => '');
      }
    });
    setState(() {});
  }

  onTapDelete2(int index, otherEmail) async {
    boolList[index] = false;

    NewChatProvider newChatProvider =
        Provider.of<NewChatProvider>(context, listen: false);
    String docid = newChatProvider.getChatId(userEmail, otherEmail);
    print(docid);
    newChatProvider.isImage = false;
    myFirebaseList.clear();
    fireStore
        .collection("Auth")
        .doc(PrefService.getString(PrefKeys.email))
        .get()
        .then((value) async {
      var data = value.data();
      if (data != null && data['ChatUserList'].isNotEmpty) {
        for (int i = 0; i < data['ChatUserList'].length; i++) {
          myFirebaseList.add(data['ChatUserList'][i]);
        }
        print(myFirebaseList);

        for (int i = 0; i < myFirebaseList.length; i++) {
          if (myFirebaseList[i]['Email'] == otherEmail) {
            print('delete');
            isDelete = true;
            setState(() {});
            break;
          } else {
            isDelete = false;
            setState(() {});
          }
        }

        if (isDelete == true) {
          myFirebaseList.removeAt(index);
          await fireStore
              .collection("Auth")
              .doc(PrefService.getString(PrefKeys.email))
              .update({'ChatUserList': myFirebaseList});
          boolList = List.generate(myFirebaseList.length, (index) => false);
        } else {}
        getCollectionLength();
      }
    });

    await FirebaseFirestore.instance.collection("chats").doc(docid).delete();

    var chatsData = await FirebaseFirestore.instance
        .collection("chats")
        .doc(docid)
        .collection(docid)
        .get();

    chatsData.docs.forEach((element) {
      FirebaseFirestore.instance
          .collection("chats")
          .doc(docid)
          .collection(docid)
          .doc(element.id)
          .delete();
    });
    setState(() {});
  }

  bool loader = false;
  GetAllChatRoom getAllChatRoom = GetAllChatRoom();

  getAllChatApi() async {
    NewChatProvider newChatProvider =
        Provider.of<NewChatProvider>(context, listen: false);
    newChatProvider.userEmail = PrefService.getString(PrefKeys.email);
    try {
      loader = true;
      setState(() {});
      getAllChatRoom = await GetAllChatApi.getAllChatApi();
      loader = false;
      setState(() {});
    } catch (e) {
      loader = false;
      setState(() {});
      print('==============>${e.toString()}');
    }
  }

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List myFirebaseList = [];
  List otherFirebaseList = [];
  bool isAlready = false;
  bool isAlready2 = false;
  Map otherUserMap = {};

  addDataInFirebase(email, map, userImage) async {
    NewChatProvider newChatProvider =
        Provider.of<NewChatProvider>(context, listen: false);
    myFirebaseList.clear();
    fireStore
        .collection("Auth")
        .doc(PrefService.getString(PrefKeys.email))
        .get()
        .then((value) async {
      var data = value.data();
      if (data != null && data['ChatUserList'].isNotEmpty) {
        for (int i = 0; i < data['ChatUserList'].length; i++) {
          myFirebaseList.add(data['ChatUserList'][i]);
        }
        print(myFirebaseList);
        for (int i = 0; i < myFirebaseList.length; i++) {
          if (myFirebaseList[i]['Email'] == email) {
            print('already');

            isAlready = true;
            setState(() {});
            break;
          } else {
            isAlready = false;
            setState(() {});
          }
        }

        if (isAlready == false) {
          myFirebaseList.add(map);
          await fireStore
              .collection("Auth")
              .doc(PrefService.getString(PrefKeys.email))
              .update({'ChatUserList': myFirebaseList});
          // boolList = List.generate(myFirebaseList.length, (index) => false);
          // setState(() {});
        } else {
          newChatProvider.gotoChatScreen(context, email, email, userImage);
        }
        getCollectionLength();
      } else {
        await fireStore
            .collection("Auth")
            .doc(PrefService.getString(PrefKeys.email))
            .set({
          'ChatUserList': [map]
        });

        getCollectionLength();
      }
    });
  }

  Widget build(BuildContext context) {
    return Consumer<NewChatProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          backgroundColor: ColorRes.white,
          title: Text(
            Strings.chat,
            style: mulishbold.copyWith(
              fontSize: 18.75,
              color: ColorRes.appColor,
            ),
          ),
          actions: [
            value.isImage == true
                ? Row(
                    children: [
                      Image.asset(
                        AssertRe.Archive_Icon,
                        scale: 3,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          // value.onTapDelete(value.deleteIndex);
                          onTapDelete2(value.deleteIndex, value.otherEmail);
                          setState(() {});
                        },
                        child: Image.asset(
                          AssertRe.Dump_Icon,
                          scale: 3,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 25),
                    child: NewTextField(
                      onChange: (p0) {
                        value.searching(p0, value.chatUsers);
                      },
                      controller: value.searchController,
                      hintText: Strings.search_massages,
                      prefix: AssertRe.Search_Icon,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        Strings.new_matches,
                        style: mulishbold.copyWith(
                          fontSize: 15,
                          color: ColorRes.darkGrey,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyMatches(
                                  chatUsers: getAllChatRoom.chatRoom ?? []),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              Strings.show_all,
                              style: mulishbold.copyWith(
                                fontSize: 15,
                                color: ColorRes.appColor,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: ColorRes.appColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 20,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: getAllChatRoom.chatRoom?.length ?? 0,
                      itemBuilder: (context, index) {
                        var data;
                        var data2;
                        if (getAllChatRoom
                                .chatRoom![index].participants![1].email ==
                            PrefService.getString(PrefKeys.email)) {
                          data =
                              getAllChatRoom.chatRoom![index].participants![0];
                          data2 =
                              getAllChatRoom.chatRoom![index].participants![1];
                        } else {
                          data =
                              getAllChatRoom.chatRoom![index].participants![1];
                          data2 =
                              getAllChatRoom.chatRoom![index].participants![0];
                        }

                        return GestureDetector(
                          onTap: () async {
                            getCollectionLength();
                            Map dataPass = {
                              'name': data.name ?? '',
                              "Email": data.email ?? '',
                              "userImage":
                                  data.images != null && data.images!.isNotEmpty
                                      ? data.images![0]
                                      : '',
                              'LastMsg': '',
                              'LastMsgTime': '',
                            };
                            otherUserMap = {
                              'name': data2.name ?? '',
                              "Email": data2.email ?? '',
                              "userImage": data2.images != null &&
                                      data2.images!.isNotEmpty
                                  ? data2.images![0]
                                  : '',
                              'LastMsg': '',
                              'LastMsgTime': '',
                            };
                            if (data.images.isNotEmpty) {
                              await addDataInFirebase(
                                  data.email ?? '', dataPass, data.images[0]);
                            } else {
                              await addDataInFirebase(
                                  data.email ?? '', dataPass, '');
                            }
                          },
                          child: ClipOval(
                            child: data.images != null &&
                                    data.images!.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: data.images?[0] ?? '',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => Image.asset(
                                          'assets/images/image_placeholder.png',
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.fill,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          'assets/images/image_placeholder.png',
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.fill,
                                        ))
                                : CachedNetworkImage(
                                    imageUrl: '',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => Image.asset(
                                          'assets/images/image_placeholder.png',
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.fill,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          'assets/images/image_placeholder.png',
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.fill,
                                        )),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 26),
                        child: Text(
                          Strings.messages,
                          style: mulishbold.copyWith(
                            fontSize: 14,
                            color: ColorRes.darkGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 36,
                  ),
                  value.searchController.text.isEmpty
                      ? SizedBox(
                          height: 350,
                          child: StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('Auth')
                                .doc(PrefService.getString(PrefKeys.email))
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData == false) {
                                return const SizedBox();
                              }

                              return snapshot.data == null ||
                                      snapshot.data!['ChatUserList'] == null ||
                                      snapshot.data!['ChatUserList'].isEmpty
                                  ? const Text("No Result Found")
                                  : boolList.isNotEmpty
                                      ? SizedBox(
                                          height: 350,
                                          child: ListView.builder(
                                              itemCount: snapshot
                                                      .data?['ChatUserList']
                                                      .length ??
                                                  0,
                                              itemBuilder: (context, index) {
                                                value.chatUsers = snapshot
                                                    .data?['ChatUserList'];
                                                if (snapshot.data?[
                                                            'ChatUserList']
                                                        [index]['Email'] ==
                                                    userEmail) {
                                                  return const SizedBox();
                                                } else {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      value.gotoChatScreen(
                                                          context,
                                                          snapshot.data?[
                                                                  'ChatUserList']
                                                              [index]['Email'],
                                                          snapshot.data?[
                                                                  'ChatUserList']
                                                              [index]['Email'],
                                                          snapshot.data?[
                                                                  'ChatUserList']
                                                              [
                                                              index]['userImage']);
                                                    },
                                                    onLongPress: () {
                                                      setState(() {
                                                        value.isImage = true;
                                                        boolList[index] = true;
                                                        value.deleteIndex =
                                                            index;
                                                        value
                                                            .otherEmail = snapshot
                                                                    .data?[
                                                                'ChatUserList']
                                                            [index]['Email'];
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        height: 80,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        color: boolList[
                                                                    index] ==
                                                                true
                                                            ? ColorRes.appColor
                                                                .withOpacity(
                                                                    0.2)
                                                            : ColorRes.lgrey,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                ClipOval(
                                                                  child: CachedNetworkImage(
                                                                      imageUrl: snapshot.data?['ChatUserList'][index]['userImage'] ?? '',
                                                                      height: 50,
                                                                      width: 50,
                                                                      fit: BoxFit.fill,
                                                                      placeholder: (context, url) => Image.asset(
                                                                            'assets/images/image_placeholder.png',
                                                                            height:
                                                                                60,
                                                                            width:
                                                                                60,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                      errorWidget: (context, url, error) => Image.asset(
                                                                            'assets/images/image_placeholder.png',
                                                                            height:
                                                                                60,
                                                                            width:
                                                                                60,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              15.0),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        snapshot.data?['ChatUserList'][index]['name'].toString() ??
                                                                            '',
                                                                        style: mulishbold
                                                                            .copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              ColorRes.darkGrey,
                                                                        ),
                                                                      ),
                                                                      StreamBuilder(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection(
                                                                                  "chats")
                                                                              .snapshots(),
                                                                          builder:
                                                                              (context, snap) {
                                                                            if (snap.hasData) {
                                                                              if (snap.data != null) {
                                                                                var doc = snap.data!.docs;
                                                                                doc.forEach((e) {
                                                                                  if (e.data()['uidList'][0].contains(PrefService.getString(PrefKeys.email))) {
                                                                                    if (e.data()['uidList'][1].contains(snapshot.data?['ChatUserList'][index]['Email'].toString().toString())) {
                                                                                      if (lastMessageTime.isNotEmpty) {
                                                                                        lastMessage[index] = e.data()['lastMessage'];
                                                                                      }
                                                                                    }
                                                                                  } else if (e.data()['uidList'][1].contains(PrefService.getString(PrefKeys.email))) {
                                                                                    if (e.data()['uidList'][0].contains(snapshot.data?['ChatUserList'][index]['Email'].toString().toString())) {
                                                                                      if (lastMessage.isNotEmpty) {
                                                                                        lastMessage[index] = e.data()['lastMessage'];
                                                                                      }
                                                                                    }
                                                                                  }
                                                                                });
                                                                              } else {
                                                                                if (lastMessage.isNotEmpty) {
                                                                                  lastMessage[index] = "";
                                                                                }
                                                                              }
                                                                              // return SizedBox();
                                                                              return snap.data?.docs != null && snap.data!.docs.isEmpty
                                                                                  ? const SizedBox()
                                                                                  : Container(
                                                                                      width: 100,
                                                                                      alignment: Alignment.centerLeft,
                                                                                      child: (lastMessage.isNotEmpty)
                                                                                          ? Text(
                                                                                              lastMessage[index].toString().contains("https://firebasestorage.googleapis.com") ? "Image" : lastMessage[index] ?? "",
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              maxLines: 1,
                                                                                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                                                                                            )
                                                                                          : const SizedBox(),
                                                                                    );
                                                                            } else {
                                                                              return SizedBox();
                                                                            }
                                                                          }),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                StreamBuilder(
                                                                    stream: FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "chats")
                                                                        .snapshots(),
                                                                    builder:
                                                                        (context,
                                                                            snap) {
                                                                      if (snap.data !=
                                                                          null) {
                                                                        var doc = snap
                                                                            .data!
                                                                            .docs;
                                                                        doc.forEach(
                                                                            (e) {
                                                                          if (e.data()['uidList'][0].contains(PrefService.getString(PrefKeys
                                                                              .email))) {
                                                                            if (e.data()['uidList'][1].contains(snapshot.data?['ChatUserList'][index]['Email'].toString())) {
                                                                              if (lastMessageTime.isNotEmpty) {
                                                                                lastMessageTime[index] = e.data()['lastMessageTime'];
                                                                              }
                                                                            }
                                                                          } else if (e
                                                                              .data()['uidList'][1]
                                                                              .contains(PrefService.getString(PrefKeys.email))) {
                                                                            if (e.data()['uidList'][0].contains(snapshot.data?['ChatUserList'][index]['Email'].toString())) {
                                                                              if (lastMessageTime.isNotEmpty) {
                                                                                lastMessageTime[index] = e.data()['lastMessageTime'];
                                                                              }
                                                                            }
                                                                          }
                                                                        });
                                                                      } else {
                                                                        if (lastMessageTime
                                                                            .isNotEmpty) {
                                                                          lastMessageTime[index] =
                                                                              "";
                                                                        }
                                                                      }

                                                                      return snap.data?.docs != null &&
                                                                              snap.data!.docs.isEmpty
                                                                          ? const SizedBox()
                                                                          : lastMessageTime.isEmpty
                                                                              ? const SizedBox()
                                                                              : (lastMessageTime[index] != '' && lastMessageTime[index] != null)
                                                                                  ? Container(
                                                                                      width: 100,
                                                                                      alignment: Alignment.centerRight,
                                                                                      child: Text(
                                                                                        DateFormat("hh:mm aa").format(lastMessageTime[index].toDate()),
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        maxLines: 1,
                                                                                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                                                                                      ),
                                                                                    )
                                                                                  : const SizedBox();
                                                                    }),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }),
                                        )
                                      : SizedBox();
                            },
                          ),
                        )
                      : SizedBox(
                          height: 350,
                          child: ListView.builder(
                              itemCount: value.filterList.length ?? 0,
                              itemBuilder: (context, index) {
                                if (value.filterList[index]['Email'] ==
                                    userEmail) {
                                  return const SizedBox();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      value.gotoChatScreen(
                                        context,
                                        value.filterList[index]['Email'],
                                        value.filterList[index]['Email'],
                                        value.filterList[index]['userImage'],
                                      );
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        // value.isImage = true;
                                        // boolList[index] = true;
                                        // value.otherEmail =
                                        //     value.filterList[index]['Email'];
                                        // value.deleteIndex = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: ColorRes.lgrey,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                ClipOval(
                                                  child: CachedNetworkImage(
                                                      imageUrl: value.filterList[
                                                                  index]
                                                              ['userImage'] ??
                                                          '',
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.fill,
                                                      placeholder: (context,
                                                              url) =>
                                                          Image.asset(
                                                            'assets/images/image_placeholder.png',
                                                            height: 60,
                                                            width: 60,
                                                            fit: BoxFit.fill,
                                                          ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                            'assets/images/image_placeholder.png',
                                                            height: 60,
                                                            width: 60,
                                                            fit: BoxFit.fill,
                                                          )),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            value.filterList[
                                                                        index]
                                                                        ['name']
                                                                    .toString() ??
                                                                '',
                                                            style: mulishbold
                                                                .copyWith(
                                                              fontSize: 14,
                                                              color: ColorRes
                                                                  .darkGrey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      child: SizedBox(
                                                        child: Text(
                                                          value.filterList[
                                                                      index]
                                                                  ['LastMsg'] ??
                                                              '',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: mulishbold
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  color: ColorRes
                                                                      .grey),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: Text(
                                                    value.filterList[index]
                                                            ['LastMsgTime'] ??
                                                        '',
                                                    style: mulishbold.copyWith(
                                                      fontSize: 14,
                                                      color: ColorRes.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }),
                        )
                ],
              ),
            ),
            loader == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
