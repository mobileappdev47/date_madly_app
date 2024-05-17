import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,color: ColorRes.appColor,size: 18,)),
        centerTitle: true,
        backgroundColor: ColorRes.white,
        title: Text(
          'Privacy Policy',
          style: mulishbold.copyWith(
            fontSize: 18.75,
            color: ColorRes.appColor,
          ),
        ),


      ),
      body: Column(
        children: [


        ],
      ),
    );
  }
}
