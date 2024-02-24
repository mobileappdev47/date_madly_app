import 'dart:convert';

import 'package:date_madly_app/models/sign_up_model.dart';
import 'package:date_madly_app/service/http_services.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class GetAllApi {
  static getallApi() async {
    try {
      String url = EndPoints.Alluser;
      http.Response? response = await HttpService.postApi(
        url: url,
      );

      print('Status Code===========${response!.statusCode}');

      if (response != null && response.statusCode == 200) {
        return getAllUserFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
