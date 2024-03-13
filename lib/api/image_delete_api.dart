import 'dart:convert';
import 'package:date_madly_app/models/get_single_profile_model.dart';
import 'package:date_madly_app/models/image_delete_model.dart';
import 'package:date_madly_app/models/login_model.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/pages/new/enter_personal_data/personal_data_provider.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/endpoint.dart';

class ImageDeleteApi {
  static imageDeleteApi(context, imageUrl) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(EndPoints.deleteImageApi));
      request.body = json.encode({
        "id": PrefService.getString(PrefKeys.userId),
        'imageUrl': imageUrl,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();

        return imageDeleteModelFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
