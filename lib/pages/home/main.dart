import 'package:animations/animations.dart';
import 'package:date_madly_app/pages/me/widgets/ChangePassword/change_password.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dialogs.dart';
import '../chat/main.dart';
import '../likes/main.dart';
import '../me/main.dart';
import 'home.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  var _lastSelected = 0;
  int currentIndex = 0;

  void nextPage(index) {
    setState(() {
      currentIndex = index;
    });
  }

  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Chat(),
    Likes(),
    Profile()
    // ChangePassword()
  ];
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      print(
          "New Token Generated kindly upload and delete old token using getToken();");
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      // Error getting token
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs().showExitDialog(context),
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: _widgetOptions.elementAt(currentIndex),
          bottomNavigationBar: Container(
            height: 60,
            decoration: BoxDecoration(
                color: ColorRes.lightPink,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      nextPage(0);
                    },
                    child: Image.asset(
                      'assets/icons/Home.png',
                      color: currentIndex == 0 ? ColorRes.appColor : null,
                      scale: 4,
                    )),
                InkWell(
                  onTap: () {
                    nextPage(1);
                  },
                  child: Image.asset(
                    'assets/icons/Chat.png',
                    color: currentIndex == 1 ? ColorRes.appColor : null,
                    scale: 4,
                  ),
                ),
                InkWell(
                  onTap: () {
                    nextPage(2);
                  },
                  child: Image.asset(
                    'assets/icons/Love.png',
                    color: currentIndex == 2 ? ColorRes.appColor : null,
                    scale: 4,
                  ),
                ),
                InkWell(
                  onTap: () {
                    nextPage(3);
                  },
                  child: Image.asset(
                    'assets/icons/Profile.png',
                    color: currentIndex == 3 ? ColorRes.appColor : null,
                    scale: 4,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
