import 'package:flutter/cupertino.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';

class SubscriptionProvider extends ChangeNotifier {
  bool entitlementIsActive = false;

  setEntitlement(bool value) {
    entitlementIsActive = value;
    notifyListeners();
  }
}