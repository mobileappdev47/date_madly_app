import 'dart:convert';

import 'package:date_madly_app/models/sign_up_model.dart';
import 'package:date_madly_app/pages/me/additional_details.dart';
import 'package:date_madly_app/service/http_services.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpApi {
  static signUpApi({Map<String, dynamic>? body, BuildContext? context,required String password}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(EndPoints.signUpApi));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        PrefService.setValue(
            PrefKeys.userId, signUpModelFromJson(data).user?.id ?? '');
        PrefService.setValue(
            PrefKeys.password,password);
        if (signUpModelFromJson(data).user != null) {
          if (signUpModelFromJson(data).user!.name != 'User Exists') {
            Navigator.pushReplacement(
              context!,
              MaterialPageRoute(
                builder: (c) => AdditionalDetails(pageNo: 1),
              ),
            );
          } else {
            ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
              content: Text(
                'User Exists',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));
          }
        } else {}
        return signUpModelFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
