import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "d47f99c3a3ff4c639a78ae664d4df40b";





class VideoCallSmit extends StatefulWidget {
   VideoCallSmit({Key? key, required this.channel}) : super(key: key);
   final String channel ;

  @override
  State<VideoCallSmit> createState() => _VideoCallSmitState();
}

class _VideoCallSmitState extends State<VideoCallSmit> {
  int? _remoteUid;
  bool _localUserJoined = false;
  String token = "";
  late RtcEngine _engine;
  AgoraClient client = AgoraClient(agoraConnectionData: AgoraConnectionData(appId: "d47f99c3a3ff4c639a78ae664d4df40b", channelName:"423423424"));
  @override
  void initState() {
    super.initState();

    initAgora();

    // initAgoraView();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
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
            // final AgoraClient client = AgoraClient(
            //   agoraConnectionData: AgoraConnectionData(
            //     uid: remoteUid,
            //     rtmUid: remoteUid.toString(),
            //     appId: "d47f99c3a3ff4c639a78ae664d4df40b",
            //     channelName: "test",
            //     username: "user",
            //   ),
            // );

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

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();


    await _engine.joinChannel(
      token: token,
      channelId: widget.channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }
  void initAgoraView() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: _engine,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          AgoraVideoButtons(
            client: client,
            addScreenSharing: false,
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return
        //   Column(
        //   children: [
        //     AgoraVideoViewer(
        //       client: client,
        //       layoutType: Layout.floating,
        //       enableHostControls: true, // Add this to enable host controls
        //     ),
        //     AgoraVideoButtons(
        //       client: client,
        //       addScreenSharing: false, // Add this to enable screen sharing
        //     ),
        //   ],
        // ) ;
        AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection:  RtcConnection(channelId: widget.channel),
          ),
        );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

}



























