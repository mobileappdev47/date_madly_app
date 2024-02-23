import 'package:date_madly_app/models/sign_up_model.dart';
import 'package:date_madly_app/service/http_services.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:http/http.dart' as http;

class SignUpApi {
  static signUpApi({Map<String, dynamic>? body}) async {
    try {
      String url = EndPoints.signUpApi;

      http.Response? response = await HttpService.postApi(url: url, body: body);

      print('Status Code===========${response!.statusCode}');

      if (response != null && response.statusCode == 200) {
        return signupFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
