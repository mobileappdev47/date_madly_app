import 'dart:convert';

import 'package:date_madly_app/models/add_like_dislike_model.dart';
import 'package:date_madly_app/models/update_request_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../service/http_services.dart';
import '../service/pref_service.dart';
import '../utils/endpoint.dart';
import '../utils/pref_key.dart';

class UpdateRequestApi {
  static updateRequestApi(
    String? likeid,
    int? status,
  ) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse(EndPoints.updateRequestStatusApi));
      request.body = json.encode({
        "userID": PrefService.getString(PrefKeys.userId),
        "likedID": likeid.toString(),
        "status": status.toString(),
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = (await response.stream.bytesToString());
        return updateRequestModelFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      return null;
    }
  }
}
