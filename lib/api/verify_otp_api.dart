//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:date_madly_app/models/verify_otp_model.dart';
// import 'package:date_madly_app/pages/home/home.dart';
// import 'package:date_madly_app/pages/home/main.dart';
// import 'package:date_madly_app/pages/login/phone_auth/new_otp_screen.dart';
// import 'package:date_madly_app/pages/me/additional_details.dart';
// import 'package:date_madly_app/service/http_services.dart';
// import 'package:date_madly_app/service/pref_service.dart';
//
// import 'package:date_madly_app/utils/endpoint.dart';
// import 'package:date_madly_app/utils/pref_key.dart';
// import 'package:flutter/material.dart';
//
// import 'package:http/http.dart' as http;
//
//
//
// class VerifyOtpApi {
//   static Future verifyOtpApi(
//       {required Map<String,dynamic> body, required BuildContext context,lat,long}) async {
//     try {
//       String url = EndPoints.verifyOtpApi;
//       print('API URL: $url');
//
//       http.Response? response = await HttpService.postApi(url: url, body: body);
//       print("Status Code: ${response!.statusCode}");
//
//       if (response.statusCode == 200) {
//
//         PrefService.setValue(
//             PrefKeys.userId, verifyOtpModelFromJson(response.body).user?.id ?? '');
//         // PrefService.setValue(PrefKeys.password, password);
//
//         await PrefService.setValue(PrefKeys.email, verifyOtpModelFromJson(response.body).user?.id ?? '');
//
//         PrefService.setValue(PrefKeys.lat, lat);
//         PrefService.setValue(PrefKeys.long, long);
//
//
//         if(verifyOtpModelFromJson(response.body).message=='This user already exists'){
//
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => HomeMain(),
//               ));
//           PrefService.setValue(PrefKeys.isAdditional, true);
//
//
//         }
//         else {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AdditionalDetails(pageNo: 1),
//               ));
//         }
//
//         getFirebaseCollection(verifyOtpModelFromJson(response.body).user?.id ?? '');
//
//         return verifyOtpModelFromJson(response.body);
//
//
//       } else {}
//     } catch (e) {
//       print('Exception: $e');
//       return null;
//     }
//   }
//
//
//   static getFirebaseCollection(email) {
//     final FirebaseFirestore fireStore = FirebaseFirestore.instance;
//     fireStore.collection("Auth").get().then((value) async {
//       var list = (value.docs);
//       bool already = false;
//
//       for (int i = 0; i < list.length; i++) {
//         if (list[i].id == email) {
//           print('collection already exist');
//           already = true;
//           break;
//         } else {}
//       }
//
//       if (already == false) {
//         await fireStore.collection("Auth").doc(email).set({'ChatUserList': []});
//       } else {
//         print('done');
//       }
//     });
//   }
// }
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/models/login_model.dart';
import 'package:date_madly_app/models/phone_login_model.dart';
import 'package:date_madly_app/models/verify_otp_model.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/pages/me/additional_details.dart';
import 'package:date_madly_app/service/notification_service.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/endpoint.dart';

class VerifyOtpApi {
  static verifyOtpApi(Map<String, dynamic> body, context, lat, long) async {
    try {
      var headers = {'Content-Type': 'application/json'};

      var request = http.Request('POST', Uri.parse(EndPoints.verifyOtpApi
      ));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        PrefService.setValue(
            PrefKeys.userId, verifyOtpModelFromJson(data).user?.id ?? '');
        // PrefService.setValue(PrefKeys.password, password);


        await PrefService.setValue(PrefKeys.email, verifyOtpModelFromJson(data).user?.id ?? '');

        PrefService.setValue(PrefKeys.lat, lat);
        PrefService.setValue(PrefKeys.long, long);


        if(verifyOtpModelFromJson(data).message=='This user already exists'){

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeMain(),
              ));
          PrefService.setValue(PrefKeys.isAdditional, true);

        }
        else {

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdditionalDetails(pageNo: 1),
              ));
        }

        getFirebaseCollection(verifyOtpModelFromJson(data).user?.id ?? '');

        return verifyOtpModelFromJson(data);
      } else {
        print(response.reasonPhrase);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Something went wrong',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getFirebaseCollection(email) {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    fireStore.collection("Auth").get().then((value) async {
      var list = (value.docs);
      bool already = false;

      for (int i = 0; i < list.length; i++) {
        if (list[i].id == email) {
          print('collection already exist');
          already = true;
          break;
        } else {}
      }

      if (already == false) {
        await fireStore.collection("Auth").doc(email).set({'ChatUserList': []});
      } else {
        print('done');
      }
    });
  }
}
