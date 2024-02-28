import 'dart:convert';
import 'package:date_madly_app/models/changePassword_model.dart';
import 'package:http/http.dart' as http;
import '../utils/endpoint.dart';

class ChangePasswordApi {
  static changepasswordapi(
    // String? userId,
    String? currentPassword,
    String? newPassword,
  ) async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      var body = {
        "_id": '65d59e549c7ee7e6b2947b63',
        "currentPassword": currentPassword,
        "newPassword": newPassword
      };

      var response = await http.post(
        Uri.parse(EndPoints.changePasswordApi),
        body: body,
      );
      print('validation conform===${response.statusCode}');

      if (response.statusCode == 200) {
        return changePasswordModelFromJson(response.body);
      } else {
        return 'Failed to change password: ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error changing password: $e';
    }
  }
}
//now how to call this api in ui page also put condation current password is true then and then user creat new password and api call save button,also current password get on user login
//that time inputed password get and match if current password and inputed current password is same then change new password if password is not match then show password is not match
