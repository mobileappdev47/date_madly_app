import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/map/search_find_date_map.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapScreen1 extends StatelessWidget {
  const MapScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 76,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi,',
                            style: mulish14400.copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            height: 21,
                          ),
                          Text(
                            'Brian Immanuel,',
                            style: mulish14400.copyWith(
                              fontSize: 35,
                              color: ColorRes.appColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            shape: CircleBorder(),
                            // borderRadius: BorderRadius.circular(50),
                            elevation: 3,
                            child: Container(
                              margin: EdgeInsets.all(7),
                              height: 115,
                              width: 115,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/icons/Add Image_01.png",
                                  ),
                                ),
                                color: ColorRes.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 69,
                ),
                Container(
                  height: 460,
                  width: double.maxFinite,
                  color: ColorRes.lightPink,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 170,
                        ),
                        Text(
                          "Let's find your ",
                          style: mulish14400.copyWith(
                              fontSize: 28, color: ColorRes.appColor),
                        ),
                        Row(
                          children: [
                            Text(
                              "DATE",
                              style: mulish14400.copyWith(
                                fontSize: 28,
                                color: ColorRes.appColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Text(
                              "now !",
                              style: mulish14400.copyWith(
                                  fontSize: 28, color: ColorRes.appColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 77,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 13,
                          width: MediaQuery.of(context).size.width / 1,
                          child: CupertinoButton(
                            color: ColorRes.appColor,
                            child: Text('Sign Up'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FindDateMap(),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
