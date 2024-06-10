import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApis{
  static const _apiKey = 'goog_DhtHeQIuVxeSZyFoPJosbcwLPkj';
static Future init()async{

  await Purchases.setDebugLogsEnabled(true);
  // await Purchases.setLogLevel(LogLevel.debug);
  await Purchases.setup(_apiKey);

}

  static Future<List<Offering>> fetchOffers () async {
  try{
  final offering = await Purchases.getOfferings();
  final current = offering.current;
  return current== null?[]:[current];
  }
  catch(e){
  print(e.toString());
  return [];
  }
  }


  static Future<bool> purchasePackage(Package package) async{

  try{
    await Purchases.purchasePackage(package);
    return true;

  }catch(e){

    return false;

  }
  }


}