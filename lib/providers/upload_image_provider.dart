import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/profile_model.dart';
import '../network/api.dart';
import '../utils/enum/api_request_status.dart';
import '../utils/functions.dart';

class UploadImageProvider extends ChangeNotifier {
  APIRequestStatus apiRequestStatus = APIRequestStatus.loaded;
  Api api = Api();
  late SharedPreferences sharedPreferences;
  ProfileModel singleProfileModel = ProfileModel();
  var id;

  uploadImage(img) async {
    var params = await getUserParams(img);
    var token = await getToken();
    try {
      ProfileModel profile =
          await api.profile(Api.uploadImageURL, params, token);
      singleProfileModel = profile;
      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      checkError(e);
    }
  }

  getAllImages() async {
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

  replaceImage(oldImgURl, newImg, index) async {
    setApiRequestStatus(APIRequestStatus.loading);
    await getID();
     var params = {"id": id, "oldPhotoURL": oldImgURl, "newPhoto": newImg, "index": index};
    var token = await getToken();
    Timer(const Duration(milliseconds: 400), () async {
      try {
        ProfileModel profile =
            await api.profile(Api.replaceImageURL, params, token);
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
    // var params = {"id": id};
    return id;
  }

  getUserParams(img) async {
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('id');
    var params = {"id": id, "photo": img};
    return params;
  }

  getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('jwtToken');
    return token;
  }

  void checkError(e) {
    print(e);
    if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(APIRequestStatus.connectionError);
    } else {
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }
}
