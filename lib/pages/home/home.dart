import 'dart:async';
import 'dart:developer';
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
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/enum/api_request_status.dart';
import 'package:date_madly_app/utils/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../api/get_All_api.dart';
import '../../models/user_model.dart';
import '../../providers/home_main_provider.dart';
import '../../utils/body_builder.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';
import '../likes/main.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectGender;
  Map<String, dynamic> body = {};
  Map<String, dynamic> filterBody = {};
  SfRangeValues values = SfRangeValues(20, 30);

  List swipeList = [
    AssertRe.homelady,
    AssertRe.homelady,
    AssertRe.homelady,
  ];
  bool loder = false;
  GetAllUser getAll = GetAllUser();

  List<User> remainingUsers = [];

  AdditinalDetail additinalDetail = AdditinalDetail();
  AddLikeDislikeModel addLikeDislikeModel = AddLikeDislikeModel();

  @override
  void initState() {
    super.initState();
    getallapicall();
    getNotification();
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
  var currentindex = -1;

  getallapicall() async {
    try {
      loder = true;
      setState(() {});
      getAll = await GetAllApi.getallApi();
      remainingUsers = getAll.users ?? [];
      loder = false;

      setState(() {});
    } catch (e) {
      loder = false;
      setState(() {});
      print('==============>${e.toString()}');
    }
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
            backgroundColor: ColorRes.white,
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
                                    currentindex = index;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: index == currentindex
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
                                          color: index == currentindex
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
                                            color: index == currentindex
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
                            Strings.Jakarta,
                            style: mulish14400.copyWith(
                              color: ColorRes.grey,
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
                          child: Slider(
                            value: _currentSliderValue,
                            min: 0,
                            max: 50,
                            //  divisions: 10,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
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
                              thumbStrokeWidth: 3,
                              thumbStrokeColor: ColorRes.appColor,
                            ),
                            child: SfRangeSlider(
                              inactiveColor: ColorRes.black.withOpacity(0.15),
                              tooltipTextFormatterCallback:
                                  (dynamic actualValue, String formattedText) {
                                var myVal =
                                    double.parse(actualValue.toString());
                                return '\$ ${myVal.toStringAsFixed(2).toString()}';
                              },
                              min: 20.0,
                              max: 30.0,
                              interval: 1,
                              enableTooltip: true,
                              tooltipShape: const SfRectangularTooltipShape(),
                              endThumbIcon: ClipOval(
                                  child: Container(
                                color: ColorRes.appColor,
                                width: 50,
                                height: 50,
                              )),
                              startThumbIcon: ClipOval(
                                  child: Container(
                                color: ColorRes.appColor,
                                width: 50,
                                height: 50,
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
                        if (currentindex != -1) {
                          filterBody['gender'] =
                              currentindex == 0 ? 'Male' : "Female";
                        }
                        if (_currentSliderValue != 0) {
                          filterBody['distance'] =
                              _currentSliderValue.toInt().toString();
                        }
                        print(values.end);
                        if (values.start == 20 && values.end == 30) {
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
                    Container(
                      height: MediaQuery.of(context).size.height / 11,
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                          color: ColorRes.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                        Strings.clear,
                        style: poppins.copyWith(fontSize: 16),
                      )),
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
                              isDisabled: false,
                              backCardOffset: const Offset(10, 0),
                              initialIndex: 0,
                              padding: EdgeInsets.zero,
                              cardsCount: remainingUsers.length,
                              onSwipe: (previousIndex, currentIndex,
                                  direction) async {
                                if (direction == CardSwiperDirection.left) {
                                  // await LikeDislikeapicall(
                                  //     remainingUsers[currentIndex!].id, 1);
                                  // remainingUsers.removeAt(currentIndex);
                                  setState(() {});
                                } else if (direction ==
                                    CardSwiperDirection.right) {
                                  // await LikeDislikeapicall(
                                  //     remainingUsers[currentIndex!].id, 0);
                                  // remainingUsers.removeAt(currentIndex);
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
                                  // onPanUpdate: (details) async {
                                  //   if (details.delta.dx > 0) {
                                  //     // Swiped right
                                  //     log('true============${user.id}');
                                  //     await LikeDislikeapicall(user.id, 0);
                                  //     remainingUsers.removeAt(index);
                                  //     setState(() {});
                                  //   } else if (details.delta.dx < 1) {
                                  //     // Swiped left
                                  //     log('false=============${user.id}');
                                  //
                                  //   }
                                  // },
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
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      'assets/images/image_placeholder.png',
                                                      height: height * 0.58,
                                                      width: width * 0.8,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      'assets/images/image_placeholder.png',
                                                      height: height * 0.58,
                                                      width: width * 0.8,
                                                      fit: BoxFit.cover,
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
                                              Strings.homeKM,
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
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => LikesYouScreen(),
                                  //     ));
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
                                onTap: () async {},
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
