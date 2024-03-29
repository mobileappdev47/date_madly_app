import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/api/notification_api.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/models/get_notification_model.dart';
import 'package:date_madly_app/utils/assert_re.dart';
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
import '../utils/texts.dart';

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
  GetNotificationModel getNotificationModel = GetNotificationModel();
  getNotification(context) async {
    try {
      getNotificationModel = await NotificationApi.notificationApi(context);
    } catch (e) {
      print(e.toString());
    }
  }

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
                            Text(Strings.notification,
                                style: mulishbold.copyWith(
                                    fontSize: 18, color: ColorRes.appColor)),
                            SizedBox(
                              width: 140,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Stack(
                                children: [
                                  Image.asset(
                                    AssertRe.notification,
                                    scale: 3,
                                    color: ColorRes.grey,
                                  ),
                                  CircleAvatar(
                                    radius: 4,
                                    backgroundColor: ColorRes.appColor,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Text(
                        //       Strings.today,
                        //       style: mulishbold.copyWith(
                        //         color: ColorRes.darkGrey,
                        //         fontSize: 16,
                        //       ),
                        //     )),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              getNotificationModel.notifications?.length ?? 0,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      imageUrl: getNotificationModel
                                              .notifications?[index].imageUrl ??
                                          '',
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/images/image_placeholder.png',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/images/image_placeholder.png',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   Strings.minago,
                                        //   style: mulish14400,
                                        // ),
                                        Row(
                                          children: [
                                            Text(
                                              getNotificationModel
                                                      .notifications?[index]
                                                      .title ??
                                                  '',
                                              style: mulishbold.copyWith(
                                                color: ColorRes.darkGrey,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset(
                                              AssertRe.notification,
                                              scale: 5,
                                              color: ColorRes.appColor,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              Strings.homeKM,
                                              style: mulish14400,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          getNotificationModel
                                                  .notifications?[index].body ??
                                              '',
                                          maxLines: 2,
                                          style: mulish14400.copyWith(
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
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
                        SizedBox(
                          height: 20,
                        ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     Strings.yesterday,
                        //     style: mulishbold.copyWith(
                        //       fontSize: 16,
                        //       color: ColorRes.darkGrey,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Image.asset(
                        //           AssertRe.notifiimage1,
                        //           scale: 3,
                        //         )
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           Strings.hourago,
                        //           style: mulishbold.copyWith(
                        //               fontSize: 12, color: ColorRes.grey),
                        //         ),
                        //         RichText(
                        //           text: TextSpan(
                        //             style: TextStyle(
                        //               fontSize: 20.0,
                        //               color: Colors.black,
                        //             ),
                        //             children: <TextSpan>[
                        //               TextSpan(
                        //                 text: Strings.patricia,
                        //                 style: mulishbold.copyWith(
                        //                   fontSize: 12,
                        //                   color: ColorRes.darkGrey,
                        //                 ),
                        //               ),
                        //               TextSpan(
                        //                   text: Strings.likesyourphoto,
                        //                   style: mulish14400),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 10),
                        // Stack(children: [
                        //   Padding(
                        //     padding: EdgeInsets.only(left: 50),
                        //     child: Image.asset(
                        //       AssertRe.notifiimage3,
                        //       scale: 2.2,
                        //     ),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.only(top: 110, left: 70),
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Row(
                        //           children: [
                        //             Icon(Icons.favorite_border,
                        //                 color: ColorRes.white, size: 25),
                        //             Image.asset(
                        //               AssertRe.comment,
                        //               scale: 2.5,
                        //             )
                        //           ],
                        //         ),
                        //         Text(
                        //           Strings.like,
                        //           style: mulish14400.copyWith(
                        //             color: Colors.white,
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   )
                        // ])
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
        // GetAll profile = await api.user(Api.refreshTokenURL, params, "");
        // if (profile.jwtToken != null) {
        //   sharedPreferences = await SharedPreferences.getInstance();
        //   sharedPreferences.setString("jwtToken", profile.jwtToken!);
        //   print("refresh token${profile.jwtToken}");
        //   getDataFromNetwork();
        // }
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
