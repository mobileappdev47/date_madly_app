import 'package:http/http.dart'as http;
import '../models/liked_dislike_profile_model.dart';
import '../models/likedislike_profiles_model.dart';
import '../service/http_services.dart';
import '../utils/endpoint.dart';

class LikedDislikeProfilesApi {
  static likedDislikeProfilesapi(
      String? likeid,
      int? status,
      ) async {
    try {
      var data =     {
        "userID": likeid,
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