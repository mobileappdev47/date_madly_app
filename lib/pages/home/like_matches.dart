import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/text_feild_common.dart';
import '../../providers/chat_provider.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';

class LikeMatches extends StatelessWidget {
  LikeMatches({super.key});

  @override
  List image = [
    AssertRe.Add_Image,
    AssertRe.Add_Image_04,
    AssertRe.Add_Image_06,
    AssertRe.Add_Image,
    AssertRe.Add_Image_04,
    AssertRe.Add_Image_06,
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: ColorRes.white,
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return Icon(
        //       Icons.arrow_back_ios_rounded,
        //       color: ColorRes.appColor,
        //     );
        //     Image.asset(
        //       'assets/icons/drawer.png',
        //       scale: 3,
        //     );
        //   },
        // ),
        title: Text(
          Strings.jeniffer_matches,
          style: mulish14400.copyWith(
              color: ColorRes.appColor,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        // actions: [
        //   Builder(
        //     builder: (BuildContext context) {
        //       return IconButton(
        //         icon: Image.asset(
        //           AssertRe.Filter_Icon,
        //           scale: 1.3,
        //         ),
        //         onPressed: () {
        //           Scaffold.of(context).openDrawer();
        //         },
        //       );
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            NewTextField(
              controller: TextEditingController(),
              hintText: Strings.Search_a_Message,
              prefix: AssertRe.Search_Icon,
            ),
            SizedBox(
              height: 20,
            ),
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 15,
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
                            Text(
                              Strings.patrcia,
                              style: mulishbold.copyWith(
                                fontSize: 16.41,
                                color: ColorRes.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          Strings.Fashion_Designer,
                          style: mulish14400.copyWith(fontSize: 14),
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
