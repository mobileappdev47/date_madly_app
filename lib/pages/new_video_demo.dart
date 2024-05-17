import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/new_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../utils/utils.dart';
import 'calling/my_call.dart';

Future<void> makeCall(BuildContext context, String receiverName,
    String receiverUid, String receiverProfilePic, bool isGroupChat) async {

  String callId = const Uuid().v1();

  Call senderCallData = Call(
    callerId: 'xyz123',
    callerName: 'janki',
    callerPic: '',
    receiverId: receiverUid,
    receiverName: receiverName,
    receiverPic: receiverProfilePic,
    channelId: callId,
    hasDialled: true,
    isGroup: false
  );

  Call receiverCallData = Call(

    isGroup: false ,
    callerId: 'xyz123',
    callerName: 'janki',
    callerPic: '',
    receiverId: receiverUid,
    receiverName: receiverName,
    receiverPic: receiverProfilePic,
    channelId: callId,
    hasDialled: false,
  );

  await callUser(senderCallData, context, receiverCallData);
}

Future callUser(
    Call senderCallData,
    BuildContext context,
    Call receiverCallData,
    ) async {

  try {


    await FirebaseFirestore.instance
        .collection('call')
        .doc(senderCallData.callerId)
        .set(senderCallData.toMap());
    await FirebaseFirestore.instance
        .collection('call')
        .doc(senderCallData.receiverId)
        .set(receiverCallData.toMap());


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewCallScreen(
          channelId: senderCallData.channelId!,
          call: senderCallData,

        ),
      ),
    );

  } catch (e) {
  print(e.toString());
  }
}