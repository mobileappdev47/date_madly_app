import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/api/get_single_profile_api.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/models/get_single_profile_model.dart';
import 'package:date_madly_app/pages/likes/like_profile.dart';
import 'package:date_madly_app/pages/login/Login_with_phone.dart';
import 'package:date_madly_app/pages/login/profile_photo/profile_photo_screen.dart';
import 'package:date_madly_app/pages/me/edit_profile.dart';
import 'package:date_madly_app/pages/me/personal_info.dart';
import 'package:date_madly_app/pages/new/enter_personal_data/enter_personal_data_screen.dart';
import 'package:date_madly_app/providers/home_main_provider.dart';
import 'package:date_madly_app/providers/me_provider.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/constants.dart';
import 'package:date_madly_app/utils/mqtt_client.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/app_provider.dart';
import '../../theme/theme_config.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';
import 'widgets/ChangePassword/change_password.dart';
import 'my_gallery.dart';

class Profile extends StatefulWidget {
  Profile({super.key, this.userId});
  final String? userId;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  bool isclick = false;
  int selectedIndex = -1;
  GetSingleProfileModel getSingleProfileModel = GetSingleProfileModel();
  HomeMainProvider homeMainProvider = HomeMainProvider();

  getSingleProfileApi() async {
    try {
      loader = true;
      setState(() {});
      getSingleProfileModel = await GetSingleProfileApi.getSingleProfileApi(
          context, widget.userId ?? PrefService.getString(PrefKeys.userId));
      loader = false;
      setState(() {});
    } catch (e) {
      loader = false;
      setState(() {});
    }
  }

