import 'package:http/http.dart'as http;
import '../models/add_liked_dislike_profile_model.dart';
import '../models/get_likedislike_profiles_model.dart';
import '../service/http_services.dart';
import '../utils/endpoint.dart';

class LikedDislikeProfilesApi {
  static likedDislikeProfilesapi(
      String? likeid,
      String? status,
      ) async {
    try {
      var id='65ccaffe1963b9d676f54d84';
      var data =   {
        "userID": id,
        "status": status,
      };
      String url = EndPoints.getLikedDislikeProfiles;
      http.Response? response = await HttpService.postApi(
        body: data,
        url: url,
      );

      print('Status Code===========${response!.statusCode}');

      if (response != null && response.statusCode == 200) {
        return getLikedDislikeProfileFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      print('=============Something went wrong${e.toString()}');
      return null;
    }
  }
}