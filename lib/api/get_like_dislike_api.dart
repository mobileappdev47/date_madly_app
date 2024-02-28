import 'package:date_madly_app/models/get_like_dislike_model.dart';
import 'package:http/http.dart' as http;

import '../service/http_services.dart';
import '../service/pref_service.dart';
import '../utils/endpoint.dart';
import '../utils/pref_key.dart';

class GetLikedDislikeProfilesApi {
  static getlikedDislikeProfilesapi(
    int? status,
  ) async {
    try {
      var data = {
        "userID": '65ccaffe1963b9d676f54d84',
        "status": status,
      };
      String url = EndPoints.getLikedDislikeProfiles;
      http.Response? response = await HttpService.postApi(
        body: data,
        url: url,
      );

      print('Status Code===========${response!.statusCode}');

      if (response != null && response.statusCode == 200) {
        return getLikeDislikeModelFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
