import 'dart:convert';

import 'package:date_madly_app/models/add_like_dislike_model.dart';
import 'package:date_madly_app/models/get_all_chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../service/http_services.dart';
import '../service/pref_service.dart';
import '../utils/endpoint.dart';
import '../utils/pref_key.dart';

class GetAllChatApi {
  static getAllChatApi() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(EndPoints.getAllChatApi));
      request.body = json.encode({
        "id": PrefService.getString(PrefKeys.userId),
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = (await response.stream.bytesToString());
        return getAllChatRoomFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      return null;
    }
  }
}
