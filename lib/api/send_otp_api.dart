

import 'dart:convert';

import 'package:date_madly_app/pages/login/phone_auth/new_otp_screen.dart';
import 'package:date_madly_app/service/http_services.dart';

import 'package:date_madly_app/utils/endpoint.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;



class SendOtpApi {
  static Future sendOtpApi(
      {required String phoneNumber, required BuildContext context}) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(EndPoints.sendOtpApi));
      request.body = json.encode(
          {
        "phoneNumber": phoneNumber
      }
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

       if (response.statusCode == 200) {

         print(response.statusCode);
         Navigator.push(context, MaterialPageRoute(builder: (context) => NewOtpScreen(phone: phoneNumber, verificationId: ''),));

       } else {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong!',style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
       }

    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
