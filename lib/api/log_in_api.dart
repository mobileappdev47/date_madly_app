import 'dart:convert';

import 'package:date_madly_app/service/http_services.dart';

import '../models/update_user.dart';
import 'package:http/http.dart' as http;
import '../utils/endpoint.dart';

class LoginApi {
  static login({Map<String, dynamic>? body}) async {
    try {
      String url = EndPoints.login;
      http.Response? response = await HttpService.postApi(url: url, body: body);
      print(response!.statusCode);
      if (response != null && response?.statusCode == 200) {
        return updateUsersFromJson(response!.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
