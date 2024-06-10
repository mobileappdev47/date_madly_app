import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';


class PaymentWalletWidget extends StatefulWidget {
  PaymentWalletWidget(
      {super.key,
      required this.title,
      required this.des,
      required this.package,
      required this.onClickedPackage});

  final String title;
  final String des;
  final List<Package> package;

  final ValueChanged<Package> onClickedPackage;

  @override
  State<PaymentWalletWidget> createState() => _PaymentWalletWidgetState();
}

class _PaymentWalletWidgetState extends State<PaymentWalletWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
       constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height* 0.75),

      child: SingleChildScrollView(child: Column(
        children: [
          Text(widget.title,),
          SizedBox(height: 10,),
          Text(widget.des,),
          SizedBox(height: 10,),
          buildPackages(),
        ],
      )),
    );



  }
  Widget buildPackages(){
    return ListView.builder(

      shrinkWrap: true,
      primary: false,
      itemCount: widget.package.length,
      itemBuilder: (context, index) {


        final package = widget.package[index];
      return  buildPackage(context,package);
    },);

  }
  Widget buildPackage(BuildContext context, Package package){


    final product = package.storeProduct;
     return Card(
       child: ListTile(
         contentPadding: EdgeInsets.all(8),
         title: Text(product.title),
         subtitle: Text(product.description),
         trailing: Text(product.priceString),
         onTap:() =>  widget.onClickedPackage(package),

       ),
     );

  }
}
