
import 'package:date_madly_app/service/http_services.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:http/http.dart' as http;

import '../models/get_profile_model.dart';

class GetProfileApi {
  static getprofileApi() async {
    try {

      String url = EndPoints.getProfile;
      http.Response? response = await HttpService.postApi(
        url: url,
      );
      print('Status Code===========${response!.statusCode}');

      if (response != null && response.statusCode == 200) {
        return getProfileFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
