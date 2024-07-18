
import 'package:date_madly_app/models/comment_model_new.dart';
import 'package:date_madly_app/service/http_services.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentApi {

  static commentApi(body, context) async {
    try {
      String url = EndPoints.commentApi;
      http.Response? response = await HttpService.postApi(url: url, body: body);

      if (response != null && response.statusCode == 200) {
        Navigator.pop(context);
        return commentModelFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
