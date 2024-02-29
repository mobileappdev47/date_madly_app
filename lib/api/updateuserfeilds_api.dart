import 'dart:io';

import 'package:date_madly_app/models/update_user.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/service/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../utils/endpoint.dart';

class UpdateUserApi {
  static updateUsers(
      Map<String, String>? body, BuildContext context, File? image) async {
    try {
      String url = EndPoints.Update;
      http.Response? response = await HttpService.postApi(url: url, body: body);
      print('Status Code===========${response!.statusCode}');
      if (response != null && response?.statusCode == 200) {
        print('Status Code===========${response!.statusCode}');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeMain(),
            ));

        return updateUsersFromJson(response!.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
    /* final url = Uri.parse(EndPoints.Update);
    var request = http.MultipartRequest('POST', url);
    ;
    request.fields.addAll(body!);

    if (image!.path.isNotEmpty) {
      var fileExtension = path.extension(image.path).toLowerCase();
      print('File Extension: ${fileExtension.substring(1)}');
      if (fileExtension == '.png' ||
          fileExtension == '.jpg' ||
          fileExtension == '.svg' ||
          fileExtension == '.jpeg' ||
          fileExtension == '.mp4' ||
          fileExtension == '.avi' ||
          fileExtension == '.webp') {
        request.files.add(await http.MultipartFile.fromPath(
            'profile', image.path,
            contentType: MediaType("image", fileExtension.substring(1))));
      }
    }

    try {
      var response = await request.send();
      print(response);
      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeMain(),
            ));
        return updateUsersFromJson(data);
      } else {}
      return;*/
/*    } catch (e) {
      debugPrint(e.toString());
    }*/
  }
}
