import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/home/like_matches.dart';
import 'package:date_madly_app/pages/me/my_gallery.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../utils/texts.dart';

ladyBottomSheetUI(BuildContext context, GetAllUser getAll, int index) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  showModalBottomSheet<dynamic>(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              getAll.users!.first.images![0]??'',
                            ),
                            fit: BoxFit.cover),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.only(left: 15, right: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 30),
                        child: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  height: height * 0.5,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.jennifer,
                          style: mulish14400.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.darkGrey,
                          ),
                        ),
                        Text(
                          Strings.Jakarta,
                          style: mulish14400.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ColorRes.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorRes.colorF4f4f4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 2,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.grey.shade50),
                                        child: Icon(
                                          Icons.close,
                                          color: ColorRes.darkGrey,
                                          size: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            Strings.genderss,
                                            style: mulish14400.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: ColorRes.darkGrey,
                                            ),
                                          ),
                                          Text(
                                            '${getAll.users?.first.gender}',
                                            style: mulish14400.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: ColorRes.darkGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LikeMatches(),
                                      ));
                                },
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorRes.colorF4f4f4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey.shade50),
                                      child: Icon(
                                        Icons.close,
                                        color: ColorRes.darkGrey,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          Strings.RelationStatus,
                                          style: mulish14400.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                        Text(
                                          '${getAll.users![index].relationStatus}',
                                          style: mulish14400.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorRes.colorF4f4f4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey.shade50),
                                      child: Icon(
                                        Icons.close,
                                        color: ColorRes.darkGrey,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          Strings.degree,
                                          style: mulish14400.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                        Text(
                                          '${getAll.users?.first.degree}',
                                          style: mulish14400.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorRes.colorF4f4f4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey.shade50),
                                      child: Icon(
                                        Icons.close,
                                        color: ColorRes.darkGrey,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          Strings.designation,
                                          style: mulish14400.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                        Text(
                                          '${getAll.users?.first.designation}',
                                          style: mulish14400.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorRes.colorF4f4f4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey.shade50),
                                      child: Icon(
                                        Icons.close,
                                        color: ColorRes.darkGrey,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          Strings.companys,
                                          style: mulish14400.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                        Text(
                                          '${getAll.users?.first.company}',
                                          style: mulish14400.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorRes.colorF4f4f4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey.shade50),
                                      child: Icon(
                                        Icons.close,
                                        color: ColorRes.darkGrey,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          Strings.profileScore,
                                          style: mulish14400.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                        Text(
                                          '${getAll.users?.first.profileScore}',
                                          style: mulish14400.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              Strings.gallery,
                              style: mulish14400.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: ColorRes.darkGrey,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              child: Text(
                                Strings.seeall,
                                style: mulish14400.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: ColorRes.appColor,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyGalleryScreen(),
                                    ));
                              },
                            ),
                            Icon(
                              Icons.arrow_forward_outlined,
                              color: ColorRes.appColor,
                              size: 15,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ClipRRect(
                              child: Image.asset(
                                AssertRe.addimages,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            )),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                                child: ClipRRect(
                              child: Image.asset(
                                AssertRe.addimages,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
