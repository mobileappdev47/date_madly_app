import 'dart:convert';
import 'dart:io';

import 'package:date_madly_app/models/chat_room_model.dart';
import 'package:date_madly_app/models/countries_model.dart';
import 'package:date_madly_app/models/fetch_liked_dislike_profile.dart';
import 'package:date_madly_app/models/liked_dislike_profile_model.dart';
import 'package:date_madly_app/models/user_model.dart';
import 'package:dio/dio.dart';

import '../models/chats.dart';
import '../models/profile_model.dart';

class Api {
  // final service = IsarService();
  Dio dio = Dio();

  // static String baseURL = 'http://192.168.1.24:8000/api';
/*  static String baseURL =
      "https://XXXXXX.execute-api.XXXXXXXX.amazonaws.com/production/" +
          "api";*/
  static String baseURL = "https://datemadly.onrender.com/" + "api";
  static String cloudFrontImageURL = 'https://datemadly.onrender.com/';

  //login @NotProtected
  static String registrationURL = '$baseURL/createUser';
  static String userExistsURL = '$baseURL/userExists';
  static String refreshTokenURL = '$baseURL/refreshToken';
  static String updateFieldsURL = '$baseURL/updateUserFields';
  static String updateAdditionalURL = '$baseURL/updateAdditionalDetails';

  //countries @NotProtected
  static String countriesURL = '$baseURL/getCities';

  //profile @Protected
  static String getProfileURL = '$baseURL/getProfile';
  static String getSingleProfileURL = '$baseURL/getSingleProfile';
  static String addLikeDislikeProfileURL = '$baseURL/addLikeDislikeProfile';
  static String getLikedDislikeProfileURL = '$baseURL/getLikedDislikeProfile';
  static String updateRequestStatusURL = '$baseURL/updateRequestStatus';

  //chatRoom @Protected
  static String getAllChatRoomURL = '$baseURL/getAllChatRoom';

  //chats @Protected
  static String getAllChatURL = '$baseURL/getSingleChat';
  static String sendSingleChatURL = '$baseURL/sendSingleChat';
  static String updateMessageStatusURL = '$baseURL/updateMessageStatus';

  //images @Protected
  static String uploadImageURL = '$baseURL/uploadImage';
  static String replaceImageURL = '$baseURL/replaceImage';

  Future<CountriesModel> getCities(String url) async {
    Response response = await dio.get(url);

    CountriesModel signup;
    if (response.statusCode == 401) {
      print("401 error");
      throw const HttpException('401');
    }
    if (response.statusCode == 200) {
      print(response.toString());
      var json = jsonDecode(response.toString());
      signup = CountriesModel.fromJson(json);
    } else {
      throw ('Error ${response.statusCode}');
    }
    return signup;
  }

  // Future<UserModel> user(String url, params, token) async {
  //   Response response = await dio.post(url, data: jsonEncode(params));
  //
  //   UserModel signup;
  //   if (response.statusCode == 401) {
  //     print("401 error");
  //     throw const HttpException('401');
  //   }
  //   if (response.statusCode == 200) {
  //     print(response.toString());
  //     var json = jsonDecode(response.toString());
  //     signup = UserModel.fromJson(json);
  //   } else {
  //     throw ('Error ${response.statusCode}');
  //   }
  //   return signup;
  // }

  Future<ProfileModel> profile(String url, params, token) async {
    Response response = await dio.post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }),
        data: jsonEncode(params));

    ProfileModel signup;

    if (response.statusCode == 401) {
      print("401 error");
      // throw const HttpException('401');
    }
    if (response.statusCode == 200) {
      var json = jsonDecode(response.toString());
      signup = ProfileModel.fromJson(json);
    } else {
      throw ('Error ${response.statusCode}');
    }
    return signup;
  }

  Future<BasicInfo> getBasicInfo(String url, params, token) async {
    Response response = await dio.post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }),
        data: jsonEncode(params));

    BasicInfo signup;

    if (response.statusCode == 401) {
      print("401 error");
      // throw const HttpException('401');
    }
    if (response.statusCode == 200) {
      var json = jsonDecode(response.toString());
      signup = BasicInfo.fromJson(json);
    } else {
      throw ('Error ${response.statusCode}');
    }
    return signup;
  }

  Future<ChatRoomModel> chatRoom(String url, params, token) async {
    Response response = await dio.post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }),
        data: jsonEncode(params));

    ChatRoomModel signup;
    if (response.statusCode == 401) {
      print("401 error");
      throw const HttpException('401');
    }
    if (response.statusCode == 200) {
      // print(response.toString());
      var json = jsonDecode(response.toString());

      //save to database
      // service.saveChatroom((json['chatRoom'] as List)
      //     .map((e) => e as Map<String, dynamic>)
      //     .toList());

      print(json['chatRoom']);
      signup = ChatRoomModel.fromJson(json);
    } else {
      throw ('Error ${response.statusCode}');
    }
    return signup;
  }

  Future<ChatsModel> chat(String url, params, token) async {
    Response response = await dio.post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }),
        data: jsonEncode(params));

    ChatsModel signup;
    if (response.statusCode == 401) {
      print("401 error");
      throw const HttpException('401');
    }
    if (response.statusCode == 200) {
      var json = jsonDecode(response.toString());
      signup = ChatsModel.fromJson(json);
    } else {
      throw ('Error ${response.statusCode}');
    }
    return signup;
  }

  Future<Chat> sendChat(String url, params, token) async {
    Response response = await dio.post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }),
        data: jsonEncode(params));

    Chat signup;
    if (response.statusCode == 401) {
      print("401 error");
      throw const HttpException('401');
    }
    if (response.statusCode == 200) {
      // print(response.toString());
      var json = jsonDecode(response.toString());
      signup = Chat.fromJson(json);
    } else {
      throw ('Error ${response.statusCode}');
    }
    return signup;
  }

  Future<LikedDislikeProfile> likedDislikeProfile(
      String url, params, token) async {
    Response response = await dio.post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }),
        data: jsonEncode(params));
    LikedDislikeProfile signup;
    if (response.statusCode == 401) {
      print("401 error");
      throw const HttpException('401');
    }
    if (response.statusCode == 200) {
      // print(response.toString());
      var json = jsonDecode(response.toString());
      signup = LikedDislikeProfile.fromJson(json);
    } else {
      throw ('Error ${response.statusCode}');
    }
    return signup;
  }

  Future<FetchLikeProfile> fetchLikeProfile(String url, params, token) async {
    Response response = await dio.post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }),
        data: jsonEncode(params));

    FetchLikeProfile signup;
    if (response.statusCode == 401) {
      // print("401 error");
      throw const HttpException('401');
    }
    if (response.statusCode == 200) {
      // print(response.toString());
      var json = jsonDecode(response.toString());
      signup = FetchLikeProfile.fromJson(json);
    } else {
      throw ('Error ${response.statusCode}');
    }
    return signup;
  }
}
