import 'package:date_madly_app/common/text_feild_common.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/me/my_gallery.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';

profileViewBottomSheet(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  showModalBottomSheet<dynamic>(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/lady.png',
                        ),
                        fit: BoxFit.fill),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 3,
                        width: 70,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 15,
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                            size: 15,
                          )
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite_outline_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            'assets/icons/Comment.png',
                            color: Colors.white,
                            scale: 2.5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '2.4K Likes',
                            style: mulish14400.copyWith(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Jennifer, 22',
                        style: mulish14400.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: ColorRes.darkGrey,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Very bright morning, have a nice day. Tell the world thay you have a spirit of fire that never goes out. ',
                        style: mulish14400.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorRes.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'View All Comment',
                        style: mulish14400.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.appColor,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Richard Be careful, the sun can hurt your beautiful face. It would be better if I were your light.',
                        style: mulish14400.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorRes.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorRes.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.only(left: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add a Comment',
                            hintStyle:
                                TextStyle(color: ColorRes.grey, fontSize: 15),
                            suffixIcon: Image.asset(
                              'assets/icons/Send_Icon.png',
                              scale: 3,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
