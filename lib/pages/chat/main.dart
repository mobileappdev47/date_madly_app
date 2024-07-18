
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/api/get_all_chat_api.dart';
import 'package:date_madly_app/common/common_gradient_button.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/models/get_all_chat_model.dart';
import 'package:date_madly_app/pages/chat/new_provider.dart';
import 'package:date_madly_app/pages/chat/my_matches.dart';

// import 'package:date_madly_app/service/chat_and_call_notification.dart';
import 'package:date_madly_app/pages/revenu_cat_demo/provider/revenuecat.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/dialogs.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

// import 'package:timeago/timeago.dart' as timeago;
import '../../common/text_feild_common.dart';
import '../../purchase_setup/purchase_api.dart';
import '../../purchase_setup/singletons_data.dart';
import '../../purchase_setup/store_config.dart';
import '../../service/notification_service.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';
import 'chat_message.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  String userEmail = PrefService.getString(PrefKeys.email).toString();

  // List<Package> packages = [];
  int selectedIndex = 0;

  Future<void> initPlatformState() async {
    // final userModel = Provider.of<UserModel>(context, listen: false);
    await Purchases.setDebugLogsEnabled(true);
    PurchasesConfiguration configuration;
    configuration = PurchasesConfiguration(StoreConfig.instance!.apiKey)
      ..appUserID = PrefService.getString(PrefKeys.email)
      ..observerMode = false;
    await Purchases.configure(configuration);

    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    appData.appUserID = customerInfo.originalAppUserId;
    // isProductLoading.value = true;
    //Offerings offerings = await Purchases.getOfferings();

    Purchases.addCustomerInfoUpdateListener((customerInfo1) async {
      appData.appUserID = customerInfo1.originalAppUserId;
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      Offerings offerings = await Purchases.getOfferings();
      var myProductList = offerings.current?.availablePackages;

      if (mounted) {
        final valueProvider =
            Provider.of<NewChatProvider>(context, listen: false);
        valueProvider.myProductList = myProductList!;
        if (valueProvider.myProductList.isEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('no founds')));
        }
      }

      (customerInfo.entitlements.all[entitlementID.value] != null &&
              customerInfo.entitlements.all[entitlementID.value]!.isActive)
          // ? subscriptionProvider.setEntitlement(true)
          // : subscriptionProvider.setEntitlement(false);
          ? appData.entitlementIsActive = true
          : appData.entitlementIsActive = false;
      if (mounted) {
        setState(() {});
      }
    });
  }

  // void fetchOffers() async {
  //   final offerings = await PurchaseApis.fetchOffers();
  //   if (offerings.isEmpty) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('no founds')));
  //   } else {
  //     print('Yes get data');
  //     packages = offerings
  //         .map((offer) => offer.availablePackages)
  //         .expand((pair) => pair)
  //         .toList();
  //     print(packages);
  //     // showModalBottomSheet(
  //     //   context: context,
  //     //   builder: (context) {
  //     //     return PaymentWalletWidget(
  //     //       title: 'Upgrade your plan',
  //     //       des: 'new plan to benefits',
  //     //       package: packages,
  //     //       onClickedPackage: (value) async {
  //     //         await PurchaseApis.purchasePackage(value);
  //     //         Navigator.pop(context);
  //     //       },
  //     //     );
  //     //   },
  //     // );
  //   }
  // }

  @override
  void initState() {
    if (payLoadFromChat.containsKey("fromChat")) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await Future.delayed(Duration(seconds: 1)).then(
          (value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          roomId: payLoadFromChat["roomId"],
                          name: payLoadFromChat["title"],
                          image: payLoadFromChat["receiverImage"],
                          email: payLoadFromChat["senderID"],
                          otherUid: payLoadFromChat["senderID"],
                          userEmail: payLoadFromChat["receiverId"],
                        )));
          },
        );
      });
    }
    getAllChatApi();
    getCollectionLength();
    initPlatformState();
    // fetchOffers();
    // initStripe();
    super.initState();
  }

  List boolList = [];
  List lastMessage = [];
  List lastMessageTime = [];
  bool isDelete = false;

  getCollectionLength() async {
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
          newChatProvider.gotoChatScreen(
              context, email, email, userImage, map['name']);
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
    var entitle = Provider.of<RevenueCatProvider>(context).entitlement;
    return Consumer<NewChatProvider>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                Dialogs().showLogoutDialog(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorRes.appColor,
                size: 18,
              )),
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
            Stack(
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
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: getAllChatRoom.chatRoom?.length ?? 0,
                          itemBuilder: (context, index) {
                            var data;
                            var data2;
                            if (getAllChatRoom.chatRoom![index].participants!
                                        .length ==
                                    2 &&
                                getAllChatRoom
                                        .chatRoom![index].participants![1].id ==
                                    PrefService.getString(PrefKeys.email)) {
                              data = getAllChatRoom
                                  .chatRoom![index].participants![0];
                              data2 = getAllChatRoom
                                  .chatRoom![index].participants![1];
                            } else {
                              if (getAllChatRoom
                                      .chatRoom![index].participants!.length ==
                                  2) {
                                data = getAllChatRoom
                                    .chatRoom![index].participants![1];
                                data2 = getAllChatRoom
                                    .chatRoom![index].participants![0];
                              } else {
                                data = getAllChatRoom
                                    .chatRoom![index].participants![0];
                                data2 = getAllChatRoom
                                    .chatRoom![index].participants![0];
                                return SizedBox();
                              }
                            }
                            return GestureDetector(
                              onTap: () async {
                                getCollectionLength();
                                Map dataPass = {
                                  'name': data.name ?? '',
                                  "Email": data.id ?? '',
                                  "userImage": data.images != null &&
                                          data.images!.isNotEmpty
                                      ? data.images![0]
                                      : '',
                                  'LastMsg': '',
                                  'LastMsgTime': '',
                                };
                                otherUserMap = {
                                  'name': data2.name ?? '',
                                  "Email": data2.id ?? '',
                                  "userImage": data2.images != null &&
                                          data2.images!.isNotEmpty
                                      ? data2.images![0]
                                      : '',
                                  'LastMsg': '',
                                  'LastMsgTime': '',
                                };
                                if (data.images.isNotEmpty) {
                                  await addDataInFirebase(
                                      data.id ?? '', dataPass, data.images[0]);
                                } else {
                                  await addDataInFirebase(
                                      data.id ?? '', dataPass, '');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ClipOval(
                                  child: data.images != null &&
                                          data.images!.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: data.images?[0] ?? '',
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              Image.asset(
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
                                          placeholder: (context, url) =>
                                              Image.asset(
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
                                          snapshot.data!['ChatUserList'] ==
                                              null ||
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
                                                  itemBuilder:
                                                      (context, index) {
                                                    value.chatUsers = snapshot
                                                        .data?['ChatUserList'];
                                                    if (snapshot.data?[
                                                                'ChatUserList']
                                                            [index]['Email'] ==
                                                        userEmail) {
                                                      return const SizedBox();
                                                    } else {
                                                      return InkWell(
                                                        onTap: () {
                                                          if (value
                                                                  .isEnterChatScreen ==
                                                              false) {
                                                            value.isEnterChatScreen =
                                                                true;

                                                            value
                                                                .gotoChatScreen(
                                                              context,
                                                              snapshot.data?[
                                                                      'ChatUserList']
                                                                  [
                                                                  index]['Email'],
                                                              snapshot.data?[
                                                                      'ChatUserList']
                                                                  [
                                                                  index]['Email'],
                                                              snapshot.data?[
                                                                          'ChatUserList']
                                                                      [index]
                                                                  ['userImage'],
                                                              snapshot.data?[
                                                                      'ChatUserList']
                                                                  [
                                                                  index]['name'],
                                                            );
                                                          }
                                                        },
                                                        onLongPress: () {
                                                          setState(() {
                                                            value.isImage =
                                                                true;
                                                            boolList[index] =
                                                                true;
                                                            value.deleteIndex =
                                                                index;
                                                            value
                                                                .otherEmail = snapshot
                                                                        .data?[
                                                                    'ChatUserList']
                                                                [
                                                                index]['Email'];
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15),
                                                            height: 80,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            color: boolList[
                                                                        index] ==
                                                                    true
                                                                ? ColorRes
                                                                    .appColor
                                                                    .withOpacity(
                                                                        0.2)
                                                                : ColorRes
                                                                    .lgrey,
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
                                                                                height: 60,
                                                                                width: 60,
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                          errorWidget: (context, url, error) => Image.asset(
                                                                                'assets/images/image_placeholder.png',
                                                                                height: 60,
                                                                                width: 60,
                                                                                fit: BoxFit.fill,
                                                                              )),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              15.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            snapshot.data?['ChatUserList'][index]['name'].toString() ??
                                                                                '',
                                                                            style:
                                                                                mulishbold.copyWith(
                                                                              fontSize: 14,
                                                                              color: ColorRes.darkGrey,
                                                                            ),
                                                                          ),
                                                                          StreamBuilder(
                                                                              stream: FirebaseFirestore.instance.collection("chats").snapshots(),
                                                                              builder: (context, snap) {
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
                                                                            var doc =
                                                                                snap.data!.docs;
                                                                            doc.forEach((e) {
                                                                              if (e.data()['uidList'][0].contains(PrefService.getString(PrefKeys.email))) {
                                                                                if (e.data()['uidList'][1].contains(snapshot.data?['ChatUserList'][index]['Email'].toString())) {
                                                                                  if (lastMessageTime.isNotEmpty) {
                                                                                    lastMessageTime[index] = e.data()['lastMessageTime'];
                                                                                  }
                                                                                }
                                                                              } else if (e.data()['uidList'][1].contains(PrefService.getString(PrefKeys.email))) {
                                                                                if (e.data()['uidList'][0].contains(snapshot.data?['ChatUserList'][index]['Email'].toString())) {
                                                                                  if (lastMessageTime.isNotEmpty) {
                                                                                    lastMessageTime[index] = e.data()['lastMessageTime'];
                                                                                  }
                                                                                }
                                                                              }
                                                                            });
                                                                          } else {
                                                                            if (lastMessageTime.isNotEmpty) {
                                                                              lastMessageTime[index] = "";
                                                                            }
                                                                          }

                                                                          return snap.data?.docs != null && snap.data!.docs.isEmpty
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
                                      return InkWell(
                                        onTap: () {
                                          if (value.isEnterChatScreen ==
                                              false) {
                                            value.isEnterChatScreen = true;

                                            value.gotoChatScreen(
                                              context,
                                              value.filterList[index]['Email'],
                                              value.filterList[index]['Email'],
                                              value.filterList[index]
                                                  ['userImage'],
                                              value.filterList[index]['name'],
                                            );
                                          }
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
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            height: 80,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: ColorRes.lgrey,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    ClipOval(
                                                      child: CachedNetworkImage(
                                                          imageUrl:
                                                              value.filterList[
                                                                          index]
                                                                      [
                                                                      'userImage'] ??
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
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                                'assets/images/image_placeholder.png',
                                                                height: 60,
                                                                width: 60,
                                                                fit:
                                                                    BoxFit.fill,
                                                              )),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                value.filterList[
                                                                            index]
                                                                            [
                                                                            'name']
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15),
                                                          child: SizedBox(
                                                            child: Text(
                                                              value.filterList[
                                                                          index]
                                                                      [
                                                                      'LastMsg'] ??
                                                                  '',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      child: Text(
                                                        value.filterList[index][
                                                                'LastMsgTime'] ??
                                                            '',
                                                        style:
                                                            mulishbold.copyWith(
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
                            ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: entitlementID,
                  builder: (context, entitlementIDValue, child) {
                    return entitlementIDValue == "" ||
                            entitlementIDValue.isEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black.withOpacity(0.5),
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                              ),
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Confirm your Subscription',
                                      style: popinsbold().copyWith(
                                          color: ColorRes.color5E5E5E,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          height: 3,
                                        ),
                                        itemCount: value.myProductList.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              selectedIndex = index;
                                              setState(() {});
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(7),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16, horizontal: 20),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: selectedIndex ==
                                                            index
                                                        ? ColorRes.appColor
                                                        : Colors.transparent),
                                                boxShadow:
                                                    selectedIndex == index
                                                        ? []
                                                        : [
                                                            BoxShadow(
                                                              color: CupertinoColors
                                                                  .systemGrey2
                                                                  .withOpacity(
                                                                0.5,
                                                              ),
                                                              blurRadius: 10,
                                                              spreadRadius: -5,
                                                            ),
                                                          ],
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  20,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        value
                                                            .myProductList[
                                                                index]
                                                            .storeProduct
                                                            .title
                                                            .toString()
                                                            .split('(')
                                                            .first,
                                                        style: poppins.copyWith(
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        value
                                                            .myProductList[
                                                                index]
                                                            .storeProduct
                                                            .priceString
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  selectedIndex == index
                                                      ? Icon(
                                                          Icons.check_circle,
                                                          color:
                                                              ColorRes.appColor,
                                                        )
                                                      : Container(
                                                          height: 22,
                                                          width: 22,
                                                          decoration: BoxDecoration(
                                                              color: ColorRes
                                                                  .colorE5E5E5,
                                                              shape: BoxShape
                                                                  .circle),
                                                        )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CommonGradientButton(
                                      ontap: () async {
                                        print(
                                            "packages[selectedIndex] ${value.myProductList[selectedIndex].storeProduct.introductoryPrice?.price}");
                                        print(
                                            "packages[selectedIndex] ${value.myProductList[selectedIndex].storeProduct.identifier}");
                                        print(
                                            "packages[selectedIndex] ${value.myProductList[selectedIndex].storeProduct.price}");
                                        print(
                                            "packages[selectedIndex] ${value.myProductList[selectedIndex].storeProduct.title}");
                                        print(
                                            "packages[selectedIndex] ${value.myProductList[selectedIndex].storeProduct.subscriptionPeriod}");
                                        int days = convertSubscriptionToDays(
                                            value
                                                    .myProductList[
                                                        selectedIndex]
                                                    .storeProduct
                                                    .subscriptionPeriod ??
                                                "0");

                                        print(
                                            "packages[selectedIndex] ${days}");
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                              content: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            );
                                          },
                                        );

                                        try {
                                          CustomerInfo customerInfo =
                                              await Purchases.purchasePackage(
                                                  value.myProductList[
                                                      selectedIndex]);

                                          NewChatProvider newChatProvider =
                                              Provider.of<NewChatProvider>(
                                                  context,
                                                  listen: false);
                                          await newChatProvider
                                              .membershipSubscribeApi({
                                            "planName": value
                                                .myProductList[selectedIndex]
                                                .storeProduct
                                                .identifier,
                                            "planPrice": value
                                                .myProductList[selectedIndex]
                                                .storeProduct
                                                .price,
                                            "planDuration": days,
                                            "blindDate": value
                                                        .myProductList[
                                                            selectedIndex]
                                                        .storeProduct
                                                        .identifier ==
                                                    "lovecirco_premium_v2:lovecirco-premium-v1"
                                                ? true
                                                : false,
                                            "userId": PrefService.getString(
                                                PrefKeys.userId)
                                          }, context);

                                          entitlementID.value = value
                                              .myProductList[selectedIndex]
                                              .storeProduct
                                              .identifier;
                                          print(
                                              "entitlementID ${entitlementID.value}");
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Purchase successful')));
                                          setState(() {});
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text('Purchase failed')));
                                        } finally {
                                          Navigator.pop(context);
                                        }

                                        // await PurchaseApis.purchasePackage(value.myProductList[selectedIndex]).then((value) async {
                                        //   if(value){
                                        //     NewChatProvider newChatProvider =
                                        //     Provider.of<NewChatProvider>(context, listen: false);
                                        //     await newChatProvider.membershipSubscribeApi(
                                        //         {
                                        //           "planName": value.myProductList[selectedIndex].storeProduct.title,
                                        //           "planPrice": value.myProductList[selectedIndex].storeProduct.price,
                                        //           "planDuration": days,
                                        //           "blindDate": value.myProductList[selectedIndex].storeProduct.identifier=="lovecirco_premium_v2:lovecirco-premium-v1"?true:false,
                                        //           "userId": PrefService.getString(PrefKeys.userId)
                                        //         }, context);
                                        //
                                        //     Provider.of<RevenueCatProvider>(context,listen: false).entitlement = Entitlement.allCourses;
                                        //     setState(() {
                                        //
                                        //     });
                                        //   }else{
                                        //     ScaffoldMessenger.of(context)
                                        //         .showSnackBar(SnackBar(content: Text('Something went wrong')));
                                        //   }
                                        // },);
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container();
                  },
                )

                // ValueListenableBuilder(
                //   valueListenable: entitlementID,
                //   builder: (context, entitlementIDValue, child) {
                //     return entitlementIDValue == "" ||
                //         entitlementIDValue.isEmpty
                //         ? Container(
                //       height: MediaQuery.of(context).size.height,
                //       width: MediaQuery.of(context).size.width,
                //       color: Colors.black.withOpacity(0.5),
                //       alignment: Alignment.bottomCenter,
                //       child: Container(
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(40),
                //             topRight: Radius.circular(40),
                //           ),
                //         ),
                //         height: MediaQuery.of(context).size.height / 2,
                //         width: MediaQuery.of(context).size.width,
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 20.0),
                //           child: Column(
                //             children: [
                //               SizedBox(
                //                 height: 20,
                //               ),
                //               Text(
                //                 'Confirm your Subscription',
                //                 style: popinsbold().copyWith(
                //                     color: ColorRes.color5E5E5E,
                //                     fontSize: 18),
                //               ),
                //               SizedBox(
                //                 height: 20,
                //               ),
                //               Expanded(
                //                 child: ListView.separated(
                //                   separatorBuilder: (context, index) =>
                //                       SizedBox(
                //                         height: 3,
                //                       ),
                //                   itemCount: value.myProductList.length,
                //                   itemBuilder: (context, index) {
                //                     return GestureDetector(
                //                       onTap: () {
                //                         selectedIndex = index;
                //                         setState(() {});
                //                       },
                //                       child: Container(
                //                         margin: EdgeInsets.all(7),
                //                         padding: EdgeInsets.symmetric(
                //                             vertical: 16, horizontal: 20),
                //                         decoration: BoxDecoration(
                //                           border: Border.all(
                //                               color: selectedIndex ==
                //                                   index
                //                                   ? ColorRes.appColor
                //                                   : Colors.transparent),
                //                           boxShadow:
                //                           selectedIndex == index
                //                               ? []
                //                               : [
                //                             BoxShadow(
                //                               color: CupertinoColors
                //                                   .systemGrey2
                //                                   .withOpacity(
                //                                 0.5,
                //                               ),
                //                               blurRadius: 10,
                //                               spreadRadius: -5,
                //                             ),
                //                           ],
                //                           color: Colors.white,
                //                           borderRadius:
                //                           BorderRadius.circular(
                //                             20,
                //                           ),
                //                         ),
                //                         child: Row(
                //                           children: [
                //                             Column(
                //                               crossAxisAlignment:
                //                               CrossAxisAlignment
                //                                   .start,
                //                               children: [
                //                                 Text(
                //                                   value
                //                                       .myProductList[
                //                                   index]
                //                                       .storeProduct
                //                                       .title
                //                                       .toString()
                //                                       .split('(')
                //                                       .first,
                //                                   style: poppins.copyWith(
                //                                       fontSize: 14),
                //                                 ),
                //                                 Text(
                //                                   value
                //                                       .myProductList[
                //                                   index]
                //                                       .storeProduct
                //                                       .priceString
                //                                       .toString(),
                //                                   style: TextStyle(
                //                                       fontSize: 12,
                //                                       fontWeight:
                //                                       FontWeight
                //                                           .w600),
                //                                 ),
                //                               ],
                //                             ),
                //                             Spacer(),
                //                             selectedIndex == index
                //                                 ? Icon(
                //                               Icons.check_circle,
                //                               color:
                //                               ColorRes.appColor,
                //                             )
                //                                 : Container(
                //                               height: 22,
                //                               width: 22,
                //                               decoration: BoxDecoration(
                //                                   color: ColorRes
                //                                       .colorE5E5E5,
                //                                   shape: BoxShape
                //                                       .circle),
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                     );
                //                   },
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               CommonGradientButton(
                //                 ontap: () async {
                //                   print(
                //                       "packages[selectedIndex] ${value.myProductList[selectedIndex].storeProduct.introductoryPrice?.price}");
                //                   print(
                //                       "packages[selectedIndex] ${value.myProductList[selectedIndex].storeProduct.identifier}");
                //                   print(
                //                       "packages[selectedIndex] ${value.myProductList[selectedIndex].storeProduct.price}");
                //                   print(
                //                       "packages[selectedIndex] ${value.myProductList[selectedIndex].storeProduct.title}");
                //                   print(
                //                       "packages[selectedIndex] ${value.myProductList[selectedIndex].storeProduct.subscriptionPeriod}");
                //                   int days = convertSubscriptionToDays(
                //                       value
                //                           .myProductList[
                //                       selectedIndex]
                //                           .storeProduct
                //                           .subscriptionPeriod ??
                //                           "0");
                //
                //                   print(
                //                       "packages[selectedIndex] ${days}");
                //                   showDialog(
                //                     context: context,
                //                     builder: (context) {
                //                       return AlertDialog(
                //                         backgroundColor:
                //                         Colors.transparent,
                //                         elevation: 0,
                //                         content: Center(
                //                             child:
                //                             CircularProgressIndicator()),
                //                       );
                //                     },
                //                   );
                //
                //                   try {
                //                     CustomerInfo customerInfo =
                //                     await Purchases.purchasePackage(
                //                         value.myProductList[
                //                         selectedIndex]);
                //
                //                     NewChatProvider newChatProvider =
                //                     Provider.of<NewChatProvider>(
                //                         context,
                //                         listen: false);
                //                     await newChatProvider
                //                         .membershipSubscribeApi({
                //                       "planName": value
                //                           .myProductList[selectedIndex]
                //                           .storeProduct
                //                           .identifier,
                //                       "planPrice": value
                //                           .myProductList[selectedIndex]
                //                           .storeProduct
                //                           .price,
                //                       "planDuration": days,
                //                       "blindDate": value
                //                           .myProductList[
                //                       selectedIndex]
                //                           .storeProduct
                //                           .identifier ==
                //                           "lovecirco_premium_v2:lovecirco-premium-v1"
                //                           ? true
                //                           : false,
                //                       "userId": PrefService.getString(
                //                           PrefKeys.userId)
                //                     }, context);
                //
                //                     entitlementID.value = value
                //                         .myProductList[selectedIndex]
                //                         .storeProduct
                //                         .identifier;
                //                     print(
                //                         "entitlementID ${entitlementID.value}");
                //                     ScaffoldMessenger.of(context)
                //                         .showSnackBar(SnackBar(
                //                         content: Text(
                //                             'Purchase successful')));
                //                     setState(() {});
                //                   } catch (e) {
                //                     ScaffoldMessenger.of(context)
                //                         .showSnackBar(SnackBar(
                //                         content:
                //                         Text('Purchase failed')));
                //                   } finally {
                //                     Navigator.pop(context);
                //                   }
                //
                //                   // await PurchaseApis.purchasePackage(value.myProductList[selectedIndex]).then((value) async {
                //                   //   if(value){
                //                   //     NewChatProvider newChatProvider =
                //                   //     Provider.of<NewChatProvider>(context, listen: false);
                //                   //     await newChatProvider.membershipSubscribeApi(
                //                   //         {
                //                   //           "planName": value.myProductList[selectedIndex].storeProduct.title,
                //                   //           "planPrice": value.myProductList[selectedIndex].storeProduct.price,
                //                   //           "planDuration": days,
                //                   //           "blindDate": value.myProductList[selectedIndex].storeProduct.identifier=="lovecirco_premium_v2:lovecirco-premium-v1"?true:false,
                //                   //           "userId": PrefService.getString(PrefKeys.userId)
                //                   //         }, context);
                //                   //
                //                   //     Provider.of<RevenueCatProvider>(context,listen: false).entitlement = Entitlement.allCourses;
                //                   //     setState(() {
                //                   //
                //                   //     });
                //                   //   }else{
                //                   //     ScaffoldMessenger.of(context)
                //                   //         .showSnackBar(SnackBar(content: Text('Something went wrong')));
                //                   //   }
                //                   // },);
                //                 },
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     )
                //         : Container();
                //   },
                // )
              ],
            ),
            loader == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        ),
      );
    });
  }

  int convertSubscriptionToDays(String subscriptionPeriod) {
    int numberOfUnits = int.parse(
        subscriptionPeriod.substring(1, subscriptionPeriod.length - 1));
    String unit = subscriptionPeriod.substring(subscriptionPeriod.length - 1);

    switch (unit) {
      case 'D':
        return numberOfUnits;
      case 'W':
        return numberOfUnits * 7;
      case 'M':
        // Assume 30 days in a month for simplicity (adjust as necessary)
        return numberOfUnits * 30;
      default:
        return 0; // Handle unsupported units if necessary
    }
  }
}
