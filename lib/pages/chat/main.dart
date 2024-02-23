import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/common/text_style.dart';
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
    getCollectionLength();
    super.initState();
  }

  List boolList = [];
  getCollectionLength() async {
    await FirebaseFirestore.instance.collection('Auth').get().then((value) {
      print(value.docs.length);
      boolList = List.generate(value.docs.length, (index) => false);
    });
  }

  onTapDelete2(int index, otherEmail) async {
    NewChatProvider newChatProvider =
        Provider.of<NewChatProvider>(context, listen: false);
    String docid = newChatProvider.getChatId(userEmail, otherEmail);
    print(docid);
    newChatProvider.isImage = false;
    boolList[index] = false;
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

  Widget build(BuildContext context) {
    return Consumer<NewChatProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          backgroundColor: ColorRes.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen1(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: ColorRes.appColor,
                ),
              );
            },
          ),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 25),
                child: NewTextField(
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
                          builder: (context) => MyMatches(),
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
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.image.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        radius: 30,
                        child: Image.asset(value.image[index]),
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
              SizedBox(
                height: 350,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream:
                      FirebaseFirestore.instance.collection('Auth').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return const SizedBox();
                    }
                    return snapshot.data!.docs.isEmpty
                        ? const Text("No Result Found")
                        : SizedBox(
                            height: 350,
                            child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  if (snapshot.data!.docs[index]
                                          .data()['Email'] ==
                                      userEmail) {
                                    return const SizedBox();
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        value.gotoChatScreen(
                                          context,
                                          snapshot.data!.docs[index]
                                              .data()['Email'],
                                          snapshot.data!.docs[index]
                                              .data()['Email'],
                                        );
                                      },
                                      onLongPress: () {
                                        setState(() {
                                          value.isImage = true;
                                          boolList[index] = true;
                                          value.otherEmail = snapshot
                                              .data!.docs[index]
                                              .data()['Email'];
                                          value.deleteIndex = index;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: boolList[index]
                                              ? ColorRes.appColor
                                                  .withOpacity(0.2)
                                              : ColorRes.lgrey,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    value.image[0],
                                                    scale: 3,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .data()[
                                                                      'Email']
                                                                  .toString()
                                                                  .split('.')
                                                                  .first,
                                                              style: mulishbold
                                                                  .copyWith(
                                                                fontSize: 14,
                                                                color: ColorRes
                                                                    .darkGrey,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 130,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 15),
                                                              child: Text(
                                                                Strings.pm,
                                                                style: mulishbold
                                                                    .copyWith(
                                                                  fontSize: 14,
                                                                  color:
                                                                      ColorRes
                                                                          .grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: SizedBox(
                                                          width: 260,
                                                          child: Text(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            Strings.Omg,
                                                            style: mulishbold
                                                                .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    color: ColorRes
                                                                        .grey),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          );

                    ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data!.docs[index].data()['Email'] ==
                            userEmail) {
                          return const SizedBox();
                        } else {
                          return InkWell(
                            onTap: () {
                              value.gotoChatScreen(
                                context,
                                snapshot.data!.docs[index].data()['Email'],
                                snapshot.data!.docs[index].data()['Email'],
                              );
                              // setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 25),
                              child: Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: snapshot.data!.docs[index]
                                        .data()['Email']
                                        .toString()
                                        .isEmpty
                                    ? const SizedBox()
                                    : Text(
                                        snapshot.data!.docs[index]
                                            .data()['Email']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
