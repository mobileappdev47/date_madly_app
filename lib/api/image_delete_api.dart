import 'dart:convert';
import 'package:date_madly_app/models/image_delete_model.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:http/http.dart' as http;
import '../utils/endpoint.dart';

class ImageDeleteApi {
  static imageDeleteApi(context, imageUrl) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(EndPoints.deleteImageApi));
      request.body = json.encode({
        "id": PrefService.getString(PrefKeys.userId),
        'imageUrl': imageUrl,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();

        return imageDeleteModelFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
