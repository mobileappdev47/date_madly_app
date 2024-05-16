import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/api/additinal_details_api.dart';
import 'package:date_madly_app/api/add_like_dislike.dart';
import 'package:date_madly_app/api/filter_api.dart';
import 'package:date_madly_app/common/common_gradient_button.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/db/chatroom.dart';
import 'package:date_madly_app/models/add_like_dislike_model.dart';
import 'package:date_madly_app/pages/home/image_scroll.dart';
import 'package:date_madly_app/pages/home/lady_bottomsheet.dart';
import 'package:date_madly_app/pages/home/likes_you_screen.dart';
import 'package:date_madly_app/pages/home/widget/drawer.dart';
import 'package:date_madly_app/pages/new_match/new_match_screen.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/asset.dart';
import 'package:date_madly_app/utils/enum/api_request_status.dart';
import 'package:date_madly_app/utils/font_family.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../api/get_All_api.dart';
import '../../models/user_model.dart';
import '../../providers/home_main_provider.dart';

import '../../utils/colors.dart';

import '../../utils/texts.dart';
import '../likes/main.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:geocoding/geocoding.dart';
import 'package:date_madly_app/pages/me/main.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectGender;
  Map<String, dynamic> body = {};
  Map<String, dynamic> filterBody = {};
  SfRangeValues values = SfRangeValues(20, 20);
  CardSwiperController cardSwiperController = CardSwiperController();
  List swipeList = [
    AssertRe.homelady,
    AssertRe.homelady,
    AssertRe.homelady,
  ];
  bool loder = false;
  GetAllUser getAll = GetAllUser();

  List<User> remainingUsers = [];

  int cardIndex = 0;
  AdditinalDetail additinalDetail = AdditinalDetail();
  AddLikeDislikeModel addLikeDislikeModel = AddLikeDislikeModel();

  @override
  void initState() {
    super.initState();
    getCurrentLatLang();
    getallapicall();
    getNotification();
  }

  String locationData = '';
  String lat = '';
  String long = '';

  Future getCurrentLatLang() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      LocationPermission result = await Geolocator.requestPermission();
      if (result == LocationPermission.always ||
          result == LocationPermission.whileInUse) {
        getCurrentLatLang();
      }
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      lat = position.latitude.toString();
      long = position.longitude.toString();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(lat),
        double.parse(long),
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        print(
            'Place: ${place.name}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}');
        locationData = place.administrativeArea! + ' , ' + place.country!;
      } else {
        print('No place found for the given coordinates.');
      }
    }
  }

  filterApiCall(filterBody) async {
remainingUsers.clear();

    Navigator.pop(context);
    try {
      loder = true;
      setState(() {});
      getAll = await FilterApi.filterApi(filterBody, context);

      remainingUsers = getAll.users ?? [];
      loder = false;
      setState(() {});
    } catch (e) {
      loder = false;
      setState(() {});
      print('==============>${e.toString()}');
    }
  }

  int status = 0;
  double _currentSliderValue = 0;
  double ageValue = 0;
  var currentindex1 = -1;
  List distanceList = [];

  getallapicall() async {
    try {
      distanceList.clear();
      loder = true;
      setState(() {});

      // getAll = await GetAllApi.getallApi();

      getAll = await FilterApi.filterApi({

        'distance': 10,
        "userId": PrefService.getString(PrefKeys.userId),
        "latitude": lat,
        "longitude": long,

      }, context);

      if (getAll.users != null) {
        for (int i = 0; i < getAll.users!.length; i++) {
          if (getAll.users![i].latitude != null && getAll.users![i].longitude != null) {
            double distance = calculateDistance(
              double.parse(PrefService.getString(PrefKeys.lat)),
              double.parse(PrefService.getString(PrefKeys.long)),
              double.parse(getAll.users![i].latitude.toString()),
              double.parse(getAll.users![i].longitude.toString()),
            );
            distanceList.add(distance.toStringAsFixed(0).toString() + ' KM ');
          } else {
            distanceList.add('');
          }
        }
      }

      remainingUsers = getAll.users ?? [];
      loder = false;

      setState(() {});
    } catch (e) {
      loder = false;
      setState(() {});
      print('===>${e.toString()}');
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371.0; // Radius of the Earth in kilometers

    // Convert degrees to radians
    lat1 = degreesToRadians(lat1);
    lon1 = degreesToRadians(lon1);
    lat2 = degreesToRadians(lat2);
    lon2 = degreesToRadians(lon2);

    // Calculate the differences
    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;

    // Haversine formula
    double a =
        pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    double distance = earthRadius * c;

    print(distance);
    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  getNotification() {
    HomeMainProvider homeMainProvider =
        Provider.of<HomeMainProvider>(context, listen: false);

    homeMainProvider.getNotification(context);
  }

  LikeDislikeapicall(String? id, int status) async {
    print('hy');
    try {
      // loder = true;
      // setState(() {});
      addLikeDislikeModel =
          await AddLikedDislikeProfileApi.addLikedDislikeProfileapi(id, status);

      // loder = false;
      // setState(() {});
    } catch (e) {
      // loder = false;
      // setState(() {});
      print('==============>${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {

    print(PrefService.getString(PrefKeys.userId));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Consumer<HomeMainProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorRes.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset(
                  AssertRe.drawer,
                  color: ColorRes.appColor,
                  scale: 3,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Text(
            'Near By',
            style: mulishbold.copyWith(
              fontSize: 18.75,
              color: ColorRes.appColor,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                onPressed: () {
                  value.showNotificationContainer(context);
                },
                icon: Image.asset(
                  AssertRe.notification,
                  scale: 2.5,
                  color: ColorRes.appColor,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            backgroundColor: Colors.white,
            child: Consumer<HomeMainProvider>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          AssertRe.drawer,
                          scale: 3,
                          color: ColorRes.appColor,
                        ),
                        Text(
                          Strings.filter,
                          style: mulish14400.copyWith(
                              color: ColorRes.appColor,
                              fontSize: 16,
                              fontFamily: Fonts.mulishBold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Strings.gender,
                          style: mulish14400.copyWith(
                              color: ColorRes.darkGrey,
                              fontSize: 16,
                              fontFamily: Fonts.mulishBold),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    SizedBox(
                      height: 45,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Strings.genders.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentindex1 = index;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(65),
                                      border: Border.all(
                                          color: index == currentindex1
                                              ? ColorRes.appColor
                                              : ColorRes.grey),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AssertRe.genderIcon[index],
                                          scale: 3,
                                          color: index == currentindex1
                                              ? ColorRes.appColor
                                              : ColorRes.grey,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          Strings.genders[index],
                                          style: mulish14400.copyWith(
                                            fontFamily: Fonts.mulishBold,
                                            fontSize: 12.4,
                                            color: index == currentindex1
                                                ? ColorRes.appColor
                                                : ColorRes.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width / 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(67),
                          border: Border.all(color: ColorRes.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            AssertRe.Location_Icon,
                            scale: 4,
                            color: ColorRes.appColor,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 30,
                          ),
                          Text(
                            locationData,
                            style: mulish14400.copyWith(
                              color: ColorRes.darkGrey,
                              fontSize: 14.06,
                              fontFamily: Fonts.mulishRegular,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Strings.distance,
                          style: mulish14400.copyWith(
                              color: ColorRes.darkGrey,
                              fontSize: 16.41,
                              fontFamily: Fonts.mulishBold),
                        )),
                    Row(
                      children: [
                        Container(
                          width: 220,
                          child: SfSliderTheme(
                            data: SfSliderThemeData(
                              tooltipBackgroundColor: ColorRes.appColor,
                              thumbStrokeWidth: 2,
                              thumbStrokeColor: ColorRes.white,
                            ),
                            child: SfSlider(
                              value: _currentSliderValue,
                              onChanged: (value) {
                                setState(() {
                                  _currentSliderValue = value;
                                });
                              },
                              min: 0,
                              max: 50,
                              thumbIcon: Image.asset(
                                AssertRe.slidericon,
                                scale: 2,
                                color: ColorRes.appColor,
                              ),
                              activeColor: ColorRes.appColor.withOpacity(0.9),
                              inactiveColor: ColorRes.colorF1F2F2,
                              enableTooltip: true,
                              tooltipShape: const SfRectangularTooltipShape(),
                              tooltipTextFormatterCallback:
                                  (dynamic actualValue, String formattedText) {
                                var myVal =
                                    double.parse(actualValue.toString());
                                return '${myVal.toStringAsFixed(0).toString()}';
                              },
                            ),
                          ),
                        ),
                        //SizedBox(width: 25,),
                        Text(
                          Strings.distancerange,
                          style: mulish14400.copyWith(color: ColorRes.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Strings.age,
                          style: mulish14400.copyWith(
                              color: ColorRes.darkGrey,
                              fontSize: 16.41,
                              fontFamily: Fonts.mulishBold),
                        )),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 220,
                    //       child: Slider(
                    //         value: ageValue,
                    //         min: 0,
                    //         max: 150,
                    //         //  divisions: 10,
                    //         label: ageValue.round().toString(),
                    //         onChanged: (double value) {
                    //           setState(() {
                    //             ageValue = value;
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //     //SizedBox(width: 25,),
                    //     Text(
                    //       Strings.agerange,
                    //       style: mulish14400.copyWith(color: ColorRes.grey),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Container(
                          width: 220,
                          child: SfRangeSliderTheme(
                            data: SfRangeSliderThemeData(
                              tooltipBackgroundColor: ColorRes.appColor,
                              thumbStrokeWidth: 2,
                              thumbStrokeColor: ColorRes.white,

                            ),
                            child: SfRangeSlider(
                              inactiveColor: ColorRes.colorF1F2F2,
                              tooltipTextFormatterCallback:
                                  (dynamic actualValue, String formattedText) {
                                var myVal =
                                    double.parse(actualValue.toString());
                                return '${myVal.toStringAsFixed(0).toString()}';
                              },
                              min: 20.0,
                              max: 70.0,
                              interval: 1,
                              enableTooltip: true,
                              tooltipShape: const SfRectangularTooltipShape(),
                              endThumbIcon: ClipOval(
                                  child: Container(
                                color: ColorRes.appColor,
                                width: 40,
                                height: 40,
                              )),
                              startThumbIcon: ClipOval(
                                  child: Container(
                                color: ColorRes.appColor,
                                width: 40,
                                height: 40,
                              )),
                              activeColor: ColorRes.appColor.withOpacity(0.9),
                              values: values,
                              onChanged: (SfRangeValues newValues) {
                                values = newValues;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        //SizedBox(width: 25,),
                        Text(
                          Strings.agerange,
                          style: mulish14400.copyWith(color: ColorRes.grey),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () async {
                    //     filterBody = {};
                    //     print(filterBody);
                    //     filterBody['latitude'] = lat;
                    //     filterBody['longitude'] = long;
                    //
                    //     if (currentindex1 != -1) {
                    //       filterBody['gender'] =
                    //           currentindex1 == 0 ? 'Male' : "female";
                    //     }
                    //     if (_currentSliderValue != 0) {
                    //       filterBody['distance'] =
                    //           _currentSliderValue.toInt().toString();
                    //     }
                    //     print(values.end);
                    //     if (values.start == 20 && values.end == 20) {
                    //       print('no');
                    //     } else {
                    //       double minimumAge =
                    //           double.parse(values.start.toString());
                    //       double maximumAge =
                    //           double.parse(values.end.toString());
                    //
                    //       filterBody['minAge'] = minimumAge.toInt().toString();
                    //       filterBody['maxAge'] = maximumAge.toInt().toString();
                    //     }
                    //
                    //     print(filterBody);
                    //
                    //     await filterApiCall(filterBody);
                    //   },
                    //   child: Container(
                    //     height: 55,
                    //     width: MediaQuery.of(context).size.width / 1.5,
                    //     decoration: BoxDecoration(
                    //         color: ColorRes.appColor,
                    //         borderRadius: BorderRadius.circular(8)),
                    //     child: Center(
                    //         child: Text(
                    //       Strings.COntinue,
                    //       style: poppins.copyWith(
                    //           fontSize: 16, color: Colors.white),
                    //     )),
                    //   ),
                    // ),
                    CommonGradientButton(
                      ontap: () async {
                        filterBody = {};
                        print(filterBody);
                        filterBody['userId']=PrefService.getString(PrefKeys.userId);
                        filterBody['latitude'] = lat;
                        filterBody['longitude'] = long;

                        if (currentindex1 != -1) {
                          filterBody['gender'] =
                              currentindex1 == 0 ? 'Male' : "Female";
                        }
                        if (_currentSliderValue != 0) {
                          filterBody['distance'] =
                              _currentSliderValue.toInt().toString();
                        }
                        print(values.end);
                        if (values.start == 20 && values.end == 20) {
                          print('no');
                        } else {
                          double minimumAge =
                              double.parse(values.start.toString());
                          double maximumAge =
                              double.parse(values.end.toString());

                          filterBody['minAge'] = minimumAge.toInt().toString();
                          filterBody['maxAge'] = maximumAge.toInt().toString();
                        }

                        print(filterBody);

                        await filterApiCall(filterBody);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        currentindex1 = -1;
                        _currentSliderValue = 0;
                        values = SfRangeValues(20, 20);
                        setState(() {});
                      },
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0,
                                offset: Offset(2, 2),
                                color: ColorRes.color939393.withOpacity(0.25),
                                blurRadius: 10,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(67)),
                        child: Center(
                            child: Text(
                          Strings.clear,
                          style: poppins.copyWith(
                              fontSize: 16, color: ColorRes.grey),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            )),
        body: Consumer<HomeMainProvider>(
          builder: (context, value, child) => Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                     remainingUsers.isNotEmpty /*&& remainingUsers.length > 1*/
                      ?remainingUsers.length == 1?

                     Expanded(
                       child:

                       CardSwiper(

                         controller: cardSwiperController,
                         isLoop: false,
                         isDisabled: false,
                         backCardOffset: const Offset(10, 0),
                         initialIndex: 0,
                         padding: EdgeInsets.zero,
                         cardsCount: 2,
                         onSwipe:
                             (previousIndex, currentIndex, direction) async {

                             if(currentIndex!=null){
                               cardIndex = currentIndex!;
                               setState(() {});
                               var index1 = currentIndex - 1;
                               if (direction == CardSwiperDirection.left) {
                                 LikeDislikeapicall(
                                     remainingUsers[index1].id, 1);

                                 setState(() {

                                 });
                               }
                               else if (direction ==
                                   CardSwiperDirection.right) {
                                 LikeDislikeapicall(
                                     remainingUsers[index1].id, 0);
                                 setState(() {});
                               } else {}
                             }


                           return true;

                         },
                         cardBuilder: (context,
                             index,
                             horizontalOffsetPercentage,
                             verticalOffsetPercentage) {
                           if(index == 0){          final user = remainingUsers[index];

                           return Column(
                             children: [
                               Expanded(
                                 child: GestureDetector(
                                   child: Container(
                                     width:
                                     MediaQuery.of(context).size.width,
                                     decoration: BoxDecoration(
                                       // color: Colors.pink,
                                       borderRadius: BorderRadius.only(
                                         bottomLeft: Radius.circular(40),
                                         bottomRight: Radius.circular(
                                           40,
                                         ),
                                         topRight: Radius.circular(40),
                                         topLeft: Radius.circular(
                                           40,
                                         ),
                                       ),
                                     ),
                                     child: Stack(
                                       alignment: Alignment.bottomCenter,
                                       children: [
                                         getAll.users != null &&
                                             getAll.users![index]
                                                 .images !=
                                                 null
                                             ? ClipRRect(
                                           borderRadius:
                                           BorderRadius.circular(
                                               30),
                                           child: CachedNetworkImage(
                                             height: height,
                                             width:
                                             MediaQuery.of(context)
                                                 .size
                                                 .width,
                                             imageUrl: (user.images !=
                                                 null &&
                                                 user.images!
                                                     .isNotEmpty)
                                                 ? user.images![0]
                                                 : '',
                                             fit: BoxFit.fill,
                                             placeholder:
                                                 (context, url) =>
                                                 Image.asset(
                                                   'assets/images/image_placeholder.png',
                                                   height: height,
                                                   width: MediaQuery.of(
                                                       context)
                                                       .size
                                                       .width,
                                                   fit: BoxFit.fill,
                                                 ),
                                             errorWidget: (context,
                                                 url, error) =>
                                                 Image.asset(
                                                   'assets/images/image_placeholder.png',
                                                   height: height,
                                                   width: MediaQuery.of(
                                                       context)
                                                       .size
                                                       .width,
                                                   fit: BoxFit.fill,
                                                 ),
                                           ),
                                         )
                                             : SizedBox(),
                                         Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                           child: Column(
                                             crossAxisAlignment:
                                             CrossAxisAlignment.start,
                                             children: [
                                               Spacer(),
                                               SizedBox(
                                                 height: 10,
                                               ),
                                               Text(
                                                 getAll.users != null &&
                                                     getAll.users![index]
                                                         .name !=
                                                         null
                                                     ? user.name!
                                                     : 'No Name',
                                                 style: mulishbold.copyWith(
                                                   color: ColorRes.white,
                                                   fontSize: 20,
                                                 ),
                                               ),
                                               Text(
                                                 getAll.users != null &&
                                                     getAll.users![index]
                                                         .name !=
                                                         null
                                                     ? user.name!
                                                     : Strings.modelfashion,
                                                 style: mulish14400.copyWith(
                                                   fontSize: 12,
                                                   color: ColorRes.white,
                                                 ),
                                               ),
                                               SizedBox(
                                                 height: 3,
                                               ),
                                               Row(
                                                 children: [
                                                   Image.asset(
                                                     AssertRe.Location_Icon,
                                                     scale: 4.5,
                                                     color: ColorRes.white,
                                                   ),
                                                   SizedBox(
                                                     width: 10,
                                                   ),
                                                   Text(
                                                     distanceList[index] ?? '',
                                                     style:
                                                     mulish14400.copyWith(
                                                       fontSize: 12,
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                               SizedBox(height: 20,),
                                               Padding(
                                                 padding: const EdgeInsets.symmetric(horizontal: 20),
                                                 child: Row(

                                                   children: [
                                                     GestureDetector(
                                                       onTap: () async {
                                                         LikeDislikeapicall(
                                                             remainingUsers[cardIndex].id, 1);
                                                         cardSwiperController.swipeLeft();
                                                       },
                                                       child: Container(
                                                         height: 50,
                                                         width: 50,
                                                         decoration: BoxDecoration(
                                                             boxShadow: [
                                                               BoxShadow(
                                                                 color: Colors.grey.withOpacity(0.5),
                                                                 spreadRadius: 1,
                                                                 blurRadius: 2,
                                                                 offset: Offset(0,
                                                                     3), // changes position of shadow
                                                               ),
                                                             ],
                                                             borderRadius: BorderRadius.circular(50),
                                                             color: Colors.grey.shade50),
                                                         child: Icon(
                                                           Icons.close,
                                                           color: ColorRes.darkGrey,
                                                         ),
                                                       ),
                                                     ),
                                                     Spacer(),
                                                     GestureDetector(
                                                       onTap: () async {
                                                         LikeDislikeapicall(
                                                             remainingUsers[cardIndex].id, 0);
                                                         cardSwiperController.swipeRight();
                                                         setState(() {});
                                                       },
                                                       child: Container(
                                                         height: 50,
                                                         width: 50,
                                                         decoration: BoxDecoration(
                                                             borderRadius: BorderRadius.circular(50),
                                                             color: ColorRes.appColor,

                                                             gradient: LinearGradient(
                                                               begin: Alignment.topCenter,
                                                               end: Alignment.bottomCenter,
                                                               colors: [
                                                                 Color(0xffED1E79,),
                                                                 Color(0xffC1272D,),
                                                               ],
                                                             ),




                                                             boxShadow:  [ BoxShadow(
                                                               color: Colors.grey.withOpacity(0.5),
                                                               spreadRadius: 1,
                                                               blurRadius: 2,
                                                               offset: Offset(0,
                                                                   3), // changes position of shadow
                                                             ),]
                                                         ),
                                                         child: Icon(
                                                           Icons.favorite_border,
                                                           color: ColorRes.white,
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 ),

                                               ),
                                               SizedBox(height: 20,),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                   onTap: () {
                                     // ladyBottomSheetUI(
                                     //     context, getAll, index);
                                     double width = MediaQuery.of(context).size.width;
                                     double height = MediaQuery.of(context).size.height;
                                     showModalBottomSheet<dynamic>(
                                       backgroundColor: Colors.white,
                                       isScrollControlled: true,
                                       shape: const RoundedRectangleBorder(
                                         borderRadius: BorderRadius.vertical(
                                           top: Radius.circular(12),
                                         ),
                                       ),
                                       context: context,
                                       builder: (context) {
                                         List dataList = [];

                                         if (getAll.users![index].gender != '' &&
                                             getAll.users![index].gender != null) {
                                           dataList.add({
                                             'data': 'Gender',
                                             'detail': getAll.users![index].gender,
                                           });
                                         }
                                         if (getAll.users![index].college != '' &&
                                             getAll.users![index].college != null) {
                                           dataList.add({
                                             'data': 'College',
                                             'detail': getAll.users![index].college,
                                           });
                                         }
                                         if (getAll.users![index].job != '' && getAll.users![index].job != null) {
                                           dataList.add({
                                             'data': 'Designation',
                                             'detail': getAll.users![index].job,
                                           });
                                         }
                                         if (getAll.users![index].profileScore != '' &&
                                             getAll.users![index].profileScore != null) {
                                           dataList.add({
                                             'data': 'Profile Score',
                                             'detail': getAll.users![index].profileScore.toString(),
                                           });
                                         }
                                         if (getAll.users![index].company != '' &&
                                             getAll.users![index].company != null) {
                                           dataList.add({
                                             'data': 'Company',
                                             'detail': getAll.users![index].company,
                                           });
                                         }
                                         HomeMainProvider homeMainProvider =
                                         Provider.of<HomeMainProvider>(context, listen: false);
                                         GlobalKey<_HomeState> homeKey = GlobalKey<_HomeState>();
                                         return Wrap(
                                           children: [
                                             Stack(
                                               alignment: Alignment.bottomCenter,
                                               children: [
                                                 Stack(
                                                   children: [
                                                     Column(
                                                       mainAxisAlignment: MainAxisAlignment.start,
                                                       children: [
                                                         Container(
                                                           height: MediaQuery.of(context).size.height * 0.6,
                                                           child: CachedNetworkImage(
                                                             imageUrl:
                                                             '${getAll.users![index].images != null && getAll.users![index].images!.isNotEmpty ? getAll.users![index].images![0] : ''}',
                                                             fit: BoxFit.fill,
                                                             width: MediaQuery.of(context).size.width,
                                                             height: MediaQuery.of(context).size.height * 0.6,
                                                             placeholder: (context, url) => Image.asset(
                                                               'assets/images/image_placeholder.png',
                                                               width: MediaQuery.of(context).size.width,
                                                               height: MediaQuery.of(context).size.height * 0.6,
                                                               fit: BoxFit.fill,
                                                             ),
                                                             errorWidget: (context, url, error) => Image.asset(
                                                               'assets/images/image_placeholder.png',
                                                               width: MediaQuery.of(context).size.width,
                                                               height: MediaQuery.of(context).size.height * 0.6,
                                                               fit: BoxFit.fill,
                                                             ),
                                                           ),
                                                         ),
                                                         Container(
                                                           height: MediaQuery.of(context).size.height * 0.4,
                                                         ),
                                                       ],
                                                     ),
                                                     GestureDetector(
                                                       onTap: () {
                                                         Navigator.pop(context);
                                                       },
                                                       child: Padding(
                                                         padding: const EdgeInsets.only(left: 20, top: 30),
                                                         child: Icon(
                                                           Icons.arrow_back_ios_sharp,
                                                           color: Colors.white,
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                                 Stack(
                                                   alignment: Alignment.bottomCenter,
                                                   children: [
                                                     Container(
                                                       height: height * 0.64,
                                                       // color: Colors.white10,
                                                       width: width,
                                                       child: Stack(
                                                         children: [
                                                           Container(
                                                             margin: EdgeInsets.only(top: 35),
                                                             padding: EdgeInsets.symmetric(
                                                                 horizontal: 10, vertical: 20),
                                                             height: height * 0.6,
                                                             width: width,
                                                             decoration: BoxDecoration(
                                                               borderRadius: BorderRadius.only(
                                                                 topRight: Radius.circular(30),
                                                                 topLeft: Radius.circular(30),
                                                               ),
                                                               color: Colors.white,
                                                             ),
                                                             child: SingleChildScrollView(
                                                               child: Column(
                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                 children: [
                                                                   Row(
                                                                     children: [
                                                                       Text(
                                                                         getAll.users?[index].name ?? "",
                                                                         style: mulish14400.copyWith(
                                                                           fontSize: 24,
                                                                           fontWeight: FontWeight.w600,
                                                                           color: ColorRes.darkGrey,
                                                                         ),
                                                                       ),

                                                                     ],
                                                                   ),

                                                                   SizedBox(
                                                                     height: 20,
                                                                   ),

                                                                   Row(
                                                                     children: [
                                                                       SizedBox(
                                                                         width: MediaQuery.of(context).size.width* 0.4,
                                                                         child: Row(
                                                                           children: [
                                                                             getAll.users![index].job != null &&
                                                                                 getAll.users![index].job != ''
                                                                                 ? Image.asset(
                                                                               'assets/icons/Worrk_Icon.png',
                                                                               height: 18,
                                                                               width: 18,
                                                                               fit: BoxFit.contain,
                                                                             )
                                                                                 : SizedBox(),
                                                                             SizedBox(
                                                                               width: 1.5,
                                                                             ),
                                                                             Expanded(
                                                                               child: Text(
                                                                                 getAll.users![index].job ?? '',
                                                                                 style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),


                                                                               ),
                                                                             ),
                                                                           ],
                                                                         ),
                                                                       ),
                                                                       SizedBox(width: 7,),
                                                                       Expanded(
                                                                         child: SizedBox(
                                                                           child:
                                                                           Row(
                                                                             children: [
                                                                               getAll.users![index].company!= null &&
                                                                                   getAll.users![index].company != ''
                                                                                   ? Image.asset(
                                                                                 'assets/icons/Company.png',
                                                                                 height: 18,
                                                                                 width: 18,
                                                                                 fit: BoxFit.contain,
                                                                               )
                                                                                   : SizedBox(),
                                                                               SizedBox(
                                                                                 width: 1.5,
                                                                               ),
                                                                               Expanded(
                                                                                 child: Text(
                                                                                   getAll.users![index].company ?? '',
                                                                                   style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),
                                                                                 ),
                                                                               ),
                                                                             ],
                                                                           ),
                                                                         ),
                                                                       ),
                                                                     ],
                                                                   ),
                                                                   SizedBox(
                                                                     height: 10,
                                                                   ),
                                                                   Row(
                                                                     children: [
                                                                       SizedBox(
                                                                         width: MediaQuery.of(context).size.width* 0.4,

                                                                         child:
                                                                         Row(
                                                                           children: [
                                                                             getAll.users![index].location != null &&
                                                                                 getAll.users![index].location != ''
                                                                                 ? Image.asset(
                                                                               'assets/icons/Location_Icon.png',
                                                                               height: 20,
                                                                               width: 18,
                                                                               fit: BoxFit.contain,
                                                                             )
                                                                                 : SizedBox(),
                                                                             SizedBox(
                                                                               width: 1.5,
                                                                             ),
                                                                             Expanded(
                                                                               child: Text(
                                                                                 getAll.users![index].location ?? '',
                                                                                 style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),
                                                                               ),
                                                                             ),
                                                                           ],
                                                                         ),
                                                                       ),
                                                                       SizedBox(width: 7,),

                                                                       Expanded(
                                                                         child: SizedBox(
                                                                           width: MediaQuery.of(context).size.width* 0.4,
                                                                           child: Row(
                                                                             children: [

                                                                               getAll.users![index].college != null &&
                                                                                   getAll.users![index].college != ''
                                                                                   ? Image.asset(
                                                                                 'assets/icons/Education_Icon.png',
                                                                                 height: 18,
                                                                                 width: 18,
                                                                                 fit: BoxFit.contain,
                                                                               )
                                                                                   : SizedBox(),
                                                                               SizedBox(
                                                                                 width: 1.5,
                                                                               ),
                                                                               Expanded(
                                                                                 child: Text(
                                                                                   getAll.users![index].college ?? '',
                                                                                   style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),

                                                                                 ),
                                                                               )
                                                                             ],
                                                                           ),
                                                                         ),
                                                                       ),
                                                                     ],
                                                                   ),



                                                                   SizedBox(
                                                                     height: 20,
                                                                   ),
                                                                   Row(
                                                                     children: [
                                                                       Text(
                                                                         Strings.gallery,
                                                                         style: mulish14400.copyWith(
                                                                           fontSize: 12,
                                                                           fontWeight: FontWeight.w300,
                                                                           color: ColorRes.darkGrey,
                                                                         ),
                                                                       ),
                                                                       Spacer(),
                                                                       InkWell(
                                                                         child: Text(
                                                                           Strings.seeall,
                                                                           style: mulish14400.copyWith(
                                                                             fontSize: 12,
                                                                             fontWeight: FontWeight.w300,
                                                                             color: ColorRes.appColor,
                                                                           ),
                                                                         ),
                                                                         onTap: () {
                                                                           Navigator.push(
                                                                               context,
                                                                               MaterialPageRoute(
                                                                                 builder: (context) => Profile(
                                                                                     userId:
                                                                                     getAll.users?[index].id ??
                                                                                         ''),
                                                                               ));
                                                                         },
                                                                       ),
                                                                       Icon(
                                                                         Icons.arrow_forward_outlined,
                                                                         color: ColorRes.appColor,
                                                                         size: 15,
                                                                       )
                                                                     ],
                                                                   ),
                                                                   SizedBox(
                                                                     height: 20,
                                                                   ),
                                                                   Container(
                                                                     height: 230,
                                                                     child: GridView.builder(
                                                                       shrinkWrap: true,
                                                                       physics: NeverScrollableScrollPhysics(),
                                                                       gridDelegate:
                                                                       SliverGridDelegateWithFixedCrossAxisCount(
                                                                         crossAxisCount: 2,
                                                                         mainAxisSpacing: 10,
                                                                         crossAxisSpacing: 10,
                                                                         childAspectRatio: 0.7,
                                                                       ),
                                                                       itemCount:
                                                                       getAll.users![index].images!.length,
                                                                       scrollDirection: Axis.vertical,
                                                                       itemBuilder: (context, i) {
                                                                         return ClipRRect(
                                                                           borderRadius: BorderRadius.circular(10),
                                                                           child: CachedNetworkImage(
                                                                             imageUrl: (getAll.users![index]
                                                                                 .images !=
                                                                                 null &&
                                                                                 getAll.users![index].images!
                                                                                     .isNotEmpty)
                                                                                 ? getAll.users![index].images![i]
                                                                                 : '',
                                                                             height: 230,
                                                                             width: 155,
                                                                             fit: BoxFit.cover,
                                                                             errorWidget: (context, url, error) =>
                                                                                 Image.asset(
                                                                                     height: 230,
                                                                                     width: 155,
                                                                                     'assets/images/image_placeholder.png',
                                                                                     fit: BoxFit.cover),
                                                                             placeholder: (context, url) =>
                                                                                 Image.asset(
                                                                                     height: 230,
                                                                                     width: 155,
                                                                                     'assets/images/image_placeholder.png',
                                                                                     fit: BoxFit.cover),
                                                                           ),
                                                                         );
                                                                       },
                                                                     ),
                                                                   ),
                                                                 ],
                                                               ),
                                                             ),
                                                           ),
                                                           SizedBox(
                                                             height: 70,
                                                             child: Row(
                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                               children: [
                                                                 Padding(
                                                                   padding: const EdgeInsets.only(top: 10.0),
                                                                   child: Align(
                                                                     alignment: Alignment.topCenter,
                                                                     child: GestureDetector(
                                                                       onTap: () async {
                                                                         if(getAll.users?[index].id != null) {

                                                                           Navigator.pop(context);
                                                                           LikeDislikeapicall(getAll.users![index].id, 1);
                                                                           cardSwiperController.swipeLeft();
                                                                         }

                                                                       },
                                                                       child: Container(
                                                                         height: 50,
                                                                         width: 50,
                                                                         decoration: BoxDecoration(
                                                                             boxShadow: [
                                                                               BoxShadow(
                                                                                 color: Colors.grey.withOpacity(0.5),
                                                                                 spreadRadius: 1,
                                                                                 blurRadius: 2,
                                                                                 offset: Offset(
                                                                                     0, 3), // changes position of shadow
                                                                               ),
                                                                             ],
                                                                             borderRadius: BorderRadius.circular(50),
                                                                             color: Colors.grey.shade50),
                                                                         child: Icon(
                                                                           Icons.close,
                                                                           color: ColorRes.darkGrey,
                                                                         ),
                                                                       ),
                                                                     ),
                                                                   ),
                                                                 ),
                                                                 SizedBox(
                                                                   width: 30,
                                                                 ),
                                                                 Align(
                                                                   alignment: Alignment.topCenter,
                                                                   child: GestureDetector(
                                                                     onTap: () async {
                                                                       if(getAll.users?[index].id != null) {

                                                                         Navigator.pop(context);
                                                                         LikeDislikeapicall(getAll.users![index].id, 0);
                                                                         cardSwiperController.swipeRight();
                                                                       }

                                                                     },
                                                                     child: Container(
                                                                       height: 70,
                                                                       width: 70,
                                                                       decoration: BoxDecoration(
                                                                           borderRadius: BorderRadius.circular(50),
                                                                           color: ColorRes.appColor,
                                                                           gradient: LinearGradient(
                                                                             begin: Alignment.topCenter,
                                                                             end: Alignment.bottomCenter,
                                                                             colors: [
                                                                               Color(
                                                                                 0xffED1E79,
                                                                               ),
                                                                               Color(
                                                                                 0xffC1272D,
                                                                               ),
                                                                             ],
                                                                           ),
                                                                           boxShadow: [
                                                                             BoxShadow(
                                                                               color: Colors.grey.withOpacity(0.5),
                                                                               spreadRadius: 1,
                                                                               blurRadius: 2,
                                                                               offset: Offset(
                                                                                   0, 3), // changes position of shadow
                                                                             ),
                                                                           ]),
                                                                       child: Icon(
                                                                         Icons.favorite_border,
                                                                         color: ColorRes.white,
                                                                       ),
                                                                     ),
                                                                   ),
                                                                 ),
                                                                 SizedBox(
                                                                   width: 30,
                                                                 ),
                                                                 Padding(
                                                                   padding: const EdgeInsets.only(top: 10.0),
                                                                   child: Align(
                                                                     alignment: Alignment.topCenter,
                                                                     child: Container(
                                                                       height: 50,
                                                                       width: 50,
                                                                       decoration: BoxDecoration(
                                                                           boxShadow: [
                                                                             BoxShadow(
                                                                               color: Colors.grey.withOpacity(0.5),
                                                                               spreadRadius: 1,
                                                                               blurRadius: 2,
                                                                               offset: Offset(
                                                                                   0, 3), // changes position of shadow
                                                                             ),
                                                                           ],
                                                                           borderRadius: BorderRadius.circular(50),
                                                                           color: Colors.grey.shade50),
                                                                       child: Column(
                                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                                         children: [
                                                                           Icon(
                                                                             Icons.favorite_border,
                                                                             color: ColorRes.appColor,
                                                                             size: 18,
                                                                           ),
                                                                           SizedBox(
                                                                             height: 2,
                                                                           ),
                                                                           Text(
                                                                             getAll.users?[index].likes.toString()??'',
                                                                             style: TextStyle(
                                                                                 color: ColorRes.colorACACAC),
                                                                           ),
                                                                         ],
                                                                       ),
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ],
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             ),
                                           ],
                                         );
                                       },
                                     );
                                   },
                                 ),
                               ),
                               SizedBox(
                                 height: 20,
                               ),

                             ],
                           );}
                           else {
                             return SizedBox();
                           }

                         },
                       ),
                     )

                         :
                        Expanded(
                          child:

                          CardSwiper(

                            controller: cardSwiperController,
                             isLoop: false,
                            isDisabled: false,
                            backCardOffset: const Offset(10, 0),
                            initialIndex: 0,
                            padding: EdgeInsets.zero,
                            cardsCount: remainingUsers.length,
                            onSwipe:
                                (previousIndex, currentIndex, direction) async {
                     if(currentIndex!=null){
                       cardIndex = currentIndex!;
                       setState(() {});
                       var index1 = currentIndex - 1;
                       if (direction == CardSwiperDirection.left) {
                         LikeDislikeapicall(
                             remainingUsers[index1].id, 1);

                         setState(() {

                         });
                       }
                       else if (direction ==
                           CardSwiperDirection.right) {
                         LikeDislikeapicall(
                             remainingUsers[index1].id, 0);
                         setState(() {});
                       } else {}
                     }
                              return true;
                            },
                            cardBuilder: (context,
                                index,
                                horizontalOffsetPercentage,
                                verticalOffsetPercentage) {
                              final user = remainingUsers[index];

                              return Column(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          // color: Colors.pink,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(40),
                                            bottomRight: Radius.circular(
                                              40,
                                            ),
                                            topRight: Radius.circular(40),
                                            topLeft: Radius.circular(
                                              40,
                                            ),
                                          ),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            getAll.users != null &&
                                                    getAll.users![index]
                                                            .images !=
                                                        null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: CachedNetworkImage(
                                                      height: height,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      imageUrl: (user.images !=
                                                                  null &&
                                                              user.images!
                                                                  .isNotEmpty)
                                                          ? user.images![0]
                                                          : '',
                                                      fit: BoxFit.fill,
                                                      placeholder:
                                                          (context, url) =>
                                                              Image.asset(
                                                        'assets/images/image_placeholder.png',
                                                        height: height,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                        'assets/images/image_placeholder.png',
                                                        height: height,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Spacer(),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    getAll.users != null &&
                                                            getAll.users![index]
                                                                    .name !=
                                                                null
                                                        ? user.name!
                                                        : 'No Name',
                                                    style: mulishbold.copyWith(
                                                      color: ColorRes.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    getAll.users != null &&
                                                            getAll.users![index]
                                                                    .name !=
                                                                null
                                                        ? user.name!
                                                        : Strings.modelfashion,
                                                    style: mulish14400.copyWith(
                                                      fontSize: 12,
                                                      color: ColorRes.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        AssertRe.Location_Icon,
                                                        scale: 4.5,
                                                        color: ColorRes.white,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        distanceList[index] ?? '',
                                                        style:
                                                            mulish14400.copyWith(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20,),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                                    child: Row(

                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                             LikeDislikeapicall(
                                                                remainingUsers[cardIndex].id, 1);
                                                            cardSwiperController.swipeLeft();
                                                          },
                                                          child: Container(
                                                            height: 50,
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.grey.withOpacity(0.5),
                                                                    spreadRadius: 1,
                                                                    blurRadius: 2,
                                                                    offset: Offset(0,
                                                                        3), // changes position of shadow
                                                                  ),
                                                                ],
                                                                borderRadius: BorderRadius.circular(50),
                                                                color: Colors.grey.shade50),
                                                            child: Icon(
                                                              Icons.close,
                                                              color: ColorRes.darkGrey,
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        GestureDetector(
                                                          onTap: () async {
                                                             LikeDislikeapicall(
                                                                remainingUsers[cardIndex].id, 0);
                                                            cardSwiperController.swipeRight();
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            height: 50,
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(50),
                                                                color: ColorRes.appColor,

                                                              gradient: LinearGradient(
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                                colors: [
                                                                  Color(0xffED1E79,),
                                                                  Color(0xffC1272D,),
                                                                ],
                                                              ),




                                                           boxShadow:  [ BoxShadow(
                                                             color: Colors.grey.withOpacity(0.5),
                                                             spreadRadius: 1,
                                                             blurRadius: 2,
                                                             offset: Offset(0,
                                                                 3), // changes position of shadow
                                                           ),]
                                                            ),
                                                            child: Icon(
                                                              Icons.favorite_border,
                                                              color: ColorRes.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                  ),
                                                  SizedBox(height: 20,),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        // ladyBottomSheetUI(
                                        //     context, getAll, index);
                                        double width = MediaQuery.of(context).size.width;
                                        double height = MediaQuery.of(context).size.height;
                                        showModalBottomSheet<dynamic>(
                                          backgroundColor: Colors.white,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(12),
                                            ),
                                          ),
                                          context: context,
                                          builder: (context) {
                                            List dataList = [];

                                            if (getAll.users![index].gender != '' &&
                                                getAll.users![index].gender != null) {
                                              dataList.add({
                                                'data': 'Gender',
                                                'detail': getAll.users![index].gender,
                                              });
                                            }
                                            if (getAll.users![index].college != '' &&
                                                getAll.users![index].college != null) {
                                              dataList.add({
                                                'data': 'College',
                                                'detail': getAll.users![index].college,
                                              });
                                            }
                                            if (getAll.users![index].job != '' && getAll.users![index].job != null) {
                                              dataList.add({
                                                'data': 'Designation',
                                                'detail': getAll.users![index].job,
                                              });
                                            }
                                            if (getAll.users![index].profileScore != '' &&
                                                getAll.users![index].profileScore != null) {
                                              dataList.add({
                                                'data': 'Profile Score',
                                                'detail': getAll.users![index].profileScore.toString(),
                                              });
                                            }
                                            if (getAll.users![index].company != '' &&
                                                getAll.users![index].company != null) {
                                              dataList.add({
                                                'data': 'Company',
                                                'detail': getAll.users![index].company,
                                              });
                                            }
                                            HomeMainProvider homeMainProvider =
                                            Provider.of<HomeMainProvider>(context, listen: false);
                                            GlobalKey<_HomeState> homeKey = GlobalKey<_HomeState>();
                                            return Wrap(
                                              children: [
                                                Stack(
                                                  alignment: Alignment.bottomCenter,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              height: MediaQuery.of(context).size.height * 0.6,
                                                              child: CachedNetworkImage(
                                                                imageUrl:
                                                                '${getAll.users![index].images != null && getAll.users![index].images!.isNotEmpty ? getAll.users![index].images![0] : ''}',
                                                                fit: BoxFit.fill,
                                                                width: MediaQuery.of(context).size.width,
                                                                height: MediaQuery.of(context).size.height * 0.6,
                                                                placeholder: (context, url) => Image.asset(
                                                                  'assets/images/image_placeholder.png',
                                                                  width: MediaQuery.of(context).size.width,
                                                                  height: MediaQuery.of(context).size.height * 0.6,
                                                                  fit: BoxFit.fill,
                                                                ),
                                                                errorWidget: (context, url, error) => Image.asset(
                                                                  'assets/images/image_placeholder.png',
                                                                  width: MediaQuery.of(context).size.width,
                                                                  height: MediaQuery.of(context).size.height * 0.6,
                                                                  fit: BoxFit.fill,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: MediaQuery.of(context).size.height * 0.4,
                                                            ),
                                                          ],
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 20, top: 30),
                                                            child: Icon(
                                                              Icons.arrow_back_ios_sharp,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Stack(
                                                      alignment: Alignment.bottomCenter,
                                                      children: [
                                                        Container(
                                                          height: height * 0.64,
                                                          // color: Colors.white10,
                                                          width: width,
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(top: 35),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal: 10, vertical: 20),
                                                                height: height * 0.6,
                                                                width: width,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(30),
                                                                    topLeft: Radius.circular(30),
                                                                  ),
                                                                  color: Colors.white,
                                                                ),
                                                                child: SingleChildScrollView(
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            getAll.users?[index].name ?? "",
                                                                            style: mulish14400.copyWith(
                                                                              fontSize: 24,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: ColorRes.darkGrey,
                                                                            ),
                                                                          ),

                                                                        ],
                                                                      ),

                                                                      SizedBox(
                                                                        height: 20,
                                                                      ),

                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width: MediaQuery.of(context).size.width* 0.4,
                                                                            child: Row(
                                                                              children: [
                                                                                getAll.users![index].job != null &&
                                                                                    getAll.users![index].job != ''
                                                                                    ? Image.asset(
                                                                                  'assets/icons/Worrk_Icon.png',
                                                                                  height: 18,
                                                                                  width: 18,
                                                                                  fit: BoxFit.contain,
                                                                                )
                                                                                    : SizedBox(),
                                                                                SizedBox(
                                                                                  width: 1.5,
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    getAll.users![index].job ?? '',
                                                                                    style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),


                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 7,),
                                                                          Expanded(
                                                                            child: SizedBox(
                                                                              child:
                                                                              Row(
                                                                                children: [
                                                                                  getAll.users![index].company!= null &&
                                                                                      getAll.users![index].company != ''
                                                                                      ? Image.asset(
                                                                                    'assets/icons/Company.png',
                                                                                    height: 18,
                                                                                    width: 18,
                                                                                    fit: BoxFit.contain,
                                                                                  )
                                                                                      : SizedBox(),
                                                                                  SizedBox(
                                                                                    width: 1.5,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      getAll.users![index].company ?? '',
                                                                                      style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width: MediaQuery.of(context).size.width* 0.4,

                                                                            child:
                                                                            Row(
                                                                              children: [
                                                                                getAll.users![index].location != null &&
                                                                                    getAll.users![index].location != ''
                                                                                    ? Image.asset(
                                                                                  'assets/icons/Location_Icon.png',
                                                                                  height: 20,
                                                                                  width: 18,
                                                                                  fit: BoxFit.contain,
                                                                                )
                                                                                    : SizedBox(),
                                                                                SizedBox(
                                                                                  width: 1.5,
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    getAll.users![index].location ?? '',
                                                                                    style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 7,),

                                                                          Expanded(
                                                                            child: SizedBox(
                                                                              width: MediaQuery.of(context).size.width* 0.4,
                                                                              child: Row(
                                                                                children: [

                                                                                  getAll.users![index].college != null &&
                                                                                      getAll.users![index].college != ''
                                                                                      ? Image.asset(
                                                                                    'assets/icons/Education_Icon.png',
                                                                                    height: 18,
                                                                                    width: 18,
                                                                                    fit: BoxFit.contain,
                                                                                  )
                                                                                      : SizedBox(),
                                                                                  SizedBox(
                                                                                    width: 1.5,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      getAll.users![index].college ?? '',
                                                                                      style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),

                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),



                                                                      SizedBox(
                                                                        height: 20,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            Strings.gallery,
                                                                            style: mulish14400.copyWith(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w300,
                                                                              color: ColorRes.darkGrey,
                                                                            ),
                                                                          ),
                                                                          Spacer(),
                                                                          InkWell(
                                                                            child: Text(
                                                                              Strings.seeall,
                                                                              style: mulish14400.copyWith(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w300,
                                                                                color: ColorRes.appColor,
                                                                              ),
                                                                            ),
                                                                            onTap: () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => Profile(
                                                                                        userId:
                                                                                        getAll.users?[index].id ??
                                                                                            ''),
                                                                                  ));
                                                                            },
                                                                          ),
                                                                          Icon(
                                                                            Icons.arrow_forward_outlined,
                                                                            color: ColorRes.appColor,
                                                                            size: 15,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: 20,
                                                                      ),
                                                                      Container(
                                                                        height: 230,
                                                                        child: GridView.builder(
                                                                          shrinkWrap: true,
                                                                          physics: NeverScrollableScrollPhysics(),
                                                                          gridDelegate:
                                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount: 2,
                                                                            mainAxisSpacing: 10,
                                                                            crossAxisSpacing: 10,
                                                                            childAspectRatio: 0.7,
                                                                          ),
                                                                          itemCount:
                                                                          getAll.users![index].images!.length,
                                                                          scrollDirection: Axis.vertical,
                                                                          itemBuilder: (context, i) {
                                                                            return ClipRRect(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: (getAll.users![index]
                                                                                    .images !=
                                                                                    null &&
                                                                                    getAll.users![index].images!
                                                                                        .isNotEmpty)
                                                                                    ? getAll.users![index].images![i]
                                                                                    : '',
                                                                                height: 230,
                                                                                width: 155,
                                                                                fit: BoxFit.cover,
                                                                                errorWidget: (context, url, error) =>
                                                                                    Image.asset(
                                                                                        height: 230,
                                                                                        width: 155,
                                                                                        'assets/images/image_placeholder.png',
                                                                                        fit: BoxFit.cover),
                                                                                placeholder: (context, url) =>
                                                                                    Image.asset(
                                                                                        height: 230,
                                                                                        width: 155,
                                                                                        'assets/images/image_placeholder.png',
                                                                                        fit: BoxFit.cover),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 70,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 10.0),
                                                                      child: Align(
                                                                        alignment: Alignment.topCenter,
                                                                        child: GestureDetector(
                                                                          onTap: () async {
                                                                            if(getAll.users?[index].id != null) {

                                                                              Navigator.pop(context);
                                                                                  LikeDislikeapicall(getAll.users![index].id, 1);
                                                                              cardSwiperController.swipeLeft();
                                                                            }

                                                                          },
                                                                          child: Container(
                                                                            height: 50,
                                                                            width: 50,
                                                                            decoration: BoxDecoration(
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    color: Colors.grey.withOpacity(0.5),
                                                                                    spreadRadius: 1,
                                                                                    blurRadius: 2,
                                                                                    offset: Offset(
                                                                                        0, 3), // changes position of shadow
                                                                                  ),
                                                                                ],
                                                                                borderRadius: BorderRadius.circular(50),
                                                                                color: Colors.grey.shade50),
                                                                            child: Icon(
                                                                              Icons.close,
                                                                              color: ColorRes.darkGrey,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 30,
                                                                    ),
                                                                    Align(
                                                                      alignment: Alignment.topCenter,
                                                                      child: GestureDetector(
                                                                        onTap: () async {
                                                                          if(getAll.users?[index].id != null) {

                                                                            Navigator.pop(context);
                                                                                LikeDislikeapicall(getAll.users![index].id, 0);
                                                                           cardSwiperController.swipeRight();
                                                                          }

                                                                        },
                                                                        child: Container(
                                                                          height: 70,
                                                                          width: 70,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                              color: ColorRes.appColor,
                                                                              gradient: LinearGradient(
                                                                                begin: Alignment.topCenter,
                                                                                end: Alignment.bottomCenter,
                                                                                colors: [
                                                                                  Color(
                                                                                    0xffED1E79,
                                                                                  ),
                                                                                  Color(
                                                                                    0xffC1272D,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Colors.grey.withOpacity(0.5),
                                                                                  spreadRadius: 1,
                                                                                  blurRadius: 2,
                                                                                  offset: Offset(
                                                                                      0, 3), // changes position of shadow
                                                                                ),
                                                                              ]),
                                                                          child: Icon(
                                                                            Icons.favorite_border,
                                                                            color: ColorRes.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 30,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 10.0),
                                                                      child: Align(
                                                                        alignment: Alignment.topCenter,
                                                                        child: Container(
                                                                          height: 50,
                                                                          width: 50,
                                                                          decoration: BoxDecoration(
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Colors.grey.withOpacity(0.5),
                                                                                  spreadRadius: 1,
                                                                                  blurRadius: 2,
                                                                                  offset: Offset(
                                                                                      0, 3), // changes position of shadow
                                                                                ),
                                                                              ],
                                                                              borderRadius: BorderRadius.circular(50),
                                                                              color: Colors.grey.shade50),
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.favorite_border,
                                                                                color: ColorRes.appColor,
                                                                                size: 18,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 2,
                                                                              ),
                                                                              Text(
                                                                                getAll.users?[index].likes.toString()??'',
                                                                                style: TextStyle(
                                                                                    color: ColorRes.colorACACAC),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                ],
                              );
                            },
                          ),
                        )
                      : SizedBox(),

                ],
              ),
              loder == true
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
ladyBottomSheetUI(BuildContext context, GetAllUser getAll, int index) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  showModalBottomSheet<dynamic>(
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    context: context,
    builder: (context) {
      List dataList = [];

      if (getAll.users![index].gender != '' &&
          getAll.users![index].gender != null) {
        dataList.add({
          'data': 'Gender',
          'detail': getAll.users![index].gender,
        });
      }
      if (getAll.users![index].college != '' &&
          getAll.users![index].college != null) {
        dataList.add({
          'data': 'College',
          'detail': getAll.users![index].college,
        });
      }
      if (getAll.users![index].job != '' && getAll.users![index].job != null) {
        dataList.add({
          'data': 'Designation',
          'detail': getAll.users![index].job,
        });
      }
      if (getAll.users![index].profileScore != '' &&
          getAll.users![index].profileScore != null) {
        dataList.add({
          'data': 'Profile Score',
          'detail': getAll.users![index].profileScore.toString(),
        });
      }
      if (getAll.users![index].company != '' &&
          getAll.users![index].company != null) {
        dataList.add({
          'data': 'Company',
          'detail': getAll.users![index].company,
        });
      }
      HomeMainProvider homeMainProvider =
      Provider.of<HomeMainProvider>(context, listen: false);
      GlobalKey<_HomeState> homeKey = GlobalKey<_HomeState>();
      return Wrap(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: CachedNetworkImage(
                          imageUrl:
                          '${getAll.users![index].images != null && getAll.users![index].images!.isNotEmpty ? getAll.users![index].images![0] : ''}',
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.6,
                          placeholder: (context, url) => Image.asset(
                            'assets/images/image_placeholder.png',
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.6,
                            fit: BoxFit.fill,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/image_placeholder.png',
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.6,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30),
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: height * 0.64,
                    // color: Colors.white10,
                    width: width,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: height * 0.6,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      getAll.users?[index].name ?? "",
                                      style: mulish14400.copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: ColorRes.darkGrey,
                                      ),
                                    ),

                                  ],
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width* 0.4,
                                      child: Row(
                                        children: [
                                          getAll.users![index].job != null &&
                                              getAll.users![index].job != ''
                                              ? Image.asset(
                                            'assets/icons/Worrk_Icon.png',
                                            height: 18,
                                            width: 18,
                                            fit: BoxFit.contain,
                                          )
                                              : SizedBox(),
                                          SizedBox(
                                            width: 1.5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              getAll.users![index].job ?? '',
                                              style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),


                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 7,),
                                    Expanded(
                                      child: SizedBox(
                                        child:
                                        Row(
                                          children: [
                                            getAll.users![index].company!= null &&
                                                getAll.users![index].company != ''
                                                ? Image.asset(
                                              'assets/icons/Company.png',
                                              height: 18,
                                              width: 18,
                                              fit: BoxFit.contain,
                                            )
                                                : SizedBox(),
                                            SizedBox(
                                              width: 1.5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                getAll.users![index].company ?? '',
                                                style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width* 0.4,

                                      child:
                                      Row(
                                        children: [
                                          getAll.users![index].location != null &&
                                              getAll.users![index].location != ''
                                              ? Image.asset(
                                            'assets/icons/Location_Icon.png',
                                            height: 20,
                                            width: 18,
                                            fit: BoxFit.contain,
                                          )
                                              : SizedBox(),
                                          SizedBox(
                                            width: 1.5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              getAll.users![index].location ?? '',
                                              style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 7,),

                                    Expanded(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width* 0.4,
                                        child: Row(
                                          children: [

                                            getAll.users![index].college != null &&
                                                getAll.users![index].college != ''
                                                ? Image.asset(
                                              'assets/icons/Education_Icon.png',
                                              height: 18,
                                              width: 18,
                                              fit: BoxFit.contain,
                                            )
                                                : SizedBox(),
                                            SizedBox(
                                              width: 1.5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                getAll.users![index].college ?? '',
                                                style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),

                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),



                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      Strings.gallery,
                                      style: mulish14400.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: ColorRes.darkGrey,
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      child: Text(
                                        Strings.seeall,
                                        style: mulish14400.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: ColorRes.appColor,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Profile(
                                                  userId:
                                                  getAll.users?[index].id ??
                                                      ''),
                                            ));
                                      },
                                    ),
                                    Icon(
                                      Icons.arrow_forward_outlined,
                                      color: ColorRes.appColor,
                                      size: 15,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 230,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 0.7,
                                    ),
                                    itemCount:
                                    getAll.users![index].images!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, i) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: (getAll.users![index]
                                              .images !=
                                              null &&
                                              getAll.users![index].images!
                                                  .isNotEmpty)
                                              ? getAll.users![index].images![i]
                                              : '',
                                          height: 230,
                                          width: 155,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  height: 230,
                                                  width: 155,
                                                  'assets/images/image_placeholder.png',
                                                  fit: BoxFit.cover),
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  height: 230,
                                                  width: 155,
                                                  'assets/images/image_placeholder.png',
                                                  fit: BoxFit.cover),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(
                                                0, 3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.grey.shade50),
                                    child: Icon(
                                      Icons.close,
                                      color: ColorRes.darkGrey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: GestureDetector(
                                  onTap: () async {
                                    if(getAll.users?[index].id != null) {

                                      Navigator.pop(context);
                                   await    homeKey.currentState?.LikeDislikeapicall(getAll.users![index].id, 1);
                                   homeKey.currentState?.cardSwiperController.swipeRight();
                                    }

                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: ColorRes.appColor,
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(
                                              0xffED1E79,
                                            ),
                                            Color(
                                              0xffC1272D,
                                            ),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(
                                                0, 3), // changes position of shadow
                                          ),
                                        ]),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: ColorRes.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(
                                                0, 3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.grey.shade50),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.favorite_border,
                                          color: ColorRes.appColor,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          getAll.users?[index].likes.toString()??'',
                                          style: TextStyle(
                                              color: ColorRes.colorACACAC),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );
}