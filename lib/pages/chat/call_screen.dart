// import 'dart:async';
//
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// //import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:provider/provider.dart';
//
//
// class CallScreen extends StatefulWidget {
//   final Call call;
//
//   CallScreen({
//     required this.call,
//   });
//
//   @override
//   _CallScreenState createState() => _CallScreenState();
// }
//
// class _CallScreenState extends State<CallScreen> {
//   final CallMethods callMethods = CallMethods();
//   late RtcEngine _engine;
//   late UserProvider userProvider;
//   late StreamSubscription callStreamSubscription;
//   late StreamSubscription membersStreamSubscription;
//
//   List allJoinedMembers = [];
//
//   static final _users = <int>[];
//   final _infoStrings = <String>[];
//
//   List alreadyJoinedUser = [];
//
//   bool muted = false;
//
//   bool speaker = true;
//
//   int seconds = 0, minute = 0;
//   Timer? timer;
//   bool timerStart = false;
//
//   String timeString = "00:00";
//
//   List contactList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     addPostFrameCallback();
//     initializeAgora();
//     //getContacts();
//     joinedUserListPrepare();
//   }
//
//   joinedUserListPrepare() {
//     if (widget.call.isGroup) {
//       dynamic mem = widget.call.members ?? [];
//       if (mem.length > 0) {
//         alreadyJoinedUser.addAll(mem);
//       }
//     } else {
//       allJoinedMembers.add({
//         "id": widget.call.callerId,
//         "photo": widget.call.callerPic,
//         "name": widget.call.callerName
//       });
//       allJoinedMembers.add({
//         "id": widget.call.receiverId,
//         "photo": widget.call.receiverPic,
//         "name": widget.call.receiverName
//       });
//
//       alreadyJoinedUser.add(widget.call.callerId);
//       alreadyJoinedUser.add(widget.call.receiverId);
//     }
//   }
//
//   _callTimer(timer) {
//     seconds++;
//     if (seconds >= 60) {
//       minute++;
//       seconds = 0;
//     }
//     var time = "";
//     if (minute < 10) {
//       time += "0$minute:";
//     } else {
//       time += "$minute:";
//     }
//
//     if (seconds < 10) {
//       time += "0$seconds";
//     } else {
//       time += "$seconds";
//     }
//
//     setState(() {
//       timeString = time;
//     });
//   }
//
//   Future<void> initializeAgora() async {
//     if (APP_ID.isEmpty) {
//       setState(() {
//         _infoStrings.add(
//           'APP_ID missing, please provide your APP_ID in settings.dart',
//         );
//         _infoStrings.add('Agora Engine is not starting');
//       });
//       return;
//     }
//
//     await _initAgoraRtcEngine();
//     _addAgoraEventHandlers();
//     _engine.enableWebSdkInteroperability(true);
//     _engine.setParameters(
//         '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.enableVideo();
//     await _engine.startPreview();
//     await _engine.joinChannel(
//       token: "",
//       channelId: widget.call.channelId ?? "",
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//   }
//
//   addPostFrameCallback() {
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       userProvider = Provider.of<UserProvider>(context, listen: false);
//       getContacts();
//       callStreamSubscription = callMethods
//           .callStream(uid: userProvider.getUser.uid ?? "")
//           .listen((DocumentSnapshot ds) {
//         // defining the logic
//         var dataResult = ds.data();
//
//         switch (dataResult) {
//           case null:
//           // snapshot is null which means that call is hanged and documents are deleted
//             Navigator.pop(context);
//             break;
//
//           default:
//             break;
//         }
//       }
//       );
//
//       membersStreamSubscription = callMethods
//           .callStreamByChannelId(channel_id: widget.call.channelId ?? "")
//           .listen((QuerySnapshot qs) {
//         if (qs.docs.length == 1)
//           callMethods.endCallForAllByCallId(call: widget.call);
//
//         var temp = [];
//         var temp2 = [];
//         qs.docs.forEach((element) {
//           Call tmpCall = Call.fromMap(element.data() as Map<String, dynamic>);
//           if ((tmpCall.hasDialled ?? false) &&
//               tmpCall.callerId != userProvider.getUser.uid) {
//             temp.add({
//               "id": tmpCall.callerId,
//               "photo": tmpCall.callerPic,
//               "name": tmpCall.callerName
//             });
//             temp2.add(tmpCall.callerId);
//           } else if (!(tmpCall.hasDialled ?? false) &&
//               tmpCall.receiverId != userProvider.getUser.uid) {
//             temp.add({
//               "id": tmpCall.receiverId,
//               "photo": tmpCall.receiverPic,
//               "name": tmpCall.receiverName
//             });
//             temp2.add(tmpCall.receiverId);
//           }
//         });
//
//         setState(() {
//           allJoinedMembers = temp;
//           alreadyJoinedUser = temp2;
//         });
//
//         print("Total Users: " + qs.docs.length.toString());
//       });
//     });
//   }
//
//   /// Create agora sdk instance and initialize
//   Future<void> _initAgoraRtcEngine() async {
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(const RtcEngineContext(
//       appId: APP_ID,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));
//     //await AgoraRtcEngine.create(APP_ID);
//     // if (widget.call.voiceCall) {
//     //   await AgoraRtcEngine.disableVideo();
//     //   _onSwitchSpeaker();
//     // } else
//     //   await AgoraRtcEngine.enableVideo();
//   }
//
//   /// Add agora event handlers
//   void _addAgoraEventHandlers() {
//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//           setState(() {
//             final info =
//                 'onJoinChannel: ${connection.channelId}, uid: ${connection.localUid}';
//             _infoStrings.add(info);
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("remote user $remoteUid joined");
//           print('onUserJoined: $remoteUid');
//           if (!timerStart) {
//             timer = new Timer.periodic(Duration(seconds: 1), _callTimer);
//             setState(() {
//               timerStart = true;
//             });
//           }
//           setState(() {
//             final info = 'onUserJoined: $remoteUid';
//             _infoStrings.add(info);
//             _users.add(remoteUid);
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           debugPrint("remote user $remoteUid left channel");
//         },
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint(
//               '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//         onUserInfoUpdated: (uid, userinfo) {
//           setState(() {
//             final info = 'onUpdatedUserInfo: ${userinfo.toString()}';
//             _infoStrings.add(info);
//           });
//         },
//         onRejoinChannelSuccess: (connection, elapsed) {
//           setState(() {
//             final info = 'onRejoinChannelSuccess: ${connection.channelId}}';
//             _infoStrings.add(info);
//           });
//         },
//         onLocalUserRegistered: (uid, userAccount) {
//           setState(() {
//             final info = 'onRegisteredLocalUser: string: s, i: ${i.toString()}';
//             _infoStrings.add(info);
//           });
//         },
//         onLeaveChannel: (connection, stats) {
//           print("Channel Leave");
//
//           setState(() {
//             _infoStrings.add('onLeaveChannel');
//             _users.clear();
//           });
//           callMethods.endCall(
//               call: widget.call, currentUserId: userProvider.getUser.uid ?? "");
//         },
//         onConnectionLost: (connection) {
//           callMethods.endCall(
//             call: widget.call,
//             currentUserId: userProvider.getUser.uid ?? "",
//           );
//           setState(() {
//             final info = 'onConnectionLost';
//             _infoStrings.add(info);
//           });
//         },
//         onFirstRemoteVideoFrame:
//             (connection, remoteUid, width, height, elapsed) {
//           setState(() {
//             final info = 'firstRemoteVideo: $remoteUid ${width}x $height';
//             _infoStrings.add(info);
//           });
//         },
//       ),
//     );
//
//     // AgoraRtcEngine.onError = (dynamic code) {
//     //   setState(() {
//     //     final info = 'onError: $code';
//     //     _infoStrings.add(info);
//     //   });
//     // };
//
//     // AgoraRtcEngine.onJoinChannelSuccess = (
//     //   String channel,
//     //   int uid,
//     //   int elapsed,
//     // ) {
//     //   setState(() {
//     //     final info = 'onJoinChannel: $channel, uid: $uid';
//     //     _infoStrings.add(info);
//     //   });
//     // };
//
//     // AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
//     //   print('onUserJoined: $uid');
//     //   if (!timerStart) {
//     //     timer = new Timer.periodic(Duration(seconds: 1), _callTimer);
//     //     setState(() {
//     //       timerStart = true;
//     //     });
//     //   }
//     //   setState(() {
//     //     final info = 'onUserJoined: $uid';
//     //     _infoStrings.add(info);
//     //     _users.add(uid);
//     //   });
//     // };
//
//     // AgoraRtcEngine.onUpdatedUserInfo = (AgoraUserInfo userInfo, int i) {
//     //   setState(() {
//     //     final info = 'onUpdatedUserInfo: ${userInfo.toString()}';
//     //     _infoStrings.add(info);
//     //   });
//     // };
//
//     // AgoraRtcEngine.onRejoinChannelSuccess = (String string, int a, int b) {
//     //   setState(() {
//     //     final info = 'onRejoinChannelSuccess: $string';
//     //     _infoStrings.add(info);
//     //   });
//     // };
//
//     // AgoraRtcEngine.onRegisteredLocalUser = (String s, int i) {
//     //   setState(() {
//     //     final info = 'onRegisteredLocalUser: string: s, i: ${i.toString()}';
//     //     _infoStrings.add(info);
//     //   });
//     // };
//
//     // AgoraRtcEngine.onLeaveChannel = () {
//     //   print("Channel Leave");
//
//     //   setState(() {
//     //     _infoStrings.add('onLeaveChannel');
//     //     _users.clear();
//     //   });
//     //   callMethods.endCall(
//     //       call: widget.call, currentUserId: userProvider.getUser.uid);
//     // };
//
//     // AgoraRtcEngine.onConnectionLost = () {
//     //   callMethods.endCall(
//     //     call: widget.call,
//     //     currentUserId: userProvider.getUser.uid,
//     //   );
//     //   setState(() {
//     //     final info = 'onConnectionLost';
//     //     _infoStrings.add(info);
//     //   });
//     // };
//
//     // AgoraRtcEngine.onUserOffline = (int uid, int reason) {
//     //   print("user offline");
//     //   // callMethods.endCall(
//     //   //   call: widget.call,
//     //   //   currentUserId: userProvider.getUser.uid,
//     //   // );
//     //   setState(() {
//     //     final info = 'userOffline: $uid';
//     //     _infoStrings.add(info);
//     //     _users.remove(uid);
//     //   });
//     //   if (_users.isEmpty) {
//     //     callMethods.endCallForAll(
//     //       call: widget.call,
//     //       currentUserId: userProvider.getUser.uid,
//     //     );
//     //   }
//     // };
//
//     // AgoraRtcEngine.onFirstRemoteVideoFrame = (
//     //   int uid,
//     //   int width,
//     //   int height,
//     //   int elapsed,
//     // ) {
//     //   setState(() {
//     //     final info = 'firstRemoteVideo: $uid ${width}x $height';
//     //     _infoStrings.add(info);
//     //   });
//     // };
//   }
//
//   /// Helper function to get list of native views
//   List<Widget> _getRenderViews() {
//     final List<AgoraVideoView> list = [
//       AgoraVideoView(
//         controller: VideoViewController(
//           rtcEngine: _engine,
//           canvas: const VideoCanvas(uid: 0),
//         ),
//       )
//     ];
//     _users.forEach((int uid) => list.add(AgoraVideoView(
//       controller: VideoViewController(
//         rtcEngine: _engine,
//         canvas: VideoCanvas(uid: uid),
//       ),
//     )));
//     return list;
//   }
//
//   /// Video view wrapper
//   Widget _videoView(view) {
//     return Expanded(child: Container(child: view));
//   }
//
//   /// Video view row wrapper
//   Widget _expandedVideoRow(List<Widget> views) {
//     final wrappedViews = views.map<Widget>(_videoView).toList();
//     return Expanded(
//       child: Row(
//         children: wrappedViews,
//       ),
//     );
//   }
//
//   /// Video layout wrapper
//   Widget _viewRows() {
//     final views = _getRenderViews();
//     switch (views.length) {
//       case 1:
//         return Container(
//             child: Column(
//               children: <Widget>[_videoView(views[0])],
//             ));
//       case 2:
//         return Container(
//             child: Column(
//               children: <Widget>[
//                 _expandedVideoRow([views[0]]),
//                 _expandedVideoRow([views[1]])
//               ],
//             ));
//       case 3:
//         return Container(
//             child: Column(
//               children: <Widget>[
//                 _expandedVideoRow(views.sublist(0, 2)),
//                 _expandedVideoRow(views.sublist(2, 3))
//               ],
//             ));
//       case 4:
//         return Container(
//             child: Column(
//               children: <Widget>[
//                 _expandedVideoRow(views.sublist(0, 2)),
//                 _expandedVideoRow(views.sublist(2, 4))
//               ],
//             ));
//       case 5:
//         return Container(
//             child: Column(
//               children: <Widget>[
//                 _expandedVideoRow(views.sublist(0, 3)),
//                 _expandedVideoRow(views.sublist(3, 5))
//               ],
//             ));
//       case 6:
//         return Container(
//             child: Column(
//               children: <Widget>[
//                 _expandedVideoRow(views.sublist(0, 3)),
//                 _expandedVideoRow(views.sublist(3, 6))
//               ],
//             ));
//       default:
//     }
//     return Container();
//   }
//
//   void _onToggleMute() {
//     setState(() {
//       muted = !muted;
//     });
//     _engine.muteLocalAudioStream(muted);
//   }
//
//   void _onSwitchCamera() {
//     _engine.switchCamera();
//   }
//
//   void _onSwitchSpeaker() async {
//     if (speaker) {
//       _engine.setEnableSpeakerphone(false);
//       setState(() {
//         speaker = false;
//       });
//     } else {
//       _engine.setEnableSpeakerphone(true);
//       setState(() {
//         speaker = true;
//       });
//     }
//   }
//
//   /// Toolbar layout
//   Widget _toolbar() {
//     return Container(
//       alignment: Alignment.bottomCenter,
//       padding: const EdgeInsets.symmetric(vertical: 48),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           RawMaterialButton(
//             onPressed: _onToggleMute,
//             child: Icon(
//               muted ? Icons.mic : Icons.mic_off,
//               color: muted ? Colors.white : Colors.blueAccent,
//               size: 20.0,
//             ),
//             shape: CircleBorder(),
//             elevation: 2.0,
//             fillColor: muted ? Colors.blueAccent : Colors.white,
//             padding: const EdgeInsets.all(12.0),
//           ),
//           RawMaterialButton(
//             onPressed: () {
//               if (userProvider.getUser.uid != null) {
//                 if (_users.length < 2)
//                   callMethods.endCallForAllByCallId(call: widget.call);
//                 else
//                   callMethods.endCall(
//                     call: widget.call,
//                     currentUserId: userProvider.getUser.uid ?? "",
//                   );
//               }
//
//               if (widget.call.isGroup && _users.isEmpty) {
//                 print("Ending group call");
//                 callMethods.endCallForAll(
//                     call: widget.call,
//                     currentUserId: userProvider.getUser.uid ?? "");
//               } else {
//                 if (_users.length <= 1) {
//                   callMethods.endCallForAllByCallId(call: widget.call);
//                 } else {
//                   print("Single call end");
//                   callMethods.endCall(
//                       call: widget.call,
//                       currentUserId: userProvider.getUser.uid ?? "");
//                 }
//               }
//
//               if (Navigator.canPop(context)) {
//                 Navigator.pop(context);
//               }
//             },
//             child: Icon(
//               Icons.call_end,
//               color: Colors.white,
//               size: 35.0,
//             ),
//             shape: CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.redAccent,
//             padding: const EdgeInsets.all(15.0),
//           ),
//           (!(widget.call.voiceCall ?? false))
//               ? RawMaterialButton(
//             onPressed: _onSwitchCamera,
//             child: Icon(
//               Icons.switch_camera,
//               color: Colors.blueAccent,
//               size: 20.0,
//             ),
//             shape: CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.white,
//             padding: const EdgeInsets.all(12.0),
//           )
//               : RawMaterialButton(
//             onPressed: _onSwitchSpeaker,
//             child: Icon(
//               speaker ? Icons.volume_up : Icons.volume_off,
//               color: speaker ? Colors.white : Colors.blueAccent,
//               size: 20.0,
//             ),
//             shape: CircleBorder(),
//             elevation: 2.0,
//             fillColor: speaker ? Colors.blueAccent : Colors.white,
//             padding: const EdgeInsets.all(12.0),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     // clear users
//     _users.clear();
//     // destroy sdk
//     _dispose();
//     callStreamSubscription.cancel();
//     membersStreamSubscription.cancel();
//     if(timer != null) {
//       timer?.cancel();
//     }
//     super.dispose();
//   }
//
//   Future<void> _dispose() async {
//     await _engine.leaveChannel();
//     await _engine.release();
//   }
//
//   var i = 0;
//
//   Widget callScreen() {
//     return Container(
//       width: double.infinity,
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             widget.call.isGroup ? "Group Voice Call" : "Voice Call ",
//             style: TextStyle(
//               fontSize: 30,
//             ),
//           ),
//           SizedBox(height: 50),
//           Container(
//             height: 230,
//             child: Swiper(
//               loop: false,
//               itemBuilder: (BuildContext context, int index) {
//                 return Column(
//                   children: [
//                     CachedImage(
//                       allJoinedMembers[index]["photo"],
//                       isRound: true,
//                       radius: 100,
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       allJoinedMembers[index]["name"],
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//               itemCount: allJoinedMembers.length,
//               viewportFraction: 0.25,
//               scale: 0.4,
//             ),
//           ),
//           // (widget.call.isGroup)?Container(
//           //   decoration: BoxDecoration(
//           //     color: Theme.of(context).primaryColor,
//           //     shape: BoxShape.circle,
//           //   ),
//           //   padding: EdgeInsets.all(50),
//           //   child: Text(
//           //       (widget.call.hasDialled)?widget.call.receiverName[0].toUpperCase():widget.call.callerName[0].toUpperCase(),
//           //     style: TextStyle(
//           //       color: Colors.white,
//           //       fontWeight: FontWeight.bold,
//           //       fontSize: 85,
//           //     ),
//           //   ),
//           // ):CachedImage(
//           //   (widget.call.hasDialled)?widget.call.receiverPic:widget.call.callerPic,
//           //   isRound: true,
//           //   radius: 180,
//           // ),
//           // SizedBox(height: 15),
//           //
//           // Text(
//           //   (widget.call.hasDialled)?widget.call.receiverName:widget.call.callerName,
//           //   style: TextStyle(
//           //     fontWeight: FontWeight.bold,
//           //     fontSize: 20,
//           //   ),
//           // ),
//           SizedBox(height: 15),
//           (timerStart)
//               ? Text(
//             timeString,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 17,
//             ),
//           )
//               : Text(
//             "Dialing",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 17,
//             ),
//           ),
//
//           SizedBox(height: 75),
//         ],
//       ),
//     );
//   }
//
//   getContacts() async {
//     print("Getting contacts");
//     ChatMethods chatMethods = ChatMethods();
//
//     var contacts = await chatMethods.fetchContactsList(
//         userId: userProvider.getUser.uid ?? "");
//
//     contacts.docs.forEach((element) {
//
//       if (element["contact_id"] != null) contactList.add(element.data);
//     });
//
//     print(contactList);
//   }
//
//   showAddParticipantBottomSheet() {
//     List canBeAddedUser = [];
//
//     for (var contact in contactList) {
//       if (!alreadyJoinedUser.contains(contact["contact_id"]))
//         canBeAddedUser.add(contact);
//     }
//
//     showModalBottomSheet<void>(
//         context: context,
//         builder: (BuildContext context) {
//           return Container(
//             height: 600,
//             color: Colors.white,
//             child: Center(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text("Add participant to call",
//                       style: TextStyle(fontSize: 23)),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   (canBeAddedUser.isNotEmpty)
//                       ? Expanded(
//                     child: ListView.builder(
//                         itemCount: canBeAddedUser.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ListTile(
//                               onTap: () {
//                                 Call newCall = widget.call;
//                                 newCall.receiverId =
//                                 canBeAddedUser[index]["contact_id"];
//                                 newCall.receiverName =
//                                 canBeAddedUser[index]["contact_name"];
//                                 newCall.receiverPic =
//                                 canBeAddedUser[index]
//                                 ["contact_photo"];
//                                 Navigator.of(context).pop();
//                                 CallMethods.addParticipant(widget.call,
//                                     canBeAddedUser[index]["contact_id"]);
//                                 //    alreadyJoinedUser.add(canBeAddedUser[index]["contact_id"]);
//                               },
//                               title: Text(
//                                 canBeAddedUser[index]["contact_name"],
//                                 style: TextStyle(
//                                     fontFamily: "Arial",
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               leading: Container(
//                                 constraints: BoxConstraints(
//                                     maxHeight: 50, maxWidth: 50),
//                                 child: Stack(
//                                   children: <Widget>[
//                                     CachedImage(
//                                       canBeAddedUser[index]
//                                       ["contact_photo"] ??
//                                           imageNotAvailable,
//                                       radius: 50,
//                                       isRound: true,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                   )
//                       : Text("No contacts to add",
//                       style: TextStyle(fontSize: 20, color: Colors.grey)),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           children: <Widget>[
//             ((widget.call.voiceCall ?? false)) ? callScreen() : _viewRows(),
//             // _panel(),
//             _toolbar(),
//             // _users.isNotEmpty
//             //     ? Align(
//             //         alignment: Alignment.topRight,
//             //         child: GestureDetector(
//             //           onTap: () {
//             //             showAddParticipantBottomSheet();
//             //           },
//             //           child: Container(
//             //             margin: EdgeInsets.only(top: 50, right: 20),
//             //             child: Icon(
//             //               Icons.person_add_rounded,
//             //               color: Colors.black,
//             //             ),
//             //           ),
//             //         ))
//             //     : SizedBox()
//           ],
//         ),
//       ),
//     );
//   }
// }
