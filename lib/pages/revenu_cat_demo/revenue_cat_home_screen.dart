import 'package:date_madly_app/pages/revenu_cat_demo/apis/fetch_offers_api.dart';
import 'package:date_madly_app/pages/revenu_cat_demo/entitlement/entitlement.dart';
import 'package:date_madly_app/pages/revenu_cat_demo/provider/revenuecat.dart';
import 'package:date_madly_app/pages/revenu_cat_demo/widgets/paymentwalletwidgets.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';

class RevenueCatScreen extends StatefulWidget {
  const RevenueCatScreen({super.key});

  @override
  State<RevenueCatScreen> createState() => _RevenueCatScreenState();
}

class _RevenueCatScreenState extends State<RevenueCatScreen> {

  // void fetchOffers() async {
  //   // final offerings = await PurchaseApis.fetchOffers();
  //   if (offerings.isEmpty) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('no founds')));
  //   } else {
  //     print('Yes get data');
  //    final  packages = offerings
  //         .map((offer) => offer.availablePackages)
  //         .expand((pair) => pair)
  //         .toList();
  //     showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return PaymentWalletWidget(
  //           title: 'Upgrade your plan',
  //           des: 'new plan to benefits',
  //           package: packages,
  //           onClickedPackage: (value) async {
  //             // await PurchaseApis.purchasePackage(value);
  //             Navigator.pop(context);
  //           },
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final entitle = Provider.of<RevenueCatProvider>(context).entitlement;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              entitle == Entitlement.free
                  ? Text('You are on free plan')
                  : Text('you are on paid plan'),
              ElevatedButton(
                  onPressed: () {
                    // fetchOffers();
                  },
                  child: Text('Purchase')),
            ],
          ),
        ],
      ),
    );
  }
}
