import 'package:http/http.dart'as http;
import '../models/liked_dislike_profile_model.dart';
import '../models/likedislike_profiles_model.dart';
import '../service/http_services.dart';
import '../service/pref_service.dart';
import '../utils/endpoint.dart';
import '../utils/pref_key.dart';

class LikedDislikeProfilesApi {
  static likedDislikeProfilesapi(
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
        return likedDislikeProfilesFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}

class LikedDislikeProfileApi {
  static likedDislikeProfileapi(
      String? likeid,
      int? status,
      ) async {
    try {
      var data = {
        "userID": PrefService.getString(PrefKeys.userId),
        "likedID": likeid.toString(),
        "status": status.toString(),
      };

      String url = EndPoints.addLikedDislikeProfile;
      http.Response? response = await HttpService.postApi(body: data, url: url);

      print('Status Code===========${response!.statusCode}');
      if (response != null && response.statusCode == 200) {
        return likedDislikeProfileFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
