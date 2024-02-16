import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/fetch_liked_dislike_profile.dart';
import '../models/profile_model.dart';
import '../models/user_model.dart';
import '../network/api.dart';
import '../utils/colors.dart';
import '../utils/enum/api_request_status.dart';
import '../utils/functions.dart';

class HomeMainProvider with ChangeNotifier {
  bool male = false;
  bool female = false;

  double currentSliderValue = 0;
  List notificationList = [
    'assets/icons/Add Image (1).png',
    'assets/icons/n1.png',
    'assets/icons/n2.png'
  ];

  List notificationName = ['Clara, 22', 'Renna,23', 'Patricia,23'];

  void showNotificationContainer(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 0, right: 0),
              child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Notification',
                              style: TextStyle(
                                  color: ColorRes.appColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 140,
                            ),
                            Stack(
                              children: [
                                Image.asset(
                                  'assets/icons/Notification.png',
                                  scale: 3,
                                  color: ColorRes.grey,
                                ),
                                CircleAvatar(
                                  radius: 4,
                                  backgroundColor: ColorRes.appColor,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Today',
                              style: TextStyle(
                                  color: ColorRes.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: notificationList.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          notificationList[index],
                                          scale: 3,
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 20,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '2 MIN AGO',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: ColorRes.grey),
                                        ),
                                        Row(
                                          children: [
                                            Text(notificationName[index],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: ColorRes.darkGrey,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset(
                                              'assets/icons/Location_Icon.png',
                                              scale: 5,
                                              color: ColorRes.appColor,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('5 Km',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: ColorRes.grey,
                                                    fontWeight:
                                                        FontWeight.w700))
                                          ],
                                        ),
                                        Text('Invites you yo for a match !',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: ColorRes.grey)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: ColorRes.appColor),
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: ColorRes.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Yesterday',
                              style: TextStyle(
                                  color: ColorRes.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/icons/n1.png',
                                  scale: 3,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '24 HOUR AGO',
                                  style: TextStyle(
                                      fontSize: 12, color: ColorRes.grey),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Patricia,23 ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: ColorRes.darkGrey,
                                              fontWeight: FontWeight.w700)),
                                      TextSpan(
                                          text: 'likes your photo.',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: ColorRes.grey)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Stack(children: [
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Image.asset(
                              'assets/icons/n3.png',
                              scale: 2.2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 110, left: 70),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.favorite_border,
                                        color: ColorRes.white, size: 25),
                                    Image.asset(
                                      'assets/icons/Comment.png',
                                      scale: 2.5,
                                    )
                                  ],
                                ),
                                Text(
                                  '100 Like',
                                  style: TextStyle(
                                      color: ColorRes.white, fontSize: 16),
                                )
                              ],
                            ),
                          )
                        ])
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }

  ///-----old-------
  HomeMainProvider() {
    getID();
  }

  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  Api api = Api();
  ProfileModel profileModel = ProfileModel();
  ProfileModel singleProfileModel = ProfileModel();
  late SharedPreferences sharedPreferences;
  var feet;
  var inch;
  bool showCheck = false;
  bool showCross = false;
  PageController controller = PageController();
  int activePage = 0;

  var id;

  changeImageIndicator(page) {
    activePage = page;
    notifyListeners();
  }

  showCrossBool() {
    showCross = true;
    showCheck = false;
    notifyListeners();
  }

  showCheckBool() {
    showCross = false;
    showCheck = true;
    notifyListeners();
  }

  stopAllBool() {
    showCross = false;
    showCheck = false;
  }

  fetchProfile() async {
    // var user = await getSavedData();
    // print(user.profile);
    // if (user == null || user.profile.length == 0) {
    getDataFromNetwork();
    // } else {
    // setSavedData();
    // }
  }

  getDataFromNetwork() async {
    print("NETWORK CALLED");
    setApiRequestStatus(APIRequestStatus.loading);
    var params = await getUserParams();
    var token = await getToken();
    activePage = 0;
    Timer(const Duration(milliseconds: 400), () async {
      try {
        ProfileModel profile =
            await api.profile(Api.getProfileURL, params, token);
        setProfile(profile);

        setApiRequestStatus(APIRequestStatus.loaded);
      } on DioException catch (e) {
        checkError(e);
      }
    });
  }

  getSingleProfile() async {
    setApiRequestStatus(APIRequestStatus.loading);
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

  setSavedData() async {
    print("SAVED CALLED");
    sharedPreferences = await SharedPreferences.getInstance();
    var userdata = json.decode(sharedPreferences.getString('profile')!);
    var profile = ProfileModel.fromJson(userdata);
    profileModel = profile;
    print(profileModel.profile?[0]);
    // userdata.removeWhere((item) => item == 0);
    notifyListeners();
    setApiRequestStatus(APIRequestStatus.loaded);
  }

  Future<void> likeDislikeProfile(String likedID, int status) async {
    if (profileModel.profile!.length == 1) {
      var send = await sendLikeStatus(likedID, status);
      print(send);
      if (send) {
        getDataFromNetwork();
        print("object");
        stopAllBool();
      }
    }
    if (profileModel.profile!.length > 1) {
      var send = await sendLikeStatus(likedID, status);
      if (send) {
        profileModel.profile!.removeWhere((item) => item.sId == likedID);
        notifyListeners();
      }
    }
    if (profileModel.profile!.isEmpty) {
      getDataFromNetwork();
      stopAllBool();
    } else {
      controller.animateToPage(controller.page!.round() + 1,
          curve: Curves.ease, duration: const Duration(milliseconds: 400));
      stopAllBool();

      notifyListeners();
    }
  }

  Future<bool> likeDislikeRequested(String likedID, int status) async {
    print("sended $likedID");
    var send = await updateLikeStatus(likedID, status);
    if (send) {
      print("true");
      return true;
    } else {
      print("false");
      return false;
    }
  }

  getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('jwtToken');
    return token;
  }

  Future updateLikeStatus(String likedID, int status) async {
    var params = {"userID": id, "likedID": likedID, "status": status};
    print(params);
    var token = await getToken();
    try {
      FetchLikeProfile liked =
          await api.fetchLikeProfile(Api.updateRequestStatusURL, params, token);
      if (liked.status == status) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      checkError(e);
    }
  }

  sendLikeStatus(String likedID, int status) async {
    var params = {"userID": id, "likedID": likedID, "status": status};
    var token = await getToken();
    print(params);
    try {
      FetchLikeProfile liked = await api.fetchLikeProfile(
          Api.addLikeDislikeProfileURL, params, token);
      print(status);
      if (liked.status == status) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      checkError(e);
    }
  }

  getID() async {
    sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('id');
    // var params = {"id": id};
    return id;
  }

  void setProfile(value) {
    profileModel = value;
    // saveData();
    notifyListeners();
  }

  getSavedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    ProfileModel? user;

    if (sharedPreferences.getString('profile') != null) {
      var userdata = json.decode(sharedPreferences.getString('profile')!);
      user = ProfileModel.fromJson(userdata);
    } else {
      user = null;
    }
    return user;
  }

  saveData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    //  var userdata = json.decode(sharedPreferences.getString('userdata')!);
    sharedPreferences.setString("profile", json.encode(profileModel));

    // var user = ProfileModel.fromJson(userdata);
  }

  getUserParams() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('gender');
    var params = {"gender": id};
    print(params);
    return params;
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
          getDataFromNetwork();
        }
      } else {
        setApiRequestStatus(APIRequestStatus.error);
      }
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
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
