import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/chat/call.dart';
import 'package:date_madly_app/pages/chat/chat_message.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PickUpScreen extends StatefulWidget {
  PickUpScreen({super.key, required this.otherEmail});

  final String otherEmail;

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Incoming........',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        join();

                      },
                      child: Text('Pick Up')), ElevatedButton(
                      onPressed: () {
                            leave();
                      },
                      child: Text('End')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
