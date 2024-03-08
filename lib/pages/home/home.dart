import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/api/additinal_details_api.dart';
import 'package:date_madly_app/api/add_like_dislike.dart';
import 'package:date_madly_app/api/filter_api.dart';
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
    getallapicall();
    getCurrentLatLang();
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
      getAll = await GetAllApi.getallApi();
      if (getAll.users != null) {
        for (int i = 0; i < getAll.users!.length; i++) {
          if (getAll.users![i].loc != null &&
              getAll.users![i].loc!.coordinates != null &&
              getAll.users![i].loc!.coordinates!.isNotEmpty) {
            double distance = calculateDistance(
              double.parse(PrefService.getString(PrefKeys.lat)),
              double.parse(PrefService.getString(PrefKeys.long)),
              double.parse(getAll.users![i].loc!.coordinates!.first.toString()),
              double.parse(getAll.users![i].loc!.coordinates!.last.toString()),
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
    try {
      loder = true;
      setState(() {});
      addLikeDislikeModel =
          await AddLikedDislikeProfileApi.addLikedDislikeProfileapi(id, status);

      loder = false;
      setState(() {});
    } catch (e) {
      loder = false;
      setState(() {});
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
                  scale: 3,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Text(
            Strings.home,
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
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
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
                                      borderRadius: BorderRadius.circular(5),
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
                          borderRadius: BorderRadius.circular(5),
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
                              max: 30.0,
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
                    GestureDetector(
                      onTap: () async {
                        filterBody = {};
                        print(filterBody);
                        if (currentindex1 != -1) {
                          filterBody['gender'] =
                              currentindex1 == 0 ? 'Male' : "female";
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
                      child: Container(
                        height: MediaQuery.of(context).size.height / 11,
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                            color: ColorRes.appColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          Strings.COntinue,
                          style: poppins.copyWith(
                              fontSize: 16, color: Colors.white),
                        )),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        currentindex1 = -1;
                        _currentSliderValue = 0;
                        values = SfRangeValues(20, 20);
                        setState(() {});
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 11,
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 0,
                                  offset: Offset(2, 2),
                                  color: ColorRes.color939393.withOpacity(0.25),
                                  blurRadius: 10)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
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
                  remainingUsers.isNotEmpty && remainingUsers.length > 1
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: CardSwiper(
                              controller: cardSwiperController,
                              isDisabled: false,
                              backCardOffset: const Offset(10, 0),
                              initialIndex: 0,
                              padding: EdgeInsets.zero,
                              cardsCount: remainingUsers.length,
                              onSwipe: (previousIndex, currentIndex,
                                  direction) async {
                                cardIndex = currentIndex!;
                                setState(() {});
                                var index1 = currentIndex! - 1;
                                if (direction == CardSwiperDirection.left) {
                                  await LikeDislikeapicall(
                                      remainingUsers[index1].id, 1);

                                  setState(() {});
                                } else if (direction ==
                                    CardSwiperDirection.right) {
                                  await LikeDislikeapicall(
                                      remainingUsers[index1].id, 0);
                                  setState(() {});
                                } else {}
                                return true;
                              },
                              cardBuilder: (context,
                                  index,
                                  horizontalOffsetPercentage,
                                  verticalOffsetPercentage) {
                                final user = remainingUsers[index];

                                return GestureDetector(
                                  child: Container(
                                    height: height * 0.68,
                                    width: width * 0.8,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
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
                                    child: Column(
                                      children: [
                                        getAll.users != null &&
                                                getAll.users![index].images !=
                                                    null
                                            ? Expanded(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30)),
                                                  child: CachedNetworkImage(
                                                    height: height * 0.58,
                                                    width: width * 0.8,
                                                    imageUrl:
                                                        (user.images != null &&
                                                                user.images!
                                                                    .isNotEmpty)
                                                            ? user.images![0]
                                                            : '',
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      'assets/images/image_placeholder.png',
                                                      height: height * 0.58,
                                                      width: width * 0.8,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      'assets/images/image_placeholder.png',
                                                      height: height * 0.58,
                                                      width: width * 0.8,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
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
                                                    color: ColorRes.darkGrey,
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
                                                    color: ColorRes.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 60,
                                            ),
                                            Image.asset(
                                              AssertRe.Location_Icon,
                                              scale: 4.5,
                                              color: ColorRes.appColor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              distanceList[index] ?? '',
                                              style: mulish14400.copyWith(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    ladyBottomSheetUI(context, getAll, index);
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      : SizedBox(),
                  remainingUsers.isNotEmpty &&
                          getAll.users != null &&
                          getAll.users!.length > 2
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await LikeDislikeapicall(
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
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await LikeDislikeapicall(
                                      remainingUsers[cardIndex].id, 0);
                                  cardSwiperController.swipeRight();
                                  setState(() {});
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: ColorRes.appColor),
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: ColorRes.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 60,
                  )
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
