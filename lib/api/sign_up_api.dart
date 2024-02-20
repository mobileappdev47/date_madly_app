import 'package:date_madly_app/models/sign_up_model.dart';
import 'package:date_madly_app/pages/login/profile_photo/profile_photo_screen.dart';
import 'package:date_madly_app/service/http_services.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SignUpApi {
  static signUpApi({Map<String, dynamic>? body, context}) async {
    try {
      String url = EndPoints.signUpApi;

      http.Response? response = await HttpService.postApi(
          url: url, body: body, header: {"Content-Type": "application/json"});
      print(response);
      if (response != null && response.statusCode == 200) {
        if (signUpModelFromJson(response.body).user != null) {
          if (signUpModelFromJson(response.body).user!.name != 'User Exists') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (c) => ProfilePhotoScreen(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'User Exists',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));
          }
        }
        return signUpModelFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {}
  }
}
