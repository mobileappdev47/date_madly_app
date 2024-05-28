import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/calling/video_call.dart';
import 'package:date_madly_app/pages/chat/chat_message.dart';
import 'package:date_madly_app/pages/chat/new_provider.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/font_family.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PickUpScreen extends StatefulWidget {
  PickUpScreen({super.key,required this.photo, required this.callerName, required this.channelId});
  final String channelId;
  final String photo;
  final String callerName;

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  late  RtcEngine agoraCallEngine;
  bool muted = false ;
  bool speaker = false;
  @override
  void initState() {
    super.initState();
    final chatProvider = Provider.of<NewChatProvider>(context,listen: false);

    setupVoiceSDKEngine(chatProvider);
  }


  Future<void> setupVoiceSDKEngine(NewChatProvider chatProvider) async {
    await Permission.microphone.request();

    agoraCallEngine = createAgoraRtcEngine();
    await agoraCallEngine.initialize(const RtcEngineContext(
        appId: 'd47f99c3a3ff4c639a78ae664d4df40b'

    ));

    agoraCallEngine.registerEventHandler(
      RtcEngineEventHandler(

        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print("Local user uid:${connection.localUid} joined the channel");
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print("Remote user uid:$remoteUid joined the channel");
          chatProvider.startTimer();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          chatProvider.stopTimer();
          print("Remote user uid:$remoteUid left the channel");
        },
        onConnectionLost: (connection) {
          print('conection lost......66.....66....66........66......66....8877');
          chatProvider.stopTimer();
        },
        onLeaveChannel: (connection, stats) {
          print('Chanel leave----***----****------***--------***--------');
          chatProvider.stopTimer();
        },

      ),
    );
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

      return
        WillPopScope(
          onWillPop: () async{
            await leave(context);
            return false;
          },
          child: Scaffold(
            backgroundColor: ColorRes.white,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: ColorRes.white,
              leading: GestureDetector(
                  onTap: () async{
                    await leave(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorRes.grey,
                  )),

            ),
            body: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('calls').where("channelId",isEqualTo: widget.channelId).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    // isCutYou  ? null : Navigator.pop(context) ;
                    // isCutYou  ? null : Navigator.pop(context) ;
                    await agoraCallEngine.leaveChannel();
                    await agoraCallEngine.release();
                    isCutYou  ? null : Navigator.pop(context) ;
                  });
                  return Container(
                    child: Center(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                  Map<String,dynamic> data = snapshot.data!.docs[0].data() as Map<String,dynamic>;
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
                              data['image'],
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
                        data['name'],
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
                              data['status'] == "calling" ? 'Incoming Call.......' : "${value.formattedTime}",
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
                      data['status'] == "calling"?   Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async{

                              if(data['isVideoCall']== true ){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>     VideoCallSmit(channel: data['channelId']),));
                              }
                              else {
                                await join();
                              }

                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                color: Colors.green,

                              ),
                              child: Image.asset('assets/icons/Call.png', scale: 3.5),
                            ),
                          ),
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: () async{
                              await leave(context);
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
                                    Color(0xffED1E79,),
                                    Color(0xffC1272D,),
                                  ],
                                ),
                              ),
                              child: Image.asset('assets/icons/Call_hangUp.png', scale: 3.5),
                            ),
                          ),
                        ],
                      ) :SizedBox(),
                      data['status'] == "calling"? SizedBox() : Padding(
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
                                  child: speaker== true ?Icon(Icons.volume_up,color: ColorRes.grey,):Icon(Icons.volume_off,color: ColorRes.grey,),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async{
                                await leave(context);
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
                                      Color(0xffED1E79,),
                                      Color(0xffC1272D,),
                                    ],
                                  ),
                                ),
                                child: Image.asset('assets/icons/Call_hangUp.png', scale: 3.5),
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
                      ) ,

                    ],
                  );
              },

            ),
          ),
        );


  }


  Future<void>  join() async {
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection('calls')
        .where("channelId", isEqualTo: widget.channelId)
        .get();
    String id = querySnapshot.docs.first.id;
    await firestore
        .collection('calls')
        .doc(id)
        .update({'status': 'accepted'});


    await agoraCallEngine.joinChannel(
      token: token,
      channelId: widget.channelId,
      options: options,
      uid: uid,
    );

  }


bool isCutYou = false;
  Future<void> leave(BuildContext context) async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    isCutYou = true;
    Navigator.pop(context);

    QuerySnapshot querySnapshot = await firestore
        .collection('calls')
        .where("channelId", isEqualTo: widget.channelId ?? "")
        .get();
    String id = querySnapshot.docs.first.id;
    await firestore
        .collection('calls')
        .doc(id)
        .delete();
    agoraCallEngine.leaveChannel();
    agoraCallEngine.release();
  }
}
