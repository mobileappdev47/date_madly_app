import 'dart:convert';
import 'package:date_madly_app/models/get_single_profile_model.dart';
import 'package:date_madly_app/models/login_model.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/pages/new/enter_personal_data/personal_data_provider.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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

        updateProvider.nameController.text =
            getSingleProfileModelFromJson(data).profile?[0].name ?? '';
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
                null &&
            getSingleProfileModelFromJson(data).profile?[0].dob.toString() !=
                '') {
          DateTime originalDate = DateTime.parse(
              getSingleProfileModelFromJson(data).profile![0].dob.toString());
          updateProvider.dobController.text =
              DateFormat('dd/MM/yyyy').format(originalDate);
        } else {}

        return getSingleProfileModelFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
