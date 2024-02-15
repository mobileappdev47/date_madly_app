import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/text_style.dart';

class Call extends StatefulWidget {
  const Call({super.key});

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorRes.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorRes.grey,
            )),
        title: Text(
          'Call',
          style: appbarTitle().copyWith(color: ColorRes.grey),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 90,
          ),
          Center(
            child: Stack(
              children: [
                Image.asset(
                  'assets/icons/Add Image (1).png',
                  scale: 1.5,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80, left: 70),
                  child: CircleAvatar(
                    radius: 11,
                    backgroundColor: ColorRes.white,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: ColorRes.green,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Patricia',
            style: TextStyle(
                color: ColorRes.darkGrey,
                fontSize: 22,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 4,
          ),
          Text('Calling ...',
              style: TextStyle(
                  color: ColorRes.darkGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
          SizedBox(height: 170,),
          Expanded(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: ColorRes.appColor,
              child: Image.asset('assets/icons/Call_hangUp.png', scale: 3.5),
            ),
          ), SizedBox(height: 20,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorRes.white,
                      child:
                      Image.asset('assets/icons/Speaker.png', scale: 4),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorRes.white,
                      child:
                      Image.asset('assets/icons/Video Call.png', scale: 4),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorRes.white,
                      child:
                      Image.asset('assets/icons/Turn Off Voice.png', scale: 4),
                    ),
                  ),
                 /* Expanded(
                    flex: 2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: icons.length,
                      itemBuilder: (context, index) => CircleAvatar(
                        radius: 30,
                        backgroundColor: ColorRes.white,
                        child: Image.asset(icons[index], scale: 4),
                      ),
                    ),
                  )*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

List icons = [
  'assets/icons/Speaker.png',
  'assets/icons/Video Call.png',
  'assets/icons/Turn Off Voice.png'
];
