import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static Future<void> init() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;

      /// If `onMessage` is triggered with a notification, construct our own
      /// local notification to show to users using the created channel.
      if (notification != null && android != null) {
        Map<String, dynamic> payload = message!.data;
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
            ),
          ),
          payload: jsonEncode(payload),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (true) {
        Future.delayed(Duration(seconds: 8), () {});
      }
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        Future.delayed(Duration(seconds: 8), () {});
      }
    });

    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  static Future onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    if (kDebugMode) {
      print("Notification");
    }
  }
  static Future<String?> getAPNSToken() async {
    try {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      return apnsToken;
    } catch (e) {
      debugPrint('------SOOOOMEEEEE thing WENNTTTTT WRong=======${e.toString()}');
      return null;
    }
  }
  static Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}


// import 'dart:convert';
// import 'dart:developer';
// import 'dart:ffi';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
//
// import '../pages/home/main.dart';
//
// Map<String, dynamic> payLoadFromChat = {};
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel',
//   'High Importance Notifications',
//   importance: Importance.max,
//   playSound: true,
// );
//
// InitializationSettings initializationSettings = const InitializationSettings(
//   android: AndroidInitializationSettings('@mipmap/launcher_icon'),
//   iOS: DarwinInitializationSettings(),
// );
//
//
// class NotificationService {
//   Future<void> init() async {
//     final _firebaseMessaging = FirebaseMessaging.instance;
//
//     await _firebaseMessaging.requestPermission();
//
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) async {
//       print("message ==>2 ${message?.toMap()}");
//       var payload = message?.data;
//       if (payload != null) {
//         Map<String, dynamic> payLoadData = payload;
//         print("payLoadData payLoadData ${payLoadData}");
//
//         if (payLoadData.containsKey("fromChat")) {
//           currentIndex.value =1;
//           payLoadFromChat = payLoadData;
//           // AppNavigator.navigateTo(
//           //     context, ReusableWebViewScreen(url: payLoadData["url"]));
//         }
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
//       print("message ==>3 ${message?.toMap()}");
//       var payload = message?.data;
//       if (payload != null) {
//         Map<String, dynamic> payLoadData = payload;
//         print("payLoadData payLoadData ${payLoadData}");
//
//         if (payLoadData.containsKey("fromChat")) {
//           currentIndex.value =1;
//           payLoadFromChat = payLoadData;
//           // AppNavigator.navigateTo(
//           //     context, ReusableWebViewScreen(url: payLoadData["url"]));
//         }
//       }
//     });
//
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       debugPrint('firebase messaging is being listened ${message.data}');
//       try {
//         RemoteNotification? notification = message.notification;
//         print("notificationnotification ${notification?.toMap()}");
//         var data = message.data;
//         BigPictureStyleInformation? bigPictureStyleInformation;
//         if (data !=null && data.containsKey('imageUrl')) {
//           String imageUrl = data['imageUrl'];
//           try {
//             http.Response response = await http.get(Uri.parse(imageUrl));
//             if (response.statusCode == 200) {
//               final image = response.bodyBytes;
//               debugPrint('Image loaded successfully');
//               // Displaying image in notification
//               bigPictureStyleInformation = BigPictureStyleInformation(
//                 ByteArrayAndroidBitmap.fromBase64String(base64Encode(image)),
//                 largeIcon: ByteArrayAndroidBitmap.fromBase64String(
//                     base64Encode(image)),
//               );
//             } else {
//               debugPrint('Failed to load image: ${response.statusCode}');
//             }
//           } catch (e) {
//             debugPrint('Error loading image: $e');
//           }
//         }
//         print("datadatadatadatadata ${data}");
//
//         // String body = "";
//         // String title = "";
//         // if(data?.containsKey("text")){
//         //   body = data['text'];
//         //   title = "${data['title']} ✏️";
//         // }else if(data.containsKey("imageUrl")){
//         //   body = "";
//         //   title = "${data['title'] } 🖼️";
//         // }else{
//         //   body = notification?.body??"";
//         //   title = notification?.title??"";
//         // }
//
//         await flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification?.title,
//           notification?.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               color: Colors.blue,
//               playSound: true,
//               importance: Importance.max,
//               priority: Priority.max,
//               icon: '@mipmap/launcher_icon',
//               styleInformation: data!=null&& data.containsKey('imageUrl')
//                   ? bigPictureStyleInformation
//                   : null,
//             ),
//             iOS: const DarwinNotificationDetails(
//               presentAlert: true,
//               presentBadge: true,
//               presentSound: true,
//             ),
//           ),
//           payload: jsonEncode(data),
//         );
//         debugPrint('the payLoad is $data');
//         log('this is notification bb bb ---  ');
//         debugPrint('___________${notification.toString()}');
//         debugPrint('________________');
//         debugPrint('________________');
//         if (notification != null) {}
//       }catch(e){
//         debugPrint('error in listening notifications $e');
//       }
//     });
//
//
//
//     final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//     final didNotificationLaunchApp =
//         notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
//
//     if (didNotificationLaunchApp) {
//       var payload = notificationAppLaunchDetails?.notificationResponse;
//       onSelectNotification(payload!);
//     } else {
//       flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: onSelectNotification,
//       );
//     }
//   }
//
//   onSelectNotification(NotificationResponse notificationResponse) async {
//     var payloadData = jsonDecode(notificationResponse.payload ?? "");
//     print("payload $payloadData");
//     print("message ==>1 $payloadData");
//
//     if (payloadData != null) {
//       print("payLoadData payLoadData ${payloadData}");
//
//       if (payloadData.containsKey("fromChat")) {
//         currentIndex.value =1;
//         print("payloadData sdfksdjhfsdfshdfjsdhfj ${payloadData["roomId"]}");
//         payLoadFromChat = payloadData;
//
//       }
//     }
//   }
//
//
//
//   static Future onDidReceiveLocalNotification(
//       int id,
//       String? title,
//       String? body,
//       String? payload,
//       ) async {
//     if (kDebugMode) {
//       print("Notification");
//     }
//   }
//   static Future<String?> getAPNSToken() async {
//     try {
//       String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//       return apnsToken;
//     } catch (e) {
//       debugPrint('------SOOOOMEEEEE thing WENNTTTTT WRong=======${e.toString()}');
//       return null;
//     }
//   }
//   static Future<String?> getToken() async {
//     try {
//       return await FirebaseMessaging.instance.getToken();
//     } catch (e) {
//       debugPrint(e.toString());
//       return null;
//     }
//   }
//
//   Future<void> handleBackgroundMessage(RemoteMessage message) async {
//     log("Title: ${message.notification?.title}");
//
//     log("Body: ${message.notification?.body}");
//
//     log("Payload: ${message.data}");
//   }
//
// }
