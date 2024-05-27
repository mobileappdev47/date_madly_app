import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/chat/chat_message.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/font_family.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PickUpScreen extends StatefulWidget {
  PickUpScreen({super.key,required this.photo, required this.callerName, required this.channelId});
  final String channelId;
  final String photo;
  final String callerName;

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  late final RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    setupVoiceSDKEngine();
  }


  Future<void> setupVoiceSDKEngine() async {
    await Permission.microphone.request();

    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(
        appId: 'd47f99c3a3ff4c639a78ae664d4df40b'

    ));

    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(

        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print("Local user uid:${connection.localUid} joined the channel");
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print("Remote user uid:$remoteUid joined the channel");

        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          print("Remote user uid:$remoteUid left the channel");
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    isCutYou  ?
                    null :
                    Navigator.pop(context) ;
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
                      Text(data['status'] == "calling" ?
                      'Incoming Call.......' : "00:00",
                          style: TextStyle(
                              color: ColorRes.darkGrey,
                              fontSize: 12,
                              fontFamily: Fonts.mulishRegular,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 170,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async{
                              await join();
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
                      ),

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


    await agoraEngine.joinChannel(
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
    agoraEngine.leaveChannel();
  }
}
