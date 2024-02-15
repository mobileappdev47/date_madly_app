import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/profile_model.dart';
import '../models/user_model.dart';
import '../network/api.dart';
import '../utils/enum/api_request_status.dart';
import '../utils/functions.dart';

class EditProfileProvider with ChangeNotifier {
  EditProfileProvider() {
    getID();
  }
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  Api api = Api();
  var id;
  var gender;
  late SharedPreferences sharedPreferences;
  ProfileModel singleProfileModel = ProfileModel();
  var feet;
  var inch;
  int activePage = 0;

  changeImageIndicator(page) {
    activePage = page;
    notifyListeners();
  }

  getSingleProfile() async {
    setApiRequestStatus(APIRequestStatus.loading);
    await getID();
    var params = {"_id": id};
    var token = await getToken();
    Timer(const Duration(milliseconds: 400), () async {
      try {
        ProfileModel profile =
            await api.profile(Api.getSingleProfileURL, params, token);
        singleProfileModel = profile;
        notifyListeners();
        setApiRequestStatus(APIRequestStatus.loaded);
      } on DioException catch (e) {
        checkError(e);
      }
    });
  }

  getID() async {
    sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('id');
    gender = sharedPreferences.getString('gender');
    // var params = {"id": id};
    return id;
  }

  getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('jwtToken');
    return token;
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }

  Future<void> checkError(e) async {
    if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(APIRequestStatus.connectionError);
    } else {
      if (e.response.statusCode == 401) {
        var params = {"_id": id};
        UserModel profile = await api.user(Api.refreshTokenURL, params, "");
        if (profile.jwtToken != null) {
          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("jwtToken", profile.jwtToken!);
          print("refresh token${profile.jwtToken}");
          // getDataFromNetwork();
        }
      } else {
        setApiRequestStatus(APIRequestStatus.error);
      }
    }
  }

  getHeight(int? height) {
    switch (height) {
      case 134:
        feet = 4;
        inch = 5;
        break;
      case 135:
        feet = 4;
        inch = 5;
        break;
      case 136:
        feet = 4;
        inch = 5;
        break;
      case 137:
        feet = 4;
        inch = 6;
        break;
      case 138:
        feet = 4;
        inch = 6;
        break;
      case 139:
        feet = 4;
        inch = 7;
        break;
      case 140:
        feet = 4;
        inch = 7;
        break;
      case 141:
        feet = 4;
        inch = 7;
        break;
      case 142:
        feet = 4;
        inch = 8;
        break;
      case 143:
        feet = 4;
        inch = 8;
        break;
      case 144:
        feet = 4;
        inch = 9;
        break;
      case 145:
        feet = 4;
        inch = 9;
        break;
      case 146:
        feet = 4;
        inch = 9;
        break;
      case 147:
        feet = 4;
        inch = 10;
        break;
      case 148:
        feet = 4;
        inch = 10;
        break;
      case 149:
        feet = 4;
        inch = 11;
        break;
      case 150:
        feet = 4;
        inch = 11;
        break;
      case 151:
        feet = 4;
        inch = 11;
        break;
      case 152:
        feet = 5;
        inch = 0;
        break;
      case 153:
        feet = 5;
        inch = 0;
        break;
      case 154:
        feet = 5;
        inch = 1;
        break;
      case 155:
        feet = 5;
        inch = 1;
        break;
      case 156:
        feet = 5;
        inch = 1;
        break;
      case 157:
        feet = 5;
        inch = 2;
        break;
      case 158:
        feet = 5;
        inch = 2;
        break;
      case 159:
        feet = 5;
        inch = 2;
        break;
      case 160:
        feet = 5;
        inch = 3;
        break;
      case 161:
        feet = 5;
        inch = 3;
        break;
      case 162:
        feet = 5;
        inch = 4;
        break;
      case 163:
        feet = 5;
        inch = 4;
        break;
      case 164:
        feet = 5;
        inch = 4;
        break;
      case 165:
        feet = 5;
        inch = 5;
        break;
      case 166:
        feet = 5;
        inch = 5;
        break;
      case 167:
        feet = 5;
        inch = 6;
        break;
      case 168:
        feet = 5;
        inch = 6;
        break;
      case 169:
        feet = 5;
        inch = 6;
        break;
      case 170:
        feet = 5;
        inch = 7;
        break;
      case 171:
        feet = 5;
        inch = 7;
        break;
      case 172:
        feet = 5;
        inch = 8;
        break;
      case 173:
        feet = 5;
        inch = 8;
        break;
      case 174:
        feet = 5;
        inch = 8;
        break;
      case 175:
        feet = 5;
        inch = 9;
        break;
      case 176:
        feet = 5;
        inch = 9;
        break;
      case 177:
        feet = 5;
        inch = 10;
        break;
      case 178:
        feet = 5;
        inch = 10;
        break;
      case 179:
        feet = 5;
        inch = 10;
        break;
      case 180:
        feet = 5;
        inch = 11;
        break;
      case 181:
        feet = 5;
        inch = 11;
        break;
      case 182:
        feet = 6;
        inch = 0;
        break;
      case 183:
        feet = 6;
        inch = 0;
        break;
      case 184:
        feet = 6;
        inch = 0;
        break;
      case 185:
        feet = 6;
        inch = 1;
        break;
      case 186:
        feet = 6;
        inch = 1;
        break;
      case 187:
        feet = 6;
        inch = 2;
        break;
      case 188:
        feet = 6;
        inch = 2;
        break;
      case 189:
        feet = 6;
        inch = 2;
        break;
      case 190:
        feet = 6;
        inch = 3;
        break;
      case 191:
        feet = 6;
        inch = 3;
        break;
      case 192:
        feet = 6;
        inch = 3;
        break;
      case 193:
        feet = 6;
        inch = 4;
        break;
      case 194:
        feet = 6;
        inch = 4;
        break;
      case 195:
        feet = 6;
        inch = 5;
        break;
      case 196:
        feet = 6;
        inch = 5;
        break;
      case 197:
        feet = 6;
        inch = 5;
        break;
      case 198:
        feet = 6;
        inch = 6;
        break;
      case 199:
        feet = 6;
        inch = 6;
        break;
      case 200:
        feet = 6;
        inch = 7;
        break;
      case 201:
        feet = 6;
        inch = 7;
        break;
      case 202:
        feet = 6;
        inch = 7;
        break;
      case 203:
        feet = 6;
        inch = 8;
        break;
      case 204:
        feet = 6;
        inch = 8;
        break;
      case 205:
        feet = 6;
        inch = 9;
        break;
      case 206:
        feet = 6;
        inch = 9;
        break;
      case 207:
        feet = 6;
        inch = 9;
        break;
      case 208:
        feet = 6;
        inch = 10;
        break;
      case 209:
        feet = 6;
        inch = 10;
        break;
      case 210:
        feet = 6;
        inch = 11;
        break;
      case 211:
        feet = 6;
        inch = 11;
        break;
      case 212:
        feet = 6;
        inch = 11;
        break;
      case 213:
        feet = 7;
        inch = 0;
        break;
      default:
    }
  }
}
