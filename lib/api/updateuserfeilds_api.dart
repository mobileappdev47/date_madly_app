import 'dart:convert';

import 'package:date_madly_app/service/http_services.dart';

import '../models/update_user.dart';
import 'package:http/http.dart' as http;
import '../utils/endpoint.dart';

class UpdateUserApi {
  static Future updateUsers() async {
    try {
      String url = EndPoints.Update;
      http.Response? response = await HttpService.postApi(url: url);
      if (response?.statusCode == 200) {
        return updateUsersFromJson(response!.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
