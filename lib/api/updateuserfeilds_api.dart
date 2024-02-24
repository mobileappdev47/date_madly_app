import 'dart:convert';

import 'package:date_madly_app/service/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/update_user.dart';
import 'package:http/http.dart' as http;
import '../pages/home/home.dart';
import '../utils/endpoint.dart';

class UpdateUserApi {
  static updateUsers(Map<String, dynamic>? body, BuildContext context) async {
    try {
      String url = EndPoints.Update;
      http.Response? response = await HttpService.postApi(url: url, body: body);
      print('Status Code===========${response!.statusCode}');
      if (response != null && response?.statusCode == 200) {
        print('Status Code===========${response!.statusCode}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
        return updateUsersFromJson(response!.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
