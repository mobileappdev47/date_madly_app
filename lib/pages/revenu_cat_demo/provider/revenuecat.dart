
import 'package:date_madly_app/pages/revenu_cat_demo/entitlement/entitlement.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatProvider extends ChangeNotifier{
  RevenueCatProvider(){
    init();
  }
Entitlement _entitlement = Entitlement.free;
  Entitlement get entitlement=>_entitlement;

  set entitlement(Entitlement value) {
    _entitlement = value;
  }



  Future init()async{
    Purchases.addCustomerInfoUpdateListener((customerInfo) async{
      updatePurchaseStatus();
    });

  }

  updatePurchaseStatus() async {
final purchaseInfo = await Purchases.getCustomerInfo();
final entitlement = purchaseInfo.entitlements.active.values.toList();
_entitlement = entitlement.isEmpty? Entitlement.free: Entitlement.allCourses;
notifyListeners();
  }
}