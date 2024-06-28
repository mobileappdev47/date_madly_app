// import 'dart:io';
//
// import 'package:purchases_flutter/purchases_flutter.dart';
//
// class PurchaseApis {
//   static String apiKey = '';
//
//   static Future init() async {
//
//     if (Platform.isIOS) {
//       apiKey = "appl_SAAsqqpRVISDdtFpVpnixEysaqk";
//     } else {
//       apiKey = 'goog_pzwtowAqUOaiTuHCeWYSZkdPCrZ';
//     }
//     await Purchases.setLogLevel(LogLevel.debug);
//     // await Purchases.setLogLevel(LogLevel.debug);
//     await Purchases.setup(apiKey);
//   }
//
//   static Future<List<Offering>> fetchOffers() async {
//     try {
//       final offering = await Purchases.getOfferings();
//       print("offering: ${offering}");
//       final current = offering.current;
//       return current == null ? [] : [current];
//     } catch (e) {
//       print(e.toString());
//       return [];
//     }
//   }
//
//   static Future<bool> purchasePackage(Package package) async {
//     try {
//       await Purchases.purchasePackage(package);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }
