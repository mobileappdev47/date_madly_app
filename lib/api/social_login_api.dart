import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/models/login_model.dart';
import 'package:date_madly_app/models/phone_login_model.dart';
import 'package:date_madly_app/models/social_login_api.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/pages/me/additional_details.dart';
import 'package:date_madly_app/service/notification_service.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/endpoint.dart';

class SocialLoginApi {
  static socialLogin(Map<String, dynamic> body, context, lat, long) async {
    try {
      var headers = {'Content-Type': 'application/json'};

      var request = http.Request('POST', Uri.parse(EndPoints.socialLoginApi));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        
        print ('my social login data ---------->>>>>>>>>>>>>>>>>>>$data');
        PrefService.setValue(
            PrefKeys.userId, socialLoginModelFromJson(data).user?.id ?? '');
        // PrefService.setValue(PrefKeys.password, password);

        await PrefService.setValue(PrefKeys.email, socialLoginModelFromJson(data).user?.id ?? '');

        PrefService.setValue(PrefKeys.lat, lat);
        PrefService.setValue(PrefKeys.long, long);


        if(socialLoginModelFromJson(data).message=='User already registered'){

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeMain(),
              ));
          PrefService.setValue(PrefKeys.isAdditional, true);

        }
        else {

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdditionalDetails(pageNo: 1),
              ));
        }

        getFirebaseCollection(socialLoginModelFromJson(data).user?.id ?? '');

        return socialLoginModelFromJson(data);
      } else {
        print('social login status code not correctly set...............................${response}');
        print(response.reasonPhrase);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Something went wrong',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getFirebaseCollection(email) {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    fireStore.collection("Auth").get().then((value) async {
      var list = (value.docs);
      bool already = false;

      for (int i = 0; i < list.length; i++) {
        if (list[i].id == email) {
          print('collection already exist');
          already = true;
          break;
        } else {}
      }

      if (already == false) {
        await fireStore.collection("Auth").doc(email).set({'ChatUserList': []});
      } else {
        print('done');
      }
    });
  }
}
