import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/chat/new_provider.dart';
import 'package:date_madly_app/pages/chat/video_call_screen.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// import 'package:timeago/timeago.dart' as timeago;
import '../../common/text_style.dart';
import '../../utils/colors.dart';
import '../../utils/texts.dart';
import 'call.dart';




String channelName = '';
String token = "";

int uid = 0;

int? _remoteUid;
bool _isJoined = false;
late RtcEngine agoraEngine;

Future<void>  join({required String reciverId})
async {

  ChannelMediaOptions options = const ChannelMediaOptions(
    clientRoleType: ClientRoleType.clientRoleBroadcaster,
    channelProfile: ChannelProfileType.channelProfileCommunication,
  );

  await agoraEngine.joinChannel(
    token: token,
    channelId: channelName,
    options: options,
    uid: uid,
  );
}

Future<void> leave(BuildContext context) async {

    _isJoined = false;
    _remoteUid = null;
   agoraEngine.leaveChannel();
    // await deleteCollection(context);

  // Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => HomeMain() ),(route) => false,);

}

// deleteCallCollection() async {
//
//   await FirebaseFirestore.instance.collection('calls').doc(channelName).delete();
//
// }
class ChatScreen extends StatefulWidget {
  final String? email;
  final String? roomId;
  final String? otherUid;
  final String? userEmail;
  final String? image;
  final String? name;

