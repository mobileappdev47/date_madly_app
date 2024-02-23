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
  static Future<Map<String, dynamic>?> additinalApi({
    required String selectedSunSign,
    required String selectedCuisine,
    required String selectedPastime,
    required String selectedReligion,
    required String selectedSmokingStatus,
    required String selectedDrinkingStatus,
    required String selectedFirstDate,
    required String selectedPersonality,
    required String selectedLookingFor,
    required String selectedPoliticalViews,
  }) async {
    try {
      String url = EndPoints.adddetail;
      print('API URL: $url');

      Map<String, dynamic> body = {
        'sun_sign': selectedSunSign,
        'cuisine': selectedCuisine,
        'fav_pastime': selectedPastime,
        'religion': selectedReligion,
        'smoke': selectedSmokingStatus,
        'drink': selectedDrinkingStatus,
        'first_date': selectedFirstDate,
        'personality': selectedPersonality,
        'looking_for': selectedLookingFor,
        'political_views': selectedPoliticalViews,
      };
      print('Request Body: $body');
      http.Response? response = await HttpService.postApi(url: url, body: body);
      print("Status Code: ${response!.statusCode}");

      if (response.statusCode == 200) {
        // Parse the response data if needed
        Map<String, dynamic> responseData = {
          "_id": "65d718e0675a3fd38b970c10",
          "sun_sign": selectedSunSign,
          "cuisine": selectedCuisine,
          "political_views": selectedPoliticalViews,
          "looking_for": selectedLookingFor,
          "personality": selectedPersonality,
          "first_date": selectedFirstDate,
          "drink": selectedDrinkingStatus,
          "smoke": selectedSmokingStatus,
          "religion": selectedReligion,
          "fav_pastime": selectedPastime
        };
        print('Response Data: $responseData');
        return responseData;
      } else {
        print('Something went wrong');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
