import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/calling/my_call.dart';


class CallMethods {
  final CollectionReference callCollection =
  FirebaseFirestore.instance.collection('calls');

  Stream<DocumentSnapshot> callStream({required String uid}) =>
      callCollection.doc(uid).snapshots();
  Stream<QuerySnapshot> callStreamByChannelId({required String channel_id}) =>
      callCollection.where("channel_id", isEqualTo: channel_id).snapshots();

  Future<bool> makeCall({required Call call}) async {

      return await makeOneToOneCall(call);

  }

  Future<bool> makeOneToOneCall(Call call) async {
    try {
      call.hasDialled = false;
      Map<String, dynamic> hasDialledMap = call.toMap();

      call.hasDialled = true;
      Map<String, dynamic> hasNotDialledMap = call.toMap();

      await callCollection.doc(call.callerId).set(hasDialledMap);
      await callCollection.doc(call.receiverId).set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }



  Future<bool> endCall({
    required Call call,
    required String currentUserId,
  }) async {


    try {

        await callCollection.doc(currentUserId).delete();
        await callCollection.doc(call.callerId).delete();
        await callCollection.doc(call.receiverId).delete();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCallForAll({
    required Call call,
    required String currentUserId,
  }) async {


    try {

        await callCollection.doc(call.callerId).delete();
        await callCollection.doc(call.receiverId).delete();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCallForAllByCallId({
    required Call call,
  }) async {
    try {
      QuerySnapshot snapshot = await callCollection
          .where("channel_id", isEqualTo: call.channelId)
          .get();
      snapshot.docs.forEach((element) {
        element.reference.delete();
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static addParticipant(Call call, String userId) async {
    CallMethods callMethods = CallMethods();
    call.hasDialled = false;
    Map<String, dynamic> hasNotDialledMap = call.toMap();
    print(hasNotDialledMap);
    await callMethods.callCollection
        .doc(userId.toString())
        .set(hasNotDialledMap);
  }
}
