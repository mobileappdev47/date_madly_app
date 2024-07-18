import 'dart:convert';

import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:http/http.dart' as http;

// class AdditinalDetail {
//   static additinalApi({
//     String? selectedSunSign,
//      String? selectedCuisine,
//      String? selectedPastime,
//      String? selectedReligion,
//      String? selectedSmokingStatus,
//      String? selectedDrinkingStatus,
//      String? selectedFirstDate,
//      String? selectedPersonality,
//      String? selectedLookingFor,
//      String? selectedPoliticalViews,
//   }) async {
//     try {
//       String url = EndPoints.adddetail;
//       Map<String, dynamic> requestBody = {
//         "sun_sign": selectedSunSign,
//         "cuisine": selectedCuisine,
//         "fav_pastime": selectedPastime,
//         "religion": selectedReligion,
//         "smoke": selectedSmokingStatus,
//         "drink": selectedDrinkingStatus,
//         "first_date": selectedFirstDate,
//         "personality": selectedPersonality,
//         "looking_for": selectedLookingFor,
//         "political_views": selectedPoliticalViews,
//       };
//       http.Response? response =
//           await HttpService.postApi(url: url, body: requestBody);
//       print("Status Code================>${response?.statusCode}");
//       if (response != null && response?.statusCode == 200) {
//         return response.body;
//       } else {
//         print('Something went wrong');
//         return null;
//       }
//     } catch (e) {
//       print('Exception: $e');
//       return null;
//     }
//   }
// }

class AdditinalDetail {
  static Future additinalApi(
      {required Map<String, dynamic> body, bool? isLastQuestion}) async {
    try {
      String url = EndPoints.adddetail;
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        print("Status Code: ${response!.statusCode}");
        // print("response body: ${response.body}");
        if (isLastQuestion == true) {
          PrefService.setValue(PrefKeys.isAdditional, true);
        }
      }
      else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
