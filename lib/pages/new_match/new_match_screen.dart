import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/texts.dart';

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
            child: Text(
              Strings.cheers,
              style: mulishbold.copyWith(
                fontSize: 22,
                color: ColorRes.appColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            Strings.Itsamatch,
            style: mulishbold.copyWith(
              fontSize: 22,
              color: ColorRes.darkGrey,
            ),
          ),
          SizedBox(
            height: 90,
          ),
          Image.asset(
            AssertRe.user,
            scale: 3.5,
          ),
          SizedBox(
            height: 90,
          ),
          GestureDetector(
            onTap: () {
              /* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) =>   Chat(),));*/
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: ColorRes.appColor,
              child: Image.asset(
                AssertRe.chat,
                height: 25,
                color: ColorRes.white,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              Strings.skip,
              style: mulishbold.copyWith(
                color: ColorRes.lightGrey,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
