import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/calling/my_call.dart';
import 'package:date_madly_app/pages/new_recive_scren.dart';
import 'package:flutter/material.dart';

class CallSyncWidget extends StatelessWidget {
  final Widget scaffold;
  const CallSyncWidget({
    Key? key,
    required this.scaffold,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('call')
          .doc('xyz123')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data() != null) {
          Call call = Call.fromMap(snapshot.data!.data() as Map<String, dynamic>);
          if (!call.hasDialled!) {
            // If there's an incoming call, display the Call Pickup Screen
            return NewReceiiveScreen();
          }
        }
        // If no incoming call, display the provided scaffold
        return scaffold;
      },
    );
  }
}