  ChatScreen(
      {Key? key,
      this.email,
      this.userEmail,
      this.otherUid,
      this.roomId,
      this.image, this.name})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController searchController = TextEditingController();



  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey
  = GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {

    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));

  }


  @override
  void initState() {
    super.initState();
    setupVoiceSDKEngine();
  }

  void initiateCall(
      {required String callerId,required String receiverId,required String  channelName}) async {

  await  FirebaseFirestore.instance
        .collection('calls').doc(channelName).get().then((value) async {
          print('-----------------------------------888888888888888888888888888888${value.data()}');
          await FirebaseFirestore.instance.collection('calls').add({
            'callerId': PrefService.getString(PrefKeys.userId),
            'receiverId': receiverId,
            'channelId': channelName,
            'timestamp': FieldValue.serverTimestamp(),
            'status': 'calling',
            'active': true,
          }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => Call(callerName: widget.name!,photo: widget.image!),)));
  });


  }
  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await Permission.microphone.request();

    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(
        appId: 'd47f99c3a3ff4c639a78ae664d4df40b'
    ));

    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage("Local user uid:${connection.localUid} joined the channel");
            _isJoined = true;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onConnectionLost: (connection) {
          print('conection lost......66.....66....66........66......66....8877');
        },
        onLeaveChannel: (connection, stats) {
          print('Chanel leave----***----****------***--------***--------');
        },
      ),
    );
  }
  String userEmail = PrefService.getString(PrefKeys.email).toString();
  bool isOnce = false;
  @override

  Widget build(BuildContext context) {
    print(userEmail);
    print(widget.otherUid);


    return
      Consumer<NewChatProvider>(
      builder: (context, value, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ColorRes.lgrey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white, // AppBar background color
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    // Remove the shadow
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: ColorRes.grey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Row(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                              imageUrl: widget.image ?? '',
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
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name ??
                                    '',
                                style: mulishbold.copyWith(
                                    fontSize: 20,
                                    color: ColorRes.darkGrey,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    actions: [
                      GestureDetector(
                          onTap: () async{

                           channelName = widget.roomId??"";
                              await join(reciverId:widget.otherUid ??"");
                           await addCollectionAndNavigateToCallScreen(reciverId: widget.otherUid ??"");

                          },
                          child: Image.asset(
                            'assets/icons/Call.png',
                            scale: 3,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoCallScreen(),
                                ),);
                          },
                          child: Image.asset(
                            'assets/icons/Video Call.png',
                            scale: 3,
                          ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [

              Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("chats")
                          .doc(widget.roomId)
                          .collection(widget.roomId!)
                          .orderBy("time", descending: true)
                          .limit(1000)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const SizedBox();
                          default:
                            List<DocumentSnapshot> documents = snapshot.data!.docs;
                            return ListView.builder(
                              controller: value.listScrollController,
                              reverse: true,
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                // Check for the end of the list to load more
                                if (index >= documents.length - 1) {
                                  // Load more items
                                }
                                Map<String, dynamic>? data = documents[index].data()
                                    as Map<String, dynamic>?;
                                if (data == null) {
                                  return const SizedBox();
                                } else {
                                  if (data['read'] != true &&
                                      data['senderUid'].toString() !=
                                          widget.email) {
                                    value.setReadTrue(
                                      documents[index].id,
                                    );
                                    // setState(() {});
                                  }

                                  return documents[index]["senderUid"] != userEmail
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  documents[index]["type"] ==
                                                          "image"
                                                      ? GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) => Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 20, vertical: 80),
                                                          child: Container(
                                                            height: MediaQuery.of(context).size.height,
                                                            width: MediaQuery.of(context).size.width - 40,
                                                            child: Stack(
                                                              alignment: Alignment.topRight,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius: BorderRadius.circular(8),
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: documents[index]
                                                                    ["content"],
                                                                    height: MediaQuery.of(context)
                                                                        .size
                                                                        .height,
                                                                    width: MediaQuery.of(context)
                                                                        .size
                                                                        .width -
                                                                        40,
                                                                    fit: BoxFit.fill,
                                                                    placeholder: (context, url) =>
                                                                        Image.asset(
                                                                          'assets/images/image_placeholder.png',
                                                                          // height: MediaQuery.of(context).size.width - 150,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                              40,
                                                                          height: MediaQuery.of(context)
                                                                              .size
                                                                              .height,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                    errorWidget: (context, url, error) =>
                                                                        Image.asset(
                                                                          'assets/images/image_placeholder.png',
                                                                          // height: MediaQuery.of(context).size.width - 150,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                              40,
                                                                          height: MediaQuery.of(context)
                                                                              .size
                                                                              .height,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pop(context);

                                                                  },
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        right: 10, top: 10),
                                                                    child: Container(
                                                                      height: 40,
                                                                      width: 40,
                                                                      decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        color: ColorRes.appColor,
                                                                      ),
                                                                      child: Icon(
                                                                        Icons.close,
                                                                        color: ColorRes.white,
                                                                        size: 16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                        child: Container(
                                                            height: 150,
                                                            width: 150,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(15),
                                                            ),
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            child: CachedNetworkImage(
                                                                imageUrl:
                                                                    documents[index]
                                                                        ["content"],
                                                                fit: BoxFit.fill,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Image.asset(
                                                                        'assets/images/image_placeholder.png'),
                                                                errorWidget: (context,
                                                                        url, error) =>
                                                                    Image.asset(
                                                                        'assets/images/image_placeholder.png')),
                                                          ),
                                                      )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  right: 0,
                                                                  left: 20),
                                                          child: Container(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                IntrinsicWidth(
                                                                  child: Container(
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                      horizontal: MediaQuery.of(
                                                                                  context)
                                                                              .size
                                                                              .width *
                                                                          0.05,
                                                                      vertical: MediaQuery.of(
                                                                                  context)
                                                                              .size
                                                                              .width *
                                                                          0.03,
                                                                    ),
                                                                    margin:
                                                                        const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorRes
                                                                          .white,
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight:
                                                                              Radius.circular(
                                                                                  20),
                                                                          bottomLeft:
                                                                              Radius.circular(
                                                                                  20),
                                                                          bottomRight:
                                                                              Radius.circular(
                                                                                  20)),
                                                                    ),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    constraints:
                                                                        BoxConstraints(
                                                                      maxWidth: MediaQuery.of(
                                                                                  context)
                                                                              .size
                                                                              .width /
                                                                          1.5,
                                                                    ),
                                                                    child: SizedBox(
                                                                      child: Text(
                                                                        documents[
                                                                                index]
                                                                            [
                                                                            "content"],
                                                                        style: mulishbold
                                                                            .copyWith(
                                                                          fontSize:
                                                                              12,
                                                                          color: ColorRes
                                                                              .black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    DateFormat("hh:mm aa").format(
                                                        (documents[index]["time"]
                                                            .toDate())),
                                                    style: const TextStyle(
                                                        color: ColorRes.black,
                                                        fontSize: 8),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  documents[index]["type"] ==
                                                          "image"
                                                      ? GestureDetector(


                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) => Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 20, vertical: 80),
                                                          child: Container(
                                                            height: MediaQuery.of(context).size.height,
                                                            width: MediaQuery.of(context).size.width - 40,
                                                            child: Stack(
                                                              alignment: Alignment.topRight,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius: BorderRadius.circular(8),
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: documents[index]
                                                                    ["content"],
                                                                    height: MediaQuery.of(context)
                                                                        .size
                                                                        .height,
                                                                    width: MediaQuery.of(context)
                                                                        .size
                                                                        .width -
                                                                        40,
                                                                    fit: BoxFit.fill,
                                                                    placeholder: (context, url) =>
                                                                        Image.asset(
                                                                          'assets/images/image_placeholder.png',
                                                                          // height: MediaQuery.of(context).size.width - 150,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                              40,
                                                                          height: MediaQuery.of(context)
                                                                              .size
                                                                              .height,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                    errorWidget: (context, url, error) =>
                                                                        Image.asset(
                                                                          'assets/images/image_placeholder.png',
                                                                          // height: MediaQuery.of(context).size.width - 150,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                              40,
                                                                          height: MediaQuery.of(context)
                                                                              .size
                                                                              .height,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pop(context);


                                                                  },
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(
                                                                        right: 10, top: 10),
                                                                    child: Container(
                                                                      height: 40,
                                                                      width: 40,
                                                                      decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        color: ColorRes.appColor,
                                                                      ),
                                                                      child: Icon(
                                                                        Icons.close,
                                                                        color: ColorRes.white,
                                                                        size: 16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },

                                                    child: Container(
                                                            height: 150,
                                                            width: 150,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(15),
                                                            ),
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            child: CachedNetworkImage(
                                                                imageUrl:
                                                                    documents[index]
                                                                        ["content"],
                                                                fit: BoxFit.fill,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Image.asset(
                                                                        'assets/images/image_placeholder.png'),
                                                                errorWidget: (context,
                                                                        url, error) =>
                                                                    Image.asset(
                                                                        'assets/images/image_placeholder.png')),
                                                          ),
                                                      )
                                                      : Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              IntrinsicWidth(
                                                                child: Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              5),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: ColorRes
                                                                        .appColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                10),
                                                                  ),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  constraints:
                                                                      BoxConstraints(
                                                                    maxWidth: MediaQuery.of(
                                                                                context)
                                                                            .size
                                                                            .width /
                                                                        1.5,
                                                                  ),
                                                                  child:
                                                                      CustomPaint(
                                                                    painter:
                                                                        ChatBubblePainter(),
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .all(
                                                                                  10.0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: ColorRes
                                                                            .colorFF9BAD,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10.0),
                                                                      ),
                                                                      child: Text(
                                                                        documents[
                                                                                index]
                                                                            [
                                                                            "content"],
                                                                        style: mulish14400
                                                                            .copyWith(
                                                                          fontSize:
                                                                              12,
                                                                          color: ColorRes
                                                                              .white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 15,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      DateFormat("hh:mm aa").format(
                                                          documents[index]["time"]
                                                              .toDate()),
                                                      style: const TextStyle(
                                                          color: ColorRes.black,
                                                          fontSize: 8),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                        );
                                }
                              },
                            );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: value.msController,
                              // keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.only(top: 10),
                                fillColor: ColorRes.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                hintText: Strings.write_a_message,
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 13.0),
                                  child: Image.asset(
                                    AssertRe.Emoticon,
                                    color: ColorRes.grey,
                                    scale: 3,
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    value.pickImage(context, value.roomId);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 13.0),
                                    child: Image.asset(
                                      AssertRe.Camera2,
                                      color: ColorRes.grey,
                                      scale: 3,
                                    ),
                                  ),
                                ),
                              ),

                              onTap: () {},
                              onChanged: ((value) => {print(value)}),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                            if (value.msController.text.isNotEmpty) {
                              value.sendMessage(
                                widget.roomId.toString(),
                                widget.otherUid,
                              );

                              FocusScope.of(context).unfocus();

                              final FirebaseFirestore fireStore =
                                  FirebaseFirestore.instance;
                              fireStore.collection("Auth").get().then((value) async {
                                var list = (value.docs);
                                bool already = false;

                                for (int i = 0; i < list.length; i++) {
                                  if (list[i].id == widget.otherUid) {
                                    print('collection already exist');
                                    already = true;
                                    break;
                                  } else {}
                                }

                                if (already == false) {
                                  await fireStore
                                      .collection("Auth")
                                      .doc(widget.otherUid)
                                      .set({'ChatUserList': []});
                                } else {
                                  print('done');
                                }
                              });
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
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
                            ),
                            child: Image.asset(
                              AssertRe.Send,
                              scale: 4,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),

            ],
          ),
        );
      },
    );

  }



  Future<void> addCollectionAndNavigateToCallScreen({required String reciverId}) async{

    await FirebaseFirestore.instance.collection('calls').add({
      'callerId': PrefService.getString(PrefKeys.userId),
      'receiverId': reciverId,
      'channelId': channelName,
      'image':widget.image ?? "",
      'name':widget.name ?? "",
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'calling',
      'active': true,
    });

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Call(callerName: widget.name ?? "",photo: widget.image ?? ""),
        ));

  }

}

class ChatBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.colorFF9BAD
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width - 60, size.height - 20);
    path.lineTo(size.width, size.height - 10);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


