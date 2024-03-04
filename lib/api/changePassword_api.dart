import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../service/http_services.dart';
import '../utils/endpoint.dart';

class ChangePasswordApi {
  static changepasswordapi(Map<String, dynamic> data, context) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse(EndPoints.changePasswordApi));
      request.body = json.encode(data);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var data = (await response.stream.bytesToString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'PassWord reset successfully',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        return data;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      return 'Error changing password: $e';
    }
  }
}
