import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/chat/chat_message.dart';
import 'package:date_madly_app/pages/chat/new_provider.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/font_family.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class Call extends StatefulWidget {
  Call(
      {super.key,
      required this.callerName,
      required this.photo,
      required this.otherUid,
      required this.isVideoCall});
  final String callerName;
  final String photo;
  final String otherUid;
  final bool isVideoCall;
  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  // late RtcEngine _engine;
  late RtcEngine agoraCallEngine;

  bool muted = false;
  bool speaker = false;
  bool isCamera = true;
  int? _remoteUid;
  bool _localUserJoined = false;
  String token = "";
  AgoraClient client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
          appId: "d47f99c3a3ff4c639a78ae664d4df40b", channelName: channelName));

  @override
  void initState() {
    final chatProvider = Provider.of<NewChatProvider>(context, listen: false);

    if (widget.isVideoCall == true) {
      initAgora();
    } else {
      setupVoiceSDKEngine(chatProvider);
    }
    super.initState();
  }

  @override
  void dispose() {
    agoraCallEngine.leaveChannel();
    agoraCallEngine.release();
    client.engine.leaveChannel();
    client.engine.release();
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
  void _onSwitchCamera() {
    agoraCallEngine.switchCamera();
  }

  void _toggleLocalCamera() async {


    if (isCamera) {
      await agoraCallEngine.enableLocalVideo(false);
      setState(() {
        isCamera = false;
      });
    } else {
      await agoraCallEngine.enableLocalVideo(true);
      setState(() {
        isCamera = true;
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
                await client.engine.leaveChannel();
                await client.engine.release();
                Navigator.pop(context);
              });
              return Container();
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            Map<String, dynamic> data =
                snapshot.data!.docs[0].data() as Map<String, dynamic>;

            if (data['isVideoCall'] == true && data['status'] == 'accepted') {


              debugPrint("-=-=-=-=-=-=-=-=-:   ${data['isVideoCall'] == true && data['status'] == 'accepted'}");
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                    child: _remoteVideo(PrefService.getString(PrefKeys.userName)),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 100,
                      height: 150,
                      child: Center(
                        child: _localUserJoined
                            ? AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine: agoraCallEngine,
                                  canvas: const VideoCanvas(uid: 0),
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
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
                              radius: 25,
                              backgroundColor: ColorRes.white,
                              child: speaker == true ?
                              Icon(Icons.volume_up,color: ColorRes.grey,):Icon(Icons.volume_off,color: ColorRes.grey,),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _onSwitchCamera();
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
                              radius: 25,
                              backgroundColor: ColorRes.white,
                              child:
                              Icon(Icons.cameraswitch_rounded,color: ColorRes.grey,),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            await deleteCollection(context);
                          },
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xffED1E79),
                                  Color(0xffC1272D),
                                ],
                              ),
                            ),
                            child: Image.asset('assets/icons/Call_hangUp.png', scale: 3.5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _toggleLocalCamera();
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
                              radius: 25,
                              backgroundColor: ColorRes.white,
                              child:isCamera == true?
                              Icon(Icons.camera_alt,color: ColorRes.grey,): Icon(Icons.not_interested),
                            ),
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
                              radius: 25,
                              backgroundColor: ColorRes.white,
                              child: muted== true ?Icon(Icons.mic_off,color: ColorRes.grey,):Icon(Icons.mic,color: ColorRes.grey,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // AgoraVideoButtons(
                  //   client: client,
                  //   addScreenSharing: false,
                  //   onDisconnect: () async{
                  //     await deleteCollection(context);
                  //   },
                  // ),
                ],
              );
            } else {
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
                          data['status'] == "calling"
                              ? 'Calling .......'
                              : "${value.formattedTime}",
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
                            onTap: () {
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
                                child: speaker == true
                                    ? Icon(
                                        Icons.volume_up,
                                        color: ColorRes.grey,
                                      )
                                    : Icon(
                                        Icons.volume_off,
                                        color: ColorRes.grey,
                                      ),
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
                                child: muted == true
                                    ? Icon(
                                        Icons.mic_off,
                                        color: ColorRes.grey,
                                      )
                                    : Icon(
                                        Icons.mic,
                                        color: ColorRes.grey,
                                      ),
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
            }
          },
        ),
      ),
    );
  }

  Widget _remoteVideo(String name) {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraCallEngine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: channelName),
        ),
      );
    } else {
      return  Text(
        'Please wait....',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    agoraCallEngine = createAgoraRtcEngine();
    await agoraCallEngine.initialize(const RtcEngineContext(
      appId: 'd47f99c3a3ff4c639a78ae664d4df40b',
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    agoraCallEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await agoraCallEngine.setClientRole(
        role: ClientRoleType.clientRoleBroadcaster);
    await agoraCallEngine.enableVideo();
    await agoraCallEngine.startPreview();

    await agoraCallEngine.joinChannel(
      token: token,
      channelId: channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }


  void initAgoraView() async {
    await client.initialize();
  }

  Future<void> deleteCollection(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    agoraCallEngine.leaveChannel();
    agoraCallEngine.release();
    client.engine.leaveChannel();
    client.engine.release();
    Navigator.pop(context);

    QuerySnapshot querySnapshot = await firestore
        .collection('calls')
        .where("receiverId", isEqualTo: widget.otherUid ?? "")
        .get();
    String id = querySnapshot.docs.first.id;
    await firestore.collection('calls').doc(id).delete();

  }

  Future<void> setupVoiceSDKEngine(NewChatProvider chatProvider) async {
    // retrieve or request microphone permission

    await Permission.microphone.request();

    agoraCallEngine = createAgoraRtcEngine();
    await agoraCallEngine.initialize(
        const RtcEngineContext(appId: 'd47f99c3a3ff4c639a78ae664d4df40b'));

    agoraCallEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage("Local user uid:${connection.localUid} joined the channel");
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          chatProvider.startTimer();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          chatProvider.stopTimer();
        },
        onConnectionLost: (connection) {
          chatProvider.stopTimer();
        },
        onLeaveChannel: (connection, stats) {
          chatProvider.stopTimer();
        },
      ),
    );
    await join(reciverId: widget.otherUid);
  }

  Future<void> join({required String reciverId}) async {
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

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

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
