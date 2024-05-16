import 'dart:math';

import 'package:date_madly_app/pages/calling/call_method.dart';
import 'package:date_madly_app/pages/calling/lovecirco_user.dart';
import 'package:date_madly_app/pages/calling/my_call.dart';
import 'package:date_madly_app/pages/calling/my_call_screen.dart';
import 'package:flutter/material.dart';


class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dialOneToOne(
      {required LoveCircoUser from, required LoveCircoUser to, context}) async {

    Call call = Call(
        callerId: from.uid,
        callerName: from.name,
        callerPic: from.profilePhoto,
        receiverId: to.uid,
        receiverName: to.name,
        receiverPic: to.profilePhoto,
        hasDialled: true,
        isGroup: false,
        channelId: Random().nextInt(1000).toString(),
        voiceCall: false);

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;
    if (callMade) {
      await Navigator.push(
       context,
        MaterialPageRoute(
          builder: (context) => CallScreen(call: call),
        ),
      );
    }
  }

  static dialOneToOneVoiceCall(
      {required LoveCircoUser from, required LoveCircoUser to, context, required String chanelID}) async {
    Call call = Call(
        callerId: from.uid,
        callerName: from.name,
        callerPic: from.profilePhoto,
        receiverId: to.uid,
        receiverName: to.name,
        receiverPic: to.profilePhoto,
        isGroup: false,
        channelId: chanelID,
        voiceCall: true);

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      await Navigator.push(
       context,
        MaterialPageRoute(
          builder: (context) => CallScreen(call: call),
        ),
      );
    }
  }





}
