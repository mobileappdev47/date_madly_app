import 'dart:convert';

import 'package:date_madly_app/models/add_like_dislike_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../service/http_services.dart';
import '../service/pref_service.dart';
import '../utils/endpoint.dart';
import '../utils/pref_key.dart';

class AddLikedDislikeProfileApi {
  static addLikedDislikeProfileapi(
    String? likeid,
    int? status,
  ) async {
    try {
      var data = {
        "userID": PrefService.getString(PrefKeys.userId),
        "likedID": likeid.toString(),
        "status": status.toString(),
      };

      String url = EndPoints.addLikedDislikeProfile;
      http.Response? response = await HttpService.postApi(body: data, url: url);

      print('Status Code===========${response!.statusCode}');
      if (response != null && response.statusCode == 200) {
        return addLikeDislikeModelFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
