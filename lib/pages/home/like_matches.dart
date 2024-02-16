import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/text_feild_common.dart';
import '../../providers/chat_provider.dart';
import '../../utils/text_style.dart';

class LikeMatches extends StatelessWidget {
  LikeMatches({super.key});

  @override
  List image = [
    'assets/icons/Add Image (1).png',
    'assets/icons/Add Image_04.png',
    'assets/icons/Add Image_06.png',
    'assets/icons/Add Image (1).png',
    'assets/icons/Add Image_04.png',
    'assets/icons/Add Image_06.png',
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorRes.white,
        leading: Builder(
          builder: (BuildContext context) {
            return Icon(
              Icons.arrow_back_ios_rounded,
              color: ColorRes.appColor,
            );
            Image.asset(
              'assets/icons/drawer.png',
              scale: 3,
            );
          },
        ),
        title: Text(
          ' Jeniffer Matches',
          style: mulish14400.copyWith(
              color: ColorRes.appColor,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset(
                  'assets/icons/Filter Icon.png',
                  scale: 1.3,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            NewTextField(
              controller: TextEditingController(),
              hintText: 'Search a Message',
              prefix: 'assets/icons/Search_Icon.png',
            ),
            SizedBox(
              height: 20,
            ),
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: image.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      image[index],
                      scale: 3,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Patrcia',
                                style: TextStyle(
                                    color: ColorRes.darkGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          'Fashion Designer',
                          style: TextStyle(color: Color(0xffACACAC)),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorRes.appColor),
                      child: Icon(
                        Icons.favorite_border,
                        color: ColorRes.white,
                        size: 17,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey.shade50),
                      child: Icon(
                        Icons.close,
                        color: ColorRes.darkGrey,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
