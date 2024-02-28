import 'dart:convert';
import 'package:http/http.dart' as http;
import '../service/http_services.dart';
import '../utils/endpoint.dart';

class ChangePasswordApi {
  static changepasswordapi(Map<String, dynamic> data) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse(EndPoints.changePasswordApi));
      request.body = json.encode(data);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var data = (await response.stream.bytesToString());
        return data;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      return 'Error changing password: $e';
    }
  }
}
