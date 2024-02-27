import 'package:date_madly_app/service/http_services.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:http/http.dart' as http;

import '../models/additinal_detail_model.dart';

class AdditinalDetail {
  static additinalApi({
    String? sunsign,
    String? cuisine,
    String? political,
    String? looking,
    String? personality,
    String? firsts,
    String? drink,
    String? smoke,
    String? religion,
    String? fav_pastime,
    Map<String, dynamic>? body,
  }) async {
    try {
      String url = EndPoints.adddetail;
      print('API URL: $url');
      var data = {
        "_id": "65d718e0675a3fd38b970c10",
        "sun_sign": sunsign,
        "cuisine": cuisine,
        "political_views": political,
        "looking_for": looking,
        "personality": personality,
        "first_date": firsts,
        "drink": drink,
        "smoke": smoke,
        "religion": religion,
        "fav_pastime": fav_pastime
      };

      // print('Request Body: $body');
      http.Response? response = await HttpService.postApi(url: url, body: data);
      print("Status Code: ${response!.statusCode}");

      if (response.statusCode == 200) {
        return additinalDetailFromJson(response.body);
        print(response.statusCode);
      } else {}
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
