import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/models/login_model.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/endpoint.dart';

class LoginApi {
  static login(Map<String, dynamic> body, context, password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(EndPoints.login));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        PrefService.setValue(
            PrefKeys.userId, loginModelFromJson(data).user?.id ?? '');
        PrefService.setValue(PrefKeys.password, password);
        PrefService.setValue(PrefKeys.isAdditional, true);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeMain(),
            ));
        await PrefService.setValue(PrefKeys.email, body['email']);
        getFirebaseCollection(body['email']);
        return loginModelFromJson(data);
      } else {
        print(response.reasonPhrase);
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
