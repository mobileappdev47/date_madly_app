
import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/chat/chat_message.dart';
import 'package:date_madly_app/pages/chat/new_provider.dart';
import 'package:date_madly_app/utils/font_family.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class Call extends StatefulWidget {
  Call({super.key, required this.callerName, required this.photo,required this.otherUid});
  final String callerName;
  final String photo;
  final String otherUid;
  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  // late RtcEngine _engine;
  late RtcEngine agoraCallEngine;

bool muted = false ;
bool speaker = false ;

  @override
  void initState() {
    final chatProvider = Provider.of<NewChatProvider>(context,listen: false);

    setupVoiceSDKEngine(chatProvider);

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    agoraCallEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchSpeaker() async {
    if (speaker) {
      agoraCallEngine.setEnableSpeakerphone(false);
      setState(() {
        speaker = false;
      });
    } else {
      agoraCallEngine.setEnableSpeakerphone(true);
      setState(() {
        speaker = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        await deleteCollection(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorRes.white,
          leading: GestureDetector(
              onTap: () async {
                await deleteCollection(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ColorRes.grey,
              )),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("calls")
              .where("receiverId", isEqualTo: widget.otherUid ?? "")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(child: CircularProgressIndicator());
            // }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await agoraCallEngine.leaveChannel();
                await agoraCallEngine.release();
                Navigator.pop(context);
              });
              return Container();
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

              Map<String, dynamic>data = snapshot.data!.docs[0].data() as Map<String, dynamic>;

            return Column(
                children: [
                  SizedBox(
                    height: 90,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipOval(
                        child: Image.network(
                          widget.photo,
                          height: 120,
                          width: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, right: 5),
                        child: CircleAvatar(
                          radius: 11,
                          backgroundColor: ColorRes.white,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: ColorRes.green,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.callerName,
                    style: TextStyle(
                        color: ColorRes.darkGrey,
                        fontSize: 28,
                        fontFamily: Fonts.mulishBold,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Consumer<NewChatProvider>(

                    builder: (BuildContext context, value, Widget? child) {
                    return Text(
                        data['status'] == "calling" ? 'Calling .......' : "${value.formattedTime}",
                        style: TextStyle(
                            color: ColorRes.darkGrey,
                            fontSize: 13,
                            fontFamily: Fonts.mulishRegular,
                            fontWeight: FontWeight.w400));
                    },

                  ),
                  SizedBox(
                    height: 170,
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap:() {
                              _onSwitchSpeaker();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(80),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: ColorRes.white,
                                child: speaker== true ?Icon(Icons.volume_up,color: ColorRes.grey,):Icon(Icons.volume_off,color: ColorRes.grey,),

                              ),
                            ),
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(80),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey.withOpacity(0.5),
                          //         spreadRadius: 1,
                          //         blurRadius: 2,
                          //         offset: Offset(
                          //             0, 3), // changes position of shadow
                          //       ),
                          //     ],
                          //   ),
                          //   child: CircleAvatar(
                          //     radius: 30,
                          //     backgroundColor: ColorRes.white,
                          //     child: Image.asset('assets/icons/Video Call.png',
                          //         scale: 4),
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () async {
                              // leave(context);
                              await deleteCollection(context);
                            },
                            child: Container(
                              height: 80,
                              width: 80,
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
                              child: Image.asset('assets/icons/Call_hangUp.png',
                                  scale: 3.5),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _onToggleMute();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(80),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: ColorRes.white,
                                child: muted== true ?Icon(Icons.mic_off,color: ColorRes.grey,):Icon(Icons.mic,color: ColorRes.grey,),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );

          },
        ),
      ),
    );
  }

  Future<void> deleteCollection(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Navigator.pop(context);

    QuerySnapshot querySnapshot = await firestore
        .collection('calls')
        .where("receiverId", isEqualTo: widget.otherUid ?? "")
        .get();
    String id = querySnapshot.docs.first.id;
    await firestore.collection('calls').doc(id).delete();
    await agoraCallEngine.leaveChannel();
    await agoraCallEngine.release();
  }
  Future<void> setupVoiceSDKEngine(NewChatProvider chatProvider) async {
    // retrieve or request microphone permission


    await Permission.microphone.request();

    agoraCallEngine = createAgoraRtcEngine();
    await agoraCallEngine.initialize(const RtcEngineContext(
        appId: 'd47f99c3a3ff4c639a78ae664d4df40b'
    ));

    agoraCallEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage("Local user uid:${connection.localUid} joined the channel");
          // _isJoined = true;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          chatProvider.startTimer();
          // setState(() {
          //   _remoteUid = remoteUid;
          // });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          // setState(() {
          //   _remoteUid = null;
          // });
          chatProvider.stopTimer();

        },
        onConnectionLost: (connection) {
          chatProvider.stopTimer();
          print('conection lost......66.....66....66........66......66....8877');
        },
        onLeaveChannel: (connection, stats) {
          print('Chanel leave----***----****------***--------***--------');
          chatProvider.stopTimer();
        },
      ),
    );
    await join(reciverId:widget.otherUid);
  }

  Future<void>  join({required String reciverId})
async {

  ChannelMediaOptions options = const ChannelMediaOptions(
    clientRoleType: ClientRoleType.clientRoleBroadcaster,
    channelProfile: ChannelProfileType.channelProfileCommunication,
  );

  await agoraCallEngine.joinChannel(
    token: token,
    channelId: channelName,
    options: options,
    uid: uid,
  );
}
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey   = GlobalKey<ScaffoldMessengerState>();

  showMessage(String message) {

    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));

  }


}

List icons = [
  'assets/icons/Speaker.png',
  'assets/icons/Video Call.png',
  'assets/icons/Turn Off Voice.png'
];
