import 'package:date_madly_app/db/chat.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class NewMatchScreen extends StatefulWidget {
  const NewMatchScreen({super.key});

  @override
  State<NewMatchScreen> createState() => _NewMatchScreenState();
}

class _NewMatchScreenState extends State<NewMatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.center,
            child: Text('Cheers!', style: TextStyle(
              color: ColorRes.appColor, fontWeight: FontWeight.w600,fontSize: 22
            ),),
          ),
          SizedBox(
            height: 20,
          ),
          Text('It’s a match', style: TextStyle(
              color: ColorRes.darkGrey, fontWeight: FontWeight.w600,fontSize: 22
          ),),SizedBox(
            height: 90,
          ),
          Image.asset('assets/icons/User.png',scale: 3.5,),
          SizedBox(
            height: 90,
          ),
          GestureDetector(

            onTap: (){
             /* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) =>   Chat(),));*/
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: ColorRes.appColor,
              child: Image.asset('assets/icons/Chat.png',height: 25,color: ColorRes.white,),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Text('Skip',style: TextStyle(
                color: ColorRes.lightGrey, fontWeight: FontWeight.w600,fontSize: 14
            )),
          )
        ],
      ),
    );
  }
}
