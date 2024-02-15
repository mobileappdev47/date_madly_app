import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MeProvider with ChangeNotifier {
  void showNotificationContainer(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 0),
            child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context)
                    .size
                    .height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Notification',style: TextStyle(
                              color: ColorRes.appColor, fontSize: 18,fontWeight: FontWeight.w700
                          ),),
                          SizedBox(width: 20,),
                          Image.asset('assets/icons/Notification.png', scale: 3,)
                        ],
                      ),
                      SizedBox(height: 20,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Today',
                            style: TextStyle(color: ColorRes.darkGrey, fontSize: 16,fontWeight: FontWeight.w700),
                          )),
                    ],
                  ),
                )
            ),
          ),
        );
      },
    );
  }
}