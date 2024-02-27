import 'package:http/http.dart'as http;
import '../models/likedislike_profiles_model.dart';
import '../service/http_services.dart';
import '../utils/endpoint.dart';

class LikedDislikeProfilesApi {
  static likedDislikeProfilesapi(
      int? status,
      ) async {
    try {
      var data =     {
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
        return likedDislikeProfilesFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}