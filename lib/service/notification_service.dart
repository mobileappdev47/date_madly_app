import 'dart:convert';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Map<String, dynamic> payLoadFromChat = {};

class NotificationService {
  static Future<void> init() async {
    // Initialize Firebase messaging for foreground notifications
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Define an Android notification channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      playSound: true,
      showBadge: true,
    );

    // Create the Android notification channel using flutter_local_notifications plugin
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Handle incoming Firebase messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;
      print("onMessage Called: ${message?.notification?.toMap()}");

      if (notification != null && android != null) {
        // Show a local notification when a message is received
        Map<String, dynamic> payload = message!.data;

        BigPictureStyleInformation? bigPictureStyleInformation;
        if (payload.containsKey('imageUrl')) {
          String imageUrl = payload['imageUrl'];
          try {
            http.Response response = await http.get(Uri.parse(imageUrl));
            if (response.statusCode == 200) {
              final image = response.bodyBytes;
              debugPrint('Image loaded successfully');
              // Displaying image in notification
              bigPictureStyleInformation = BigPictureStyleInformation(
                ByteArrayAndroidBitmap.fromBase64String(base64Encode(image)),
                largeIcon: ByteArrayAndroidBitmap.fromBase64String(
                    base64Encode(image)),
              );
            } else {
              debugPrint('Failed to load image: ${response.statusCode}');
            }
          } catch (e) {
            debugPrint('Error loading image: $e');
          }
        }
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
              channelShowBadge: true,
              styleInformation: payload.containsKey('imageUrl')
                  ? bigPictureStyleInformation
                  : null,
              importance: Importance.max,
              playSound: true,
              priority: Priority.max,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: jsonEncode(payload),
        );
      }
    });

    // Handle the scenario when a user taps on a notification to open the app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp Called: ${message.notification?.toMap()}");
      print("onMessageOpenedApp Called: ${message.data}");
      if (message.data.containsKey("fromChat")) {
        Map<String, dynamic> payLoadData = message.data;
        print("payLoadData payLoadData ${payLoadData}");

        if (payLoadData.containsKey("fromChat")) {
          currentIndex.value = 1;
          payLoadFromChat = payLoadData;
        }
      }
    });

    // Handle the initial message received when the app is opened from a terminated state
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          if (message.data.containsKey("fromChat")) {
            Map<String, dynamic> payLoadData = message.data;
            print("payLoadData payLoadData ${payLoadData}");

            if (payLoadData.containsKey("fromChat")) {
              currentIndex.value = 1;
              payLoadFromChat = payLoadData;
            }
          }
        }
      }
      print("getInitialMessage Called: ${message?.notification?.toMap()}");
      print("getInitialMessage Called: ${message?.data}");
    });

    // Enable Firebase messaging auto initialization
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // Set up a background message handler for Firebase messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Initialize flutter_local_notifications plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

  // Handle the scenario when a user interacts with a local notification
  static Future onSelectNotification(
      NotificationResponse notificationResponse) async {
    final payloadData = jsonDecode(notificationResponse.payload ?? "");
    print("App open che, notification click kari $payloadData");

    if (payloadData.containsKey("fromChat")) {
      print("payLoadData payLoadData ${payloadData}");

      if (payloadData.containsKey("fromChat")) {
        currentIndex.value = 1;
        payLoadFromChat = payloadData;
      }
    }
  }

  // Handle background Firebase messages
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Background handler called: ${message.notification?.toMap()}");
    print("Background handler called: ${message.data}");
    // Re-initialize Firebase if necessary
    await Firebase.initializeApp();
  }

  // Placeholder method for handling local notifications
  static Future onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {}

  // Retrieve the APNS token for iOS devices
  static Future<String?> getAPNSToken() async {
    try {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      return apnsToken;
    } catch (e) {
      debugPrint(
          '------SOOOOMEEEEE thing WENNTTTTT WRong=======${e.toString()}');
      return null;
    }
  }

  // Retrieve the FCM token for the device
  static Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }


  Future<void> sendNotification(
      {required recipientToken,
        String? message = "",
        String? title = "",
        String? roomId = "",
        String? imageUrl = "", String? currentUID="", String? currentUserProfileImage="", String? otherUID=""}) async {
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
