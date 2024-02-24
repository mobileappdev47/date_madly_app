import 'package:animations/animations.dart';
import 'package:date_madly_app/api/get_All_api.dart';
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
    Profile(),
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

          /*body: PageTransitionSwitcher(
              transitionBuilder: (Widget child,
                      Animation<double> primaryAnimation,
                      Animation<double> secondaryAnimation) =>
                  FadeThroughTransition(
                      animation: primaryAnimation,
                      secondaryAnimation: secondaryAnimation,
                      child: child),
              child: _widgetOptions[_lastSelected]),*/
          // body: PageView(
          //   controller: pageController,
          //   physics: const NeverScrollableScrollPhysics(),
          //   onPageChanged: (index) {
          //     _lastSelected = index;
          //     // pageController.jumpToPage(index);
          //     // pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
          //     setState(() {});
          //   },
          //   children: _widgetOptions,
          // ),

          // body: IndexedStack(
          //   index: _lastSelected,
          //   children: const <Widget>[Home(), Likes(), Chat(), Me()],
          // ),
          bottomNavigationBar: /*BottomNavigationBar(
            items: [
              BottomNavigationBarItem(

                icon: Icon(Icons.home),
                label: 'Home',
              ),
            ],
          )*/
              Container(
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
          )
          /* Theme(
            data: Theme.of(context).copyWith(
                // splashColor: Colors.transparent,
                // highlightColor: Colors.transparent
                ),
            child: NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  _lastSelected = index;
                  // pageController.jumpToPage(index);
                  // pageController.animateToPage(index,
                  //     duration: const Duration(milliseconds: 400),
                  //     curve: Curves.bounceIn);
                });
              },
              selectedIndex: _lastSelected,
             */ /* destinations: [
             */ /**/ /*   Row(
                  children: [
                    Image.asset(''assets/icons/Home.png'',scale: 4,),
                    Image.asset('assets/icons/Home.png',scale: 4,),
                    Image.asset('assets/icons/Home.png',scale: 4,),
                    Image.asset('assets/icons/Home.png',scale: 4,)
                  ],
                )*/ /**/ /*
              ],*/ /*
              destinations: [
                const NavigationDestination(

                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: "Home",
                ),
                const NavigationDestination(
                    icon: Icon(Icons.favorite_outline),
                    selectedIcon: Icon(Icons.favorite),
                    label: "Likes"),
                NavigationDestination(
                    icon: const Icon(Icons.chat_outlined),
                    selectedIcon: const Icon(Icons.chat),
                    label: "Chat"),
                const NavigationDestination(
                    icon: Icon(Icons.account_circle_outlined),
                    selectedIcon: Icon(Icons.account_circle),
                    label: "Me"),
              ]),
            ),*/
          ),
    );
  }
}
