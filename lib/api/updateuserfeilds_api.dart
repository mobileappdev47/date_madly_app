import 'dart:convert';

import 'package:date_madly_app/service/http_services.dart';

import '../models/update_user.dart';
import 'package:http/http.dart' as http;
import '../utils/endpoint.dart';

class UpdateUserApi {
  static updateUsers({Map<String, dynamic>? body,context}) async {
    try {
      String url = EndPoints.Update;
      http.Response? response = await HttpService.postApi(url: url, body: body);
      print('Status Code===========${response!.statusCode}');
      if (response != null && response?.statusCode == 200) {
        return updateUsersFromJson(response!.body);
      }else{
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
