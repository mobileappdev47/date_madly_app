import 'dart:convert';
import 'dart:io';

import 'package:date_madly_app/models/update_user.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/service/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../utils/endpoint.dart';

class UpdateUserApi {
  static updateUsers(
      Map<String, String>? body, BuildContext context, File? image) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST', Uri.parse('http://13.53.134.38:4000/api/updateUserFields'));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = (await response.stream.bytesToString());
        return updateUsersFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      return null;
    }
  }
}
