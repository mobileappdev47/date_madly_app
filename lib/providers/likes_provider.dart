import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api.dart';
import '../service/pref_service.dart';
import '../utils/enum/api_request_status.dart';
import '../utils/functions.dart';

class LikesProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  ///----------old-------------
  LikesProvider() {
    getID();
  }
  List filterList = [];

  void searching(value, likedProfiles) {
    filterList = (likedProfiles.where((element) {
      return element.userId!.name
          .toString()
          .toLowerCase()
          .contains(value.toString().toLowerCase());
    }).toList());
    notifyListeners();
    print(filterList);
  }


  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  Api api = Api();
  var id;
  late SharedPreferences sharedPreferences;

  // Future getAllLikes() async {
  //   setApiRequestStatus(APIRequestStatus.loading);
  //   var params = await getUserParams();
  //   var token = await getToken();
  //   Timer(const Duration(milliseconds: 800), () async {
  //     try {
  //       print("params************* $params");
  //
  //       LikedDislikeProfile profile = await api.likedDislikeProfile(
  //
  //           Api.getLikedDislikeProfileURL, params, token());
  //       PrefService.getString('idToken');
  //       setProfile(profile);
  //       print("length: ${profile.likedDislikeProfile!.length}");
  //       setApiRequestStatus(APIRequestStatus.loaded);
  //     } on DioException catch (e) {
  //       checkError(e);
  //     }
  //   });
  // }

  getUserParams() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('id');
    var params = {"userID": id, "status": 0};
    return params;
  }

  getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var token =
        // PrefService.getString('accessToken');
        sharedPreferences.getString('accessToken');
    return token;
  }

  getID() async {
    sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('id');
    return id;
  }

  void setProfile(value) {
    // likeDislikeProfile = value;
    notifyListeners();
  }

  void checkError(e) {
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

  String calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }
}
