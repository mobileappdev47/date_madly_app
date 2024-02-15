import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mqtt_client.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
          autoStart: true,
          onForeground: onStart,
          onBackground: onIosbackground),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: true, autoStart: true));
}

late SharedPreferences sharedPreferences;

@pragma('vm:entry-point')
Future<bool> onIosbackground(ServiceInstance serviceInstance) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('id');
    print("id:- $id");
    if (mqttFunctions.client.connectionStatus!.state !=
            MqttConnectionState.connected &&
        id != null) mqttFunctions.startMQTT(id);
  });
  // service.invoke("update");
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: "Script Acc", content: "sub my channel");
      }
    }
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('id');
    print("id:- $id");
    if (mqttFunctions.client.connectionStatus!.state !=
            MqttConnectionState.connected &&
        id != null) mqttFunctions.startMQTT(id);
    service.invoke("update");
  });
}
