import 'dart:convert';
import 'package:date_madly_app/models/get_notification_model.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/endpoint.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:http/http.dart' as http;


class NotificationApi {
  static notificationApi(context) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(EndPoints.notificationApi));
      request.body =
          json.encode({"userId": PrefService.getString(PrefKeys.userId)});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = (await response.stream.bytesToString());
        return getNotificationModelFromJson(data);
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      return null;
    }
  }
}