  bool loader = false;
  @override
  void initState() {
    getSingleProfileApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(PrefService.getString(PrefKeys.userId));
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: ColorRes.white,
        leading: widget.userId == null
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ColorRes.appColor,
                ),
              ),
        title: Text(
          Strings.profile,
          style: mulishbold.copyWith(
            color: ColorRes.appColor,
            fontSize: 18.75,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              splashColor: ColorRes.appColor.withOpacity(0.5),
              onTap: () {
                showNotificationContainers(context, homeMainProvider);
              },
              child: Image.asset(
                AssertRe.Setting,
                scale: 3,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Center(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            getSingleProfileModel.profile?[0].images != null &&
                                    getSingleProfileModel
                                        .profile![0].images!.isNotEmpty
                                ? getSingleProfileModel.profile![0].images![0]
                                : '',
                        fit: BoxFit.fill,
                        height: 100,
                        width: 100,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/image_placeholder.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/image_placeholder.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text(getEmail().toString()),
                  Text(
                    getSingleProfileModel.profile?[0].name ?? '',
                    style: mulishbold.copyWith(
                        fontSize: 20,
                        color: ColorRes.darkGrey,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 19,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: ColorRes.appColor)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_outline_sharp,
                            color: ColorRes.appColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            getSingleProfileModel.profile?[0].likes
                                    .toString() ??
                                '',
                            style: mulishbold.copyWith(
                              fontSize: 14.06,
                              color: ColorRes.appColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      getSingleProfileModel.profile?[0].job != null &&
                              getSingleProfileModel.profile?[0].job != ''
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
                      Text(
                        getSingleProfileModel.profile?[0].job ?? '',
                        style: TextStyle(color: ColorRes.grey),
                      ),
                      Spacer(),
                      getSingleProfileModel.profile?[0].college != null &&
                              getSingleProfileModel.profile?[0].college != ''
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
                      Text(
                        getSingleProfileModel.profile?[0].college ?? '',
                        style: TextStyle(color: ColorRes.grey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      getSingleProfileModel.profile?[0].location != null &&
                              getSingleProfileModel.profile?[0].location != ''
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
                      Text(
                        getSingleProfileModel.profile?[0].location ?? '',
                        style: TextStyle(color: ColorRes.grey),
                      ),
                      Spacer(),
                      getSingleProfileModel.profile?[0].company != null &&
                              getSingleProfileModel.profile?[0].company != ''
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
                      Text(
                        getSingleProfileModel.profile?[0].company ?? '',
                        style: TextStyle(color: ColorRes.grey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text(getEmail().toString()),
                  getSingleProfileModel.profile?[0].about != '' &&
                          getSingleProfileModel.profile?[0].about != null
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(Strings.about_me,
                              style: mulish14400.copyWith(
                                  fontSize: 18,
                                  color: ColorRes.darkGrey,
                                  fontWeight: FontWeight.w700)),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(getSingleProfileModel.profile?[0].about ?? '',
                          textAlign: TextAlign.start,
                          style: mulish14400.copyWith(
                            color: ColorRes.grey,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      getSingleProfileModel.profile?[0].images != null &&
                              getSingleProfileModel
                                  .profile![0].images!.isNotEmpty
                          ? Text(
                              Strings.gallery,
                              style: mulishbold.copyWith(
                                color: ColorRes.darkGrey,
                                fontSize: 16,
                              ),
                            )
                          : SizedBox(),
                      Spacer(),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => MyGalleryScreen(),
                      //     ));
                      //   },
                      //   child: Text(
                      //     Strings.show_all,
                      //     style: mulishbold.copyWith(
                      //       color: ColorRes.appColor,
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      // Icon(
                      //   Icons.arrow_forward,
                      //   color: ColorRes.appColor,
                      //   size: 16,
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemCount:
                          getSingleProfileModel.profile?[0].images?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: getSingleProfileModel
                                    .profile?[0].images?[index] ??
                                '',
                            fit: BoxFit.fill,
                            height: 60,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/image_placeholder.png',
                              fit: BoxFit.fill,
                              height: 60,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/image_placeholder.png',
                              fit: BoxFit.fill,
                              height: 60,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          loader == true
              ? Center(child: CircularProgressIndicator())
              : SizedBox()
        ],
      ),
    );
  }

  void showNotificationContainers(
      BuildContext context, HomeMainProvider homeMainProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => Align(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: ColorRes.appColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                Strings.notification,
                                style: mulishbold.copyWith(
                                  color: ColorRes.appColor,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              Image.asset(
                                AssertRe.Setting,
                                scale: 3,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: settingData.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () async {
                                  if (index == 0) {
                                    selectedIndex =
                                        selectedIndex == index ? -1 : index;
                                  } else if (index == 1) {
                                    Navigator.of(context).pop();
                                    homeMainProvider
                                        .showNotificationContainer(context);
                                  } else if (index == 2) {
                                    if (!await launchUrl(
                                        Uri.parse('https://www.google.com/'))) {
                                      throw Exception('Could not launch');
                                    }
                                  } else if (index == 3) {
                                    if (!await launchUrl(
                                        Uri.parse('https://www.google.com/'))) {
                                      throw Exception('Could not launch');
                                    }
                                  } else {}
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                                height: selectedIndex == index
                                                    ? 90
                                                    : 40,
                                                width: 210,
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        settingData[index],
                                                        style:
                                                            mulishbold.copyWith(
                                                          color:
                                                              ColorRes.darkGrey,
                                                          fontSize: 16.41,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    selectedIndex == index
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 60),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                            MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              EnterPersonalDataScreen(),
                                                                    ));
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            150,
                                                                        child:
                                                                            Text(
                                                                          Strings
                                                                              .personal_info,
                                                                          style:
                                                                              mulishbold.copyWith(
                                                                            color:
                                                                                ColorRes.grey,
                                                                            fontSize:
                                                                                13,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Image
                                                                          .asset(
                                                                        AssertRe
                                                                            .side,
                                                                        color: ColorRes
                                                                            .grey,
                                                                        scale:
                                                                            4,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                            MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              ChangePassword(),
                                                                    ));
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            150,
                                                                        child:
                                                                            Text(
                                                                          Strings
                                                                              .change_password,
                                                                          style: mulishbold.copyWith(
                                                                              color: ColorRes.grey,
                                                                              fontSize: 13),
                                                                        ),
                                                                      ),
                                                                      Image
                                                                          .asset(
                                                                        AssertRe
                                                                            .side,
                                                                        color: ColorRes
                                                                            .grey,
                                                                        scale:
                                                                            4,
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                )),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: selectedIndex == index
                                                      ? 60
                                                      : 20),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (index == 0) {
                                                      selectedIndex =
                                                          selectedIndex == index
                                                              ? -1
                                                              : index;
                                                    } else {}
                                                  });
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                    selectedIndex == index
                                                        ? AssertRe.down
                                                        : AssertRe.side,
                                                    scale: 4,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              PrefService.clear();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhoneOTP(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.log_out,
                                      style: mulishbold.copyWith(
                                          color: ColorRes.darkGrey,
                                          fontSize: 16.41)),
                                  Spacer(),
                                  Image.asset(
                                    AssertRe.logout,
                                    scale: 3,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}

List settingData = [
  'My Account',
  'Notifications',
  'Privacy Policy',
  'Terms And Conditions'
];

List profilePic = [
  'assets/icons/p3.png',
  'assets/icons/p5.png',
  'assets/icons/p3.png',
  'assets/icons/p4.png',
  'assets/icons/p5.png',
  'assets/icons/p6.png',
];

List photoPic = [
  'assets/icons/p3.png',
  'assets/icons/p5.png',
  'assets/icons/p3.png',
  'assets/icons/p5.png',
  'assets/icons/p6.png',
  'assets/icons/p3.png',
  'assets/icons/p5.png',
  'assets/icons/p3.png',
  'assets/icons/p5.png',
  'assets/icons/p6.png',
  'assets/icons/p3.png',
  'assets/icons/p5.png',
  'assets/icons/p3.png',
  'assets/icons/p5.png',
  'assets/icons/p6.png',
  'assets/icons/p3.png',
  'assets/icons/p5.png',
  'assets/icons/p3.png',
  'assets/icons/p5.png',
  'assets/icons/p6.png',
];

class profileDetail {
  final String image;
  final String text;

  profileDetail(this.image, this.text);
}

List<profileDetail> profileDetails = [
  profileDetail('assets/icons/Worrk_Icon.png', 'Graphic Designer'),
  profileDetail('assets/icons/Education_Icon.png', 'Design School'),
  profileDetail('assets/icons/Location_Icon.png', 'Jakarta, Indonesia'),
  profileDetail('assets/icons/Company.png', 'Design Center')
];

/*
class Me extends StatefulWidget {
  const Me({Key? key}) : super(key: key);

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  List items = [];
  @override
  void initState() {
    super.initState();
    items = [
      {
        'icon': Icons.edit,
        'title': 'Edit Profile',
        'function': () => _pushPageDialog(const EditProfile(), context),
      },
      // {
      //   'icon': Icons.favorite,
      //   'title': 'Your Likes',
      //   'function': () => print(""),
      // },
      {
        'icon': Icons.dark_mode,
        'title': 'Dark Mode',
        'function': () => print(""),
      },
      {
        'icon': Icons.info,
        'title': 'About',
        'function': () => showAbout(),
      },
      {
        'icon': Icons.file_copy,
        'title': 'Licenses',
        'function': () => _pushPageDialog(LicensePage(), context),
      },
      {
        'icon': Icons.file_copy,
        'title': 'Logout',
        'function': () => _pushPageDialog(const LicensePage(), context),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Settings'),
          leading: Container()),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          if (items[index]['title'] == 'Dark Mode') {
            return _buildThemeSwitch(items[index], context);
          }
          if (items[index]['title'] == 'Logout') {
            return _logout(items[index], context);
          }
          return ListTile(
            style: ListTileStyle.drawer,
            onTap: items[index]['function'],
            leading: Icon(items[index]['icon']),
            title: Text(items[index]['title']),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 6);
        },
      ),
    );
  }

  Widget _logout(Map item, context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FilledButton.tonalIcon(
          onPressed: () async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            await sharedPreferences.clear();
            mqttFunctions.client.disconnect();
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            // HomeMainProvider homeMainProvider = Provider.of<HomeMainProvider>(context, listen: false);
            // homeMainProvider.profileModel.profile = [];
            // homeMainProvider.singleProfileModel.profile = [];
            // homeMainProvider.controller.dispose();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) {
            //       return const SplashScreen();
            //     },
            //   ),
            // );
          },
          icon: const Icon(Icons.logout),
          label: const Text("Logout")),
    );
  }

  Widget _buildThemeSwitch(Map item, context) {
    return SwitchListTile(
      secondary: Icon(item['icon']),
      title: Text(item['title']),
      value: Provider.of<AppProvider>(context).theme == ThemeConfig.lightTheme
          ? false
          : true,
      onChanged: (v) {
        if (v) {
          Provider.of<AppProvider>(context, listen: false)
              .setTheme(ThemeConfig.darkTheme, 'dark');
        } else {
          Provider.of<AppProvider>(context, listen: false)
              .setTheme(ThemeConfig.lightTheme, 'light');
        }
      },
    );
  }

  _pushPageDialog(Widget page, context) {
    var val = Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return page;
        },
        fullscreenDialog: true,
      ),
    );
    return val;
  }

  showAbout() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('About'),
          content: Text('${Constants.appName} by SoodWebSolutions'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              )),
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
*/
