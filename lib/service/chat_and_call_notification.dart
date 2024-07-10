import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../utils/pref_key.dart';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// String fCMToken = "";
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

class ChatAndCallNotificationServices {
  // final _firebaseMessaging = FirebaseMessaging.instance;
  //
  // Future<void> initNotifications({required BuildContext context}) async {
  //   await _firebaseMessaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  //
  //   fCMToken = await _firebaseMessaging.getToken() ?? "";
  //
  //   print('Token is: $fCMToken');
  //   final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  //   print(
  //       "PrefService.getString(PrefKeys.email) ${PrefService.getString(PrefKeys.email)}");
  //
  //   await fireStore
  //       .collection("Auth")
  //       .doc(PrefService.getString(PrefKeys.email))
  //       .update({'fcmToken': fCMToken});
  // }
  //
  // Future initPushNotifications({required BuildContext context}) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //           badge: true, sound: true, alert: true);
  //
  //   FirebaseMessaging.instance.getInitialMessage().then((message) async {
  //     print("message ==>2 ${message?.toMap()}");
  //
  //     if (message != null) {
  //       if (message.notification != null) {
  //         var payload = message.data;
  //
  //         print("message ==>2 $payload");
  //         if (payload != null) {
  //           Map<String, dynamic> payLoadData = payload;
  //           print("payLoadData payLoadData ${payLoadData}");
  //
  //           // if (payLoadData.containsKey("url")) {
  //           // AppNavigator.navigateTo(
  //           //     context, ReusableWebViewScreen(url: payLoadData["url"]));
  //           // }
  //         }
  //       }
  //     }
  //   });
  //
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) async {
  //     print("message ==>3 ${message.toMap()}");
  //     if (message.notification != null) {
  //       var payload = message.data;
  //
  //       print("message ==>1 $payload");
  //       if (payload != null) {
  //         Map<String, dynamic> payLoadData = payload;
  //         print("payLoadData payLoadData ${payLoadData}");
  //
  //         // if (payLoadData.containsKey("url")) {
  //         //   AppNavigator.navigateTo(
  //         //       context, ReusableWebViewScreen(url: payLoadData["url"]));
  //         // }
  //       }
  //     }
  //   });
  //
  //   FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     debugPrint('firebase messaging is being listened ${message.data}');
  //
  //     try {
  //       RemoteNotification? notification = message.notification;
  //       print("notificationnotificationnotification ${notification?.body}");
  //       print("notificationnotificationnotification ${notification?.title}");
  //       print("notificationnotificationnotification ${notification?.toMap()}");
  //
  //       Map payload = jsonDecode(notification?.body ?? "");
  //       print("payloadpayloadpayload ${payload}");
  //
  //       String textMessage = "";
  //       String imageUrl = "";
  //
  //       if (payload.containsKey("text")) {
  //         textMessage = payload['text'];
  //       } else if (payload.containsKey("imageUrl")) {
  //         imageUrl = payload['imageUrl'];
  //       }
  //
  //       imageUrl =
  //           "https://firebasestorage.googleapis.com/v0/b/love-circo.appspot.com/o/chat_images%2F1719998993944_66839c4b35ab32eb0a03c739_jambalaya-isolated-transparent-background_191095-32509.png?alt=media&token=977c0217-9fe9-4e61-8d8c-cafe5247847b";
  //
  //       final http.Response response = await http.get(Uri.parse(imageUrl));
  //       final bytes = await response.bodyBytes;
  //       BigPictureStyleInformation bigPictureStyleInformation =
  //           BigPictureStyleInformation(
  //         ByteArrayAndroidBitmap.fromBase64String(base64Encode(bytes)),
  //         largeIcon:
  //             ByteArrayAndroidBitmap.fromBase64String(base64Encode(bytes)),
  //       );
  //
  //       print("textMessagetextMessage ${textMessage}");
  //       print("textMessagetextMessage ${imageUrl}");
  //       await Future.delayed(Duration(seconds: 2));
  //
  //       // if (textMessage != "") {
  //       await flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification?.title,
  //         payload.containsKey("text") ? textMessage : "Image",
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             color: Colors.blue,
  //             playSound: true,
  //             importance: Importance.max,
  //             priority: Priority.max,
  //             icon: '@mipmap/launcher_icon',
  //             styleInformation: payload.containsKey('imageUrl')
  //                 ? bigPictureStyleInformation
  //                 : null,
  //           ),
  //           iOS: const DarwinNotificationDetails(
  //             presentAlert: true,
  //             presentBadge: true,
  //             presentSound: true,
  //           ),
  //         ),
  //         payload: jsonEncode(payload),
  //       );
  //       // }
  //
  //       debugPrint('the payLoad is $payload');
  //
  //       log('this is notification bb bb ---  ');
  //
  //       debugPrint('___________${notification.toString()}');
  //
  //       debugPrint('________________');
  //
  //       debugPrint('________________');
  //
  //       if (notification != null) {}
  //     } catch (e) {
  //       debugPrint('error in listening notifications $e');
  //     }
  //   });
  //
  //   final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  //       await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  //
  //   final didNotificationLaunchApp =
  //       notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  //
  //   if (didNotificationLaunchApp) {
  //     var payload = notificationAppLaunchDetails?.notificationResponse;
  //
  //     onSelectNotification(payload!, context: context);
  //   } else {
  //     flutterLocalNotificationsPlugin.initialize(
  //       initializationSettings,
  //       onDidReceiveNotificationResponse:
  //           (NotificationResponse notificationResponse) {
  //         var payload = jsonDecode(notificationResponse.payload ?? "");
  //
  //         print("message ==>ww $payload");
  //         if (payload != null) {
  //           Map<String, dynamic> payLoadData = payload;
  //           print("payLoadData payLoadData ${payLoadData}");
  //
  //           // if (payLoadData.containsKey("url")) {
  //           //   AppNavigator.navigateTo(
  //           //       context, ReusableWebViewScreen(url: payLoadData["url"]));
  //           // }
  //         }
  //       },
  //     );
  //   }
  // }
  //
  // onSelectNotification(NotificationResponse notificationResponse,
  //     {required BuildContext context}) async {
  //   var payload = jsonDecode(notificationResponse.payload ?? "");
  //
  //   print("message ==>1 $payload");
  //   if (payload != null) {
  //     Map<String, dynamic> payLoadData = payload;
  //     print("payLoadData payLoadData ${payLoadData}");
  //
  //     // if (payLoadData.containsKey("url")) {
  //     //   AppNavigator.navigateTo(
  //     //       context, ReusableWebViewScreen(url: payLoadData["url"]));
  //     // }
  //   }
  // }
  //
  // Future<void> handleBackgroundMessage(RemoteMessage message) async {
  //   log("Title: ${message.notification?.title}");
  //
  //   log("Body: ${message.notification?.body}");
  //
  //   log("Payload: ${message.data}");
  // }

  Future<void> sendNotification(
      {required recipientToken,
      String? message = "",
      String? title = "",
        String? roomId = "",
      String? imageUrl = "", String? currentUID="", String? currentUserProfileImage="", String? otherUID=""}) async {
    print("messagemessage ${roomId}");
    print("messagemessage ${imageUrl}");
    print("messagemessage ${currentUID}");
    print("messagemessage ${currentUserProfileImage}");
    print("messagemessage ${otherUID}");
    final String serverKey =
        'AAAA1QUHYGw:APA91bFO8tC6yk6Xp9Pa8tSYGj3TG4SSb9Z2i6LoWyo1nfIpmVi4GGXsd1b_hk9tKH1d-X13_2rMJUJyQFDBb0CFof4DZe_ZtGW2OQ5NlqfaR2vimL5pJ16Phm0KNIMA8_3hvSEwQIqn';
    final String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };
    var requestBody = {};
    if (message == "") {
      requestBody = {
        "fromChat":true,
        "roomId":roomId,
        "imageUrl": imageUrl,
        'title': title,
        "senderID": currentUID,
        "receiverId": otherUID,
        "receiverImage": currentUserProfileImage,
      };
    } else {
      requestBody = {
        "fromChat":true,
        "roomId":roomId,
        "text": message,
        'title': title,
        "senderID": currentUID,
        "receiverId": otherUID,
        "receiverImage": currentUserProfileImage,
      };
    }

    final request = {
      'notification': {'title': title, 'body': message == ""?"🖼️":message, 'data': requestBody,},
      'priority': 'high',
      'data': requestBody,
      'to': recipientToken,
    };

    print("request ${request}");
    final response = await http.post(
      Uri.parse(fcmUrl),
      headers: headers,
      body: json.encode(request),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Error: ${response.reasonPhrase}');
    }
  }
}
