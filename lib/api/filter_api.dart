import 'dart:convert';
import 'package:date_madly_app/models/comment_model_new.dart';
import 'package:date_madly_app/models/sign_up_model.dart';
import 'package:date_madly_app/service/http_services.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/get_profile_model.dart';
import '../models/user_model.dart';

class FilterApi {
  static filterApi(body, context) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(EndPoints.filterApi));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = (await response.stream.bytesToString());
        return getAllUserFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      return null;
    }
  }
}
