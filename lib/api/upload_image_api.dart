import 'dart:io';
import 'package:date_madly_app/models/upload_image_model.dart';
import 'package:date_madly_app/pages/new/enter_personal_data/enter_personal_data_screen.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class UploadImageApi {
  static uploadImageApi(File image, context) async {
    final url = Uri.parse(EndPoints.uploadImage);
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'id': PrefService.getString(PrefKeys.userId),
    });

    if (image.path.isNotEmpty) {
      var fileExtension = path.extension(image.path).toLowerCase();
      print('File Extension: ${fileExtension.substring(1)}');
      if (fileExtension == '.png' ||
          fileExtension == '.jpg' ||
          fileExtension == '.svg' ||
          fileExtension == '.jpeg' ||
          fileExtension == '.mp4' ||
          fileExtension == '.avi' ||
          fileExtension == '.webp') {
        request.files.add(await http.MultipartFile.fromPath('photo', image.path,
            contentType: MediaType("image", fileExtension.substring(1))));
      }
    }

    try {
      var response = await request.send();
      print(response);
      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();

        return uploadImageModelFromJson(data);
      } else {}
      return;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
