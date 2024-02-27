import 'dart:convert';

import 'package:date_madly_app/models/sign_up_model.dart';
import 'package:date_madly_app/service/http_services.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/get_profile_model.dart';
import '../models/user_model.dart';

class GetProfileApi {
  static getprofileApi() async {
    try {

      String url = EndPoints.getProfile;
      http.Response? response = await HttpService.postApi(
        url: url,
      );
      print('Status Code===========${response!.statusCode}');

      if (response != null && response.statusCode == 200) {
        return getProfileFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
