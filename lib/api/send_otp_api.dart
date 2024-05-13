import 'package:date_madly_app/service/http_services.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:http/http.dart' as http;



// class SendOtpApi {
//   static Future sendOtpApi(
//       {required String phoneNumber}) async {
//     try {
//       String url = EndPoints.adddetail;
//       print('API URL: $url');
//
//       print('Request Body: $body');
//       http.Response? response = await HttpService.postApi(url: url, body: body);
//       print("Status Code: ${response!.statusCode}");
//
//       if (response.statusCode == 200) {
//         print(response.statusCode);
//         if (isLastQuestion == true) {
//           PrefService.setValue(PrefKeys.isAdditional, true);
//         }
//       } else {}
//     } catch (e) {
//       print('Exception: $e');
//       return null;
//     }
//   }
// }
