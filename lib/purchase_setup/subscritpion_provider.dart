import 'package:flutter/cupertino.dart';

class SubscriptionProvider extends ChangeNotifier {
  bool entitlementIsActive = false;

  setEntitlement(bool value) {
    entitlementIsActive = value;
    notifyListeners();
  }
}