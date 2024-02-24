import 'package:date_madly_app/service/http_services.dart';
import 'package:date_madly_app/utils/endpoint.dart';
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
  static Future additinalApi({required Map<String, dynamic> body}) async {
    try {
      String url = EndPoints.adddetail;
      print('API URL: $url');

      print('Request Body: $body');
      http.Response? response = await HttpService.postApi(url: url, body: body);
      print("Status Code: ${response!.statusCode}");

      if (response.statusCode == 200) {
        print(response.statusCode);
      } else {}
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
