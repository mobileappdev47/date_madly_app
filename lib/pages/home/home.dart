import 'dart:async';
import 'package:date_madly_app/db/chatroom.dart';
import 'package:date_madly_app/pages/home/image_scroll.dart';
import 'package:date_madly_app/pages/home/lady_bottomsheet.dart';
import 'package:date_madly_app/pages/home/widget/drawer.dart';
import 'package:date_madly_app/pages/new_match/new_match_screen.dart';
import 'package:date_madly_app/utils/enum/api_request_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../providers/home_main_provider.dart';
import '../../utils/body_builder.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectGender;

  List swipeList = [
    'assets/icons/Add Image.png',
    'assets/icons/Add Image.png',
    'assets/icons/Add Image.png'
  ];

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
                  'assets/icons/drawer.png',
                  scale: 3,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Text(
            'Home',
            style: appbarTitle(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                onPressed: () {
                  value.showNotificationContainer(context);
                },
                icon: Image.asset(
                  'assets/icons/Notification.png',
                  scale: 2.5,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(backgroundColor: ColorRes.white, child: CustomDrawer()),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: CardSwiper(
                  isDisabled: false,
                  backCardOffset: const Offset(10, 0),
                  initialIndex: 0,
                  padding: EdgeInsets.zero,
                  cardsCount: swipeList.length,
                  cardBuilder: (context, index, horizontalOffsetPercentage,
                      verticalOffsetPercentage) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
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
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40)),
                                    child: Image.asset(
                                      swipeList[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Jennifer, 22',
                                          style: greyText().copyWith(
                                              fontSize: 20,
                                              color: ColorRes.darkGrey,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Mulish'),
                                        ),
                                        //SizedBox(height: 10,),
                                        Text(
                                          'Model Fashion',
                                          style: greyText().copyWith(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Image.asset(
                                        'assets/icons/Location_Icon.png',
                                        scale: 4.5,
                                        color: ColorRes.appColor),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '5 km',
                                      style: greyText().copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            ladyBottomSheetUI(context);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey.shade50),
                    child: Icon(
                      Icons.close,
                      color: ColorRes.darkGrey,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => NewMatchScreen()));
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
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}

/*
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

var likedID;
AnimationController? animController;
Animation<double>? animation;

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  var homeMainProvider;
  @override
  void initState() {
    super.initState();
    Provider.of<HomeMainProvider>(context, listen: false)
                .profileModel
                .profile ==
            null
        ? SchedulerBinding.instance.addPostFrameCallback((_) =>
            Provider.of<HomeMainProvider>(context, listen: false)
                .fetchProfile())
        : print("ran mutiple times");
    homeMainProvider = context.read<HomeMainProvider>();
    homeMainProvider.controller = PageController(keepPage: false);

    // animController =
    //     AnimationController(duration: const Duration(seconds: 5), vsync: this);
    // animation = Tween<double>(begin: 200, end: 0)
    //     .chain(CurveTween(curve: Curves.bounceIn))
    //     .animate(animController!)
    //   ..addListener(() {
    //     setState(() {});
    //   })
    //   ..addStatusListener((status) {});
    // animController!.forward();
    // Timer(const Duration(seconds: 5), () {
    //   animController!.reset();
    // });
  }

  @override
  void dispose() {
    // homeMainProvider.controller.dispose();
    // homeMainProvider.controller.dispose();
    print("Main Home disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMainProvider>(
      builder: (BuildContext context, HomeMainProvider homeMainProvider,
          Widget? child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: _buildBody(homeMainProvider, context),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: homeMainProvider.showCross == false
                    ? () {
                        homeMainProvider.showCrossBool();
                        Timer(const Duration(milliseconds: 200), () {
                          homeMainProvider.likeDislikeProfile(likedID, 1);
                        });
                      }
                    : null,
                child: homeMainProvider.apiRequestStatus ==
                        APIRequestStatus.loaded
                    ? CircleAvatar(
                        radius: 34,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        child: const CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.grey,
                            child: IconButton(
                                icon: Icon(Icons.close, color: Colors.white),
                                tooltip: 'Dislike Profile',
                                onPressed: null)))
                    : const SizedBox(),
              ),
              // const SizedBox(width: 20),
              // CircleAvatar(
              //   radius: 32,
              //   backgroundColor: Colors.blue.withOpacity(0.2),
              //   child: CircleAvatar(
              //     radius: 26,
              //     backgroundColor: Colors.blue[700],
              //     child: const Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.thunderstorm, color: Colors.white),
              //         SizedBox(height: 2),
              //         Text("BLAZE",
              //             style: TextStyle(
              //                 fontSize: 11,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white))
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: homeMainProvider.showCheck == false
                    ? () {
                        homeMainProvider.showCheckBool();
                        Timer(const Duration(milliseconds: 200), () {
                          homeMainProvider.likeDislikeProfile(likedID, 0);
                        });
                      }
                    : null,
                child: homeMainProvider.apiRequestStatus ==
                        APIRequestStatus.loaded
                    ? CircleAvatar(
                        radius: 34,
                        backgroundColor: Colors.green.withOpacity(0.2),
                        child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.green[800],
                            child: const IconButton(
                                // focusColor: Colors.green,
                                icon: Icon(Icons.check, color: Colors.white),
                                tooltip: 'Like Profile',
                                onPressed: null)))
                    : const SizedBox(),
              ),
            ],
          ),
        );
      },
    );
  }
}

_buildBody(HomeMainProvider homeMainProvider, context) {
  return BodyBuilder(
      apiRequestStatus: homeMainProvider.apiRequestStatus,
      child: _buildBodyList(homeMainProvider, context),
      reload: () => homeMainProvider.fetchProfile());
}

_buildBodyList(HomeMainProvider homeMainProvider, context) {
  var item = homeMainProvider.profileModel;
  var min = item.profile?[0].height;
  homeMainProvider.getHeight(min);
  var height = "${homeMainProvider.feet}'${homeMainProvider.inch}''";
  // var age = item.age;
  var name = item.profile?[0].name!;
  var live = item.profile?[0].live;
  var age = item.profile != null
      ? calculateAge(DateTime.parse(item.profile![0].dob!))
      : "";
  likedID = item.profile?[0].sId;
  var images = item.profile?[0].images;

  // BasicInfo
  var sunSign = item.profile?[0].basicInfo!.sunSign;
  var favCuisine = item.profile?[0].basicInfo!.favCuisine;
  var political = item.profile?[0].basicInfo!.political;
  var lookingFor = item.profile?[0].basicInfo!.lookingFor;
  var personality = item.profile?[0].basicInfo!.personality;
  var firstDate = item.profile?[0].basicInfo!.firstDate;
  var drink = item.profile?[0].basicInfo!.drink;
  var smoke = item.profile?[0].basicInfo!.smoke;
  var religion = item.profile?[0].basicInfo!.religion;
  var favPastime = item.profile?[0].basicInfo!.favPastime;
  var gender = item.profile?[0].gender;

  return PageView.builder(
    physics: const NeverScrollableScrollPhysics(),
    controller: homeMainProvider.controller,
    // itemCount: homeMainProvider.profileModel.profile!.length + 100,
    itemBuilder: (BuildContext context, int index) {
      return Stack(
        children: [
          ListView(
            // shrinkWrap: true,
            children: [
              Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Hero(
                              tag: name!,
                              child: images!.length != 0
                                  ? CustomImageScroller(
                                      images: images,
                                      homeMainProvider: homeMainProvider,
                                      name: name)
                                  : Image.asset(gender == 'Man'
                                      ? "assets/images/male_placeholder.jpg"
                                      : "assets/images/female_placeholder.jpg")))),
                ],
              ),

              Padding(
                  padding: const EdgeInsets.only(left: 18, top: 10),
                  child: Text("$name, $age, $height",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
              Padding(
                  padding: const EdgeInsets.only(left: 12, top: 2),
                  child: Row(children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 5),
                    const Text("Lives in ",
                        style: TextStyle(fontWeight: FontWeight.w300)),
                    Text(live ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ])),
              const SizedBox(height: 10),
              GridView(
                addRepaintBoundaries: false,
                shrinkWrap: true, // use
                addAutomaticKeepAlives: false,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 2.5),
                children: [
                  if (sunSign != null)
                    SelectCard(
                        name: "Sun Sign", value: sunSign, icon: Icons.sunny),
                  if (favCuisine != null)
                    SelectCard(
                        name: "Favourite Cuisine",
                        value: favCuisine,
                        icon: Icons.dinner_dining),
                  if (political != null)
                    SelectCard(
                        name: "Political Views",
                        value: political,
                        icon: Icons.policy),
                  if (lookingFor != null)
                    SelectCard(
                        name: "Looking For",
                        value: lookingFor,
                        icon: Icons.favorite),
                  if (personality != null)
                    SelectCard(
                        name: "Personality",
                        value: personality,
                        icon: Icons.person_pin),
                  if (firstDate != null)
                    SelectCard(
                        name: "First Date",
                        value: firstDate,
                        icon: Icons.date_range),
                  if (drink != null)
                    SelectCard(
                        name: "Drink",
                        value: drink,
                        icon: Icons.local_drink_rounded),
                  if (smoke != null)
                    SelectCard(
                        name: "Smoke", value: smoke, icon: Icons.smoking_rooms),
                  if (religion != null)
                    SelectCard(
                        name: "Religion",
                        value: religion,
                        icon: Icons.stacked_line_chart_outlined),
                  if (favPastime != null)
                    SelectCard(
                        name: "Favourite Pastime",
                        value: favPastime,
                        icon: Icons.gamepad_outlined),
                  const SizedBox(height: 30)
                ],
              )

              // Row(children: [
              //   if (homeMainProvider
              //           .profileModel.profile?[0].basicInfo?.sunSign !=
              //       null)
              //     SelectCard(
              //         name: "Sun Sign",
              //         value: homeMainProvider
              //             .profileModel.profile?[0].basicInfo?.sunSign),
              // ]),

              // SelectCard(),
            ],
          ),
          Visibility(
            visible: homeMainProvider.showCross,
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.25),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // child:
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: Transform.translate(
                        // flipY: true,
                        // origin:
                        //     Offset(0, animation != null ? animation!.value : 0),
                        offset:
                            Offset(0, animation != null ? animation!.value : 0),
                        child: const Icon(Icons.close,
                            size: 200, color: Colors.white)))
              ],
            ),
          ),
          Visibility(
            visible: homeMainProvider.showCheck,
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.25),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.1,
                  // child:
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child:
                        const Icon(Icons.check, size: 200, color: Colors.white))
              ],
            ),
          ),
        ],
      );
    },
  );
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

class SelectCard extends StatelessWidget {
  const SelectCard(
      {Key? key, required this.name, required this.value, required this.icon})
      : super(key: key);
  final String name;
  final String? value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Card(
        color: value == '___' ? Colors.black26 : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: value == '___' ? Colors.white : null),
              // Icon(name == 'Sun Sign'
              //     ? Icons.sunny
              //     : name == 'Favourite Cuisine'
              //         ? Icons.dinner_dining
              //         : Icons.abc),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: value == '___' ? Colors.white : null)),
                  Text(value!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: value == '___' ? Colors.white : null))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
