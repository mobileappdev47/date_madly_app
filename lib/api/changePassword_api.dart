import 'dart:convert';
import 'package:http/http.dart' as http;
import '../service/http_services.dart';
import '../utils/endpoint.dart';

class ChangePasswordApi {
  static changepasswordapi(Map<String, dynamic> data) async {
    try {
      String url = EndPoints.changePasswordApi; // Verify this endpoint URL
      http.Response? response = await HttpService.postApi(
        body: data,
        url: url,
      );

      print('Response Status Code:============= ${response!.statusCode}');

      if (response != null && response.statusCode == 200) {
        return response.body;
      } else {
        return 'Failed to change password: ${response?.reasonPhrase}';
      }
    } catch (e) {
      return 'Error changing password: $e';
    }
  }
}
