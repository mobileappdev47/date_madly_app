import 'dart:convert';

import 'package:date_madly_app/models/add_like_dislike_model.dart';
import 'package:http/http.dart' as http;

import '../service/pref_service.dart';
import '../utils/endpoint.dart';
import '../utils/pref_key.dart';

class AddLikedDislikeProfileApi {
  static addLikedDislikeProfileapi(
    String? likeid,
    int? status,
  ) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse(EndPoints.addLikedDislikeProfile));
      print({
        "userID": PrefService.getString(PrefKeys.userId),
        "likedID": likeid.toString(),
        "status": status.toString(),
      });
      request.body = json.encode({
        "userID": PrefService.getString(PrefKeys.userId),
        "likedID": likeid.toString(),
        "status": status.toString(),
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = (await response.stream.bytesToString());
        return addLikeDislikeModelFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      return null;
    }
  }
}
