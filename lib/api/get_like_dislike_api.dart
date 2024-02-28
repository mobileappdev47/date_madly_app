import 'dart:convert';

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
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse(EndPoints.getLikedDislikeProfiles));
      request.body = json.encode(
          {"userID": PrefService.getString(PrefKeys.userId), "status": 0});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = (await response.stream.bytesToString());
        return getLikeDislikeModelFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
