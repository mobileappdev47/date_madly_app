import 'dart:async';

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/api/get_single_profile_api.dart';
import 'package:date_madly_app/pages/calling/pick_up_screen.dart';
import 'package:date_madly_app/pages/calling/video_call.dart';
import 'package:date_madly_app/pages/chat/new_provider.dart';
import 'package:date_madly_app/pages/me/widgets/ChangePassword/change_password.dart';
import 'package:date_madly_app/service/chat_and_call_notification.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../models/get_single_profile_model.dart';
import '../../purchase_setup/purchase_api.dart';
import '../../purchase_setup/singletons_data.dart';
import '../../purchase_setup/store_config.dart';
import '../../purchase_setup/subscritpion_provider.dart';
import '../../service/notification_service.dart';
import '../../utils/colors.dart';
import '../../utils/dialogs.dart';
import '../chat/main.dart';
import '../likes/main.dart';
import '../me/main.dart';
import 'home.dart';

// ValueNotifier<int> currentIndex = ValueNotifier(0);

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
      // currentIndex.value = index;
      currentIndex = index;
    });
  }

  getProfileImage() {
    if (PrefService.getString(PrefKeys.userName).isEmpty) {
      GetSingleProfileApi.getSingleProfileApi(
          context, PrefService.getString(PrefKeys.userId));
    }
  }

  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Chat(),
    Likes(),
    Profiles()
    // ChangePassword()
  ];
  late StreamSubscription<QuerySnapshot> callSubscription;
  bool isCallActive = false;

  Future<void> initPlatformState(
      GetSingleProfileModel getSingleProfileModel) async {
    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration configuration;
    configuration = PurchasesConfiguration(StoreConfig.instance!.apiKey)
      ..appUserID = PrefService.getString(PrefKeys.email)
      ..observerMode = false;
    await Purchases.configure(configuration);

    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    print("customerInfo : ${customerInfo.entitlements}");
    print("customerInfo : ${PrefService.getString(PrefKeys.email)}");
    print("customerInfo : ${customerInfo.allPurchaseDates}");
    print("customerInfo : ${customerInfo.activeSubscriptions}");

    Purchases.addCustomerInfoUpdateListener((customerInfo1) async {
      appData.appUserID = customerInfo1.originalAppUserId;

      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      print("customer data ====> ${customerInfo.allPurchaseDates}");
      print("customer data ====> ${customerInfo.entitlements}");
      print("customer data ====> ${customerInfo.allExpirationDates}");
      print("customer data ====> ${customerInfo.activeSubscriptions}");
      Offerings offerings = await Purchases.getOfferings();
      var myProductList = offerings.current?.availablePackages;
      print("Product length : $myProductList");

      final valueProvider =
          Provider.of<NewChatProvider>(context, listen: false);
      valueProvider.myProductList = myProductList!;

      print("Provider : ${valueProvider.myProductList[0]}");

      if (getSingleProfileModel.profile?[0].subscriptionDetails?.name != null &&
          (getSingleProfileModel.profile?[0].subscriptionDetails?.name ==
                  "lovecirco_weekly_v3:lovecirco-weekly-v1" ||
              getSingleProfileModel.profile?[0].subscriptionDetails?.name ==
                  "lovecirco_premium_v1:lovecirco-monthly-v1" ||
              getSingleProfileModel.profile?[0].subscriptionDetails?.name ==
                  "lovecirco_3month_v1:lovecirco-3month-v2" ||
              getSingleProfileModel.profile?[0].subscriptionDetails?.name ==
                  "lovecirco_premium_v2:lovecirco-premium-v1")) {
        print("entitlementIDentitlementID ${entitlementID}");
        print(
            "entitlementIDentitlementID ${getSingleProfileModel.profile?[0].subscriptionDetails?.name}");
        entitlementID.value =
            getSingleProfileModel.profile?[0].subscriptionDetails?.name ?? "";
        print("entitlementIDentitlementID ${entitlementID}");
      }

      (customerInfo.entitlements.all[entitlementID.value] != null &&
              customerInfo.entitlements.all[entitlementID.value]!.isActive)
          ? appData.entitlementIsActive = true
          : appData.entitlementIsActive = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfileImage();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      GetSingleProfileModel getSingleProfileModel =
          await GetSingleProfileApi.getCurrentProfileApi(
              context, PrefService.getString(PrefKeys.email));
      initPlatformState(getSingleProfileModel);
      // NotificationService().init();
    });
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      print(
          "New Token Generated kindly upload and delete old token using getToken();");
    }).onError((err) {});

    callSubscription = FirebaseFirestore.instance
        .collection('calls')
        .where('receiverId', isEqualTo: PrefService.getString(PrefKeys.userId))
        .where('status', isEqualTo: 'calling')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty && !isCallActive) {
        final callData = snapshot.docs.first.data();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PickUpScreen(
                  photo:
                      'https://e7.pngegg.com/pngimages/887/118/png-clipart-laptop-illustration-laptop-user-computer-icons-user-s-blue-computer-network-thumbnail.png',
                  callerName: 'Test Janki',
                  channelId: callData["channelId"],
                  isVideoCall: callData['isVideoCall'] == true ? true : false),
            ));
      }
    });
  }

  @override
  void dispose() {
    callSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    //     onWillPop: () => Dialogs().showExitDialog(context),
    //     child: ValueListenableBuilder(
    //         valueListenable: currentIndex,
    //         builder: (context, currentIndexValue, child) {
    //           return Scaffold(
    //             backgroundColor: Theme.of(context).colorScheme.surface,
    //             body: _widgetOptions.elementAt(currentIndexValue),
    //             bottomNavigationBar: Container(
    //               height: 60,
    //               decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   boxShadow: [
    //                     BoxShadow(
    //                         color: ColorRes.color939393.withOpacity(0.25),
    //                         blurRadius: 3,
    //                         spreadRadius: 0),
    //                   ],
    //                   borderRadius: BorderRadius.only(
    //                       topLeft: Radius.circular(20),
    //                       topRight: Radius.circular(20))),
    //               alignment: Alignment.center,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   GestureDetector(
    //                     onTap: () {
    //                       nextPage(0);
    //                     },
    //                     child: Container(
    //                         height: 50,
    //                         width: 50,
    //                         decoration: BoxDecoration(
    //                             color: currentIndexValue == 0
    //                                 ? ColorRes.appColor.withOpacity(0.2)
    //                                 : Colors.transparent,
    //                             shape: BoxShape.circle),
    //                         child:
    //                         // Image.asset(
    //                         //   'assets/icons/Home.png',
    //                         //   color: currentIndexValue == 0 ? ColorRes.appColor : null,
    //                         //   scale: 4,
    //                         // ),
    //                         Icon(
    //                           Icons.location_pin,
    //                           size: 25,
    //                           color: currentIndexValue == 0
    //                               ? ColorRes.appColor
    //                               : ColorRes.grey,
    //                         )),
    //                   ),
    //                   GestureDetector(
    //                     onTap: () {
    //                       nextPage(1);
    //                     },
    //                     child: Container(
    //                       height: 50,
    //                       width: 50,
    //                       decoration: BoxDecoration(
    //                           color: currentIndexValue == 1
    //                               ? ColorRes.appColor.withOpacity(0.2)
    //                               : Colors.transparent,
    //                           shape: BoxShape.circle),
    //                       child: currentIndexValue == 1
    //                           ? Image.asset(
    //                         'assets/icons/active_chat.png',
    //                         scale: 4,
    //                       )
    //                           : Image.asset(
    //                         'assets/icons/Chat.png',
    //                         scale: 4,
    //                       ),
    //                     ),
    //                   ),
    //                   GestureDetector(
    //                     onTap: () {
    //                       nextPage(2);
    //                     },
    //                     child: Container(
    //                       height: 50,
    //                       width: 50,
    //                       decoration: BoxDecoration(
    //                           color: currentIndexValue == 2
    //                               ? ColorRes.appColor.withOpacity(0.2)
    //                               : Colors.transparent,
    //                           shape: BoxShape.circle),
    //                       child: currentIndexValue == 2
    //                           ? Image.asset(
    //                         'assets/icons/Love Icon (2).png',
    //                         scale: 4,
    //                       )
    //                           : Image.asset(
    //                         'assets/icons/Love.png',
    //                         scale: 4,
    //                       ),
    //                     ),
    //                   ),
    //                   GestureDetector(
    //                     onTap: () {
    //                       nextPage(3);
    //                     },
    //                     child: Container(
    //                       height: 50,
    //                       width: 50,
    //                       decoration: BoxDecoration(
    //                           color: currentIndexValue == 3
    //                               ? ColorRes.appColor.withOpacity(0.2)
    //                               : Colors.transparent,
    //                           shape: BoxShape.circle),
    //                       child: Image.asset(
    //                         'assets/icons/Profile.png',
    //                         color: currentIndexValue == 3 ? ColorRes.appColor : null,
    //                         scale: 4,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         }));

    return WillPopScope(
      onWillPop: () => Dialogs().showExitDialog(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: _widgetOptions.elementAt(currentIndex),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: ColorRes.color939393.withOpacity(0.25),
                    blurRadius: 3,
                    spreadRadius: 0),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  nextPage(0);
                },
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: currentIndex == 0
                            ? ColorRes.appColor.withOpacity(0.2)
                            : Colors.transparent,
                        shape: BoxShape.circle),
                    child:
                        // Image.asset(
                        //   'assets/icons/Home.png',
                        //   color: currentIndex == 0 ? ColorRes.appColor : null,
                        //   scale: 4,
                        // ),
                        Icon(
                      Icons.location_pin,
                      size: 25,
                      color:
                          currentIndex == 0 ? ColorRes.appColor : ColorRes.grey,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  nextPage(1);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: currentIndex == 1
                          ? ColorRes.appColor.withOpacity(0.2)
                          : Colors.transparent,
                      shape: BoxShape.circle),
                  child: currentIndex == 1
                      ? Image.asset(
                          'assets/icons/active_chat.png',
                          scale: 4,
                        )
                      : Image.asset(
                          'assets/icons/Chat.png',
                          scale: 4,
                        ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  nextPage(2);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: currentIndex == 2
                          ? ColorRes.appColor.withOpacity(0.2)
                          : Colors.transparent,
                      shape: BoxShape.circle),
                  child: currentIndex == 2
                      ? Image.asset(
                          'assets/icons/Love Icon (2).png',
                          scale: 4,
                        )
                      : Image.asset(
                          'assets/icons/Love.png',
                          scale: 4,
                        ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  nextPage(3);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: currentIndex == 3
                          ? ColorRes.appColor.withOpacity(0.2)
                          : Colors.transparent,
                      shape: BoxShape.circle),
                  child: Image.asset(
                    'assets/icons/Profile.png',
                    color: currentIndex == 3 ? ColorRes.appColor : null,
                    scale: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
