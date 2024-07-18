import 'dart:convert';
import 'package:date_madly_app/models/get_single_profile_model.dart';
import 'package:date_madly_app/pages/new/enter_personal_data/personal_data_provider.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../utils/endpoint.dart';

class GetSingleProfileApi {
  static getSingleProfileApi(context, userId) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(EndPoints.getSingleProfile));
      request.body = json.encode({"_id": userId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Updateprovider updateProvider =
            Provider.of<Updateprovider>(context, listen: false);
        var data = await response.stream.bytesToString();
        print("datadatadatadatadatadatadatadatadatadata ${data}");

        updateProvider.nameController.text =
            getSingleProfileModelFromJson(data).profile?[0].name ?? '';
        updateProvider.phoneController.text= getSingleProfileModelFromJson(data).profile?[0].phoneNo??"";
        updateProvider.emailController.text=  getSingleProfileModelFromJson(data).profile?[0].email??"";
        updateProvider.locationController.text =
            getSingleProfileModelFromJson(data).profile?[0].location ?? '';
        updateProvider.jobController.text =
            getSingleProfileModelFromJson(data).profile?[0].job ?? '';
        updateProvider.companyController.text =
            getSingleProfileModelFromJson(data).profile?[0].company ?? '';
        updateProvider.collegeController.text =
            getSingleProfileModelFromJson(data).profile?[0].college ?? '';
        updateProvider.aboutController.text =
            getSingleProfileModelFromJson(data).profile?[0].about ?? '';

        if (getSingleProfileModelFromJson(data).profile?[0].dob.toString() !=
                'null' &&
            getSingleProfileModelFromJson(data).profile?[0].dob.toString() !=
                '') {
          DateTime originalDate = DateTime.parse(
              getSingleProfileModelFromJson(data).profile![0].dob.toString());
          updateProvider.dobController.text =
              DateFormat('dd/MM/yyyy').format(originalDate);
        } else {}
        if(   getSingleProfileModelFromJson(data).profile?[0].images != null &&
            getSingleProfileModelFromJson(data)
                .profile![0].images!.isNotEmpty){

          PrefService.setValue(PrefKeys.currentUserImage,getSingleProfileModelFromJson(data)
              .profile![0].images![0] );

        }
        else {
        }

        PrefService.setValue(PrefKeys.userName,  getSingleProfileModelFromJson(data).profile?[0].name ?? '');
        return getSingleProfileModelFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getCurrentProfileApi(context, userId) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(EndPoints.getSingleProfile));
      request.body = json.encode({"_id": userId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        print("datadatadatadatad getCurrentProfileApi ${data}");

        return getSingleProfileModelFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }


  static getOtherUserProfileApi(context, userId) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      print("userIduserId ${userId}");
      var request = http.Request('POST', Uri.parse(EndPoints.getUserProfile));
      request.body = json.encode({"userId": userId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {

        var jsonString = await response.stream.bytesToString();
        print("Received JSON string: $jsonString");

        // // Parse JSON string to Map<String, dynamic>
        // var json = jsonDecode(jsonString);
        //
        // // Access the 'profile' list from the JSON
        // var profileList = json['profile'];
        //
        // // Assuming you want to convert the first profile object to a User object
        // if (profileList.isNotEmpty) {
        //   var userProfileJson = profileList[0];
        //
        //   // Assuming you have a function to deserialize JSON to User object, e.g., userFromJson
        //   var user = userFromJson(userProfileJson);
        //
        //   // Now you can use the 'user' object
          return userFromJson(jsonString);

      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
