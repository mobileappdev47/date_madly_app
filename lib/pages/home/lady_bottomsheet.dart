import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/home/like_matches.dart';
import 'package:date_madly_app/pages/me/my_gallery.dart';
import 'package:date_madly_app/pages/me/my_upload%20Photo.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../utils/texts.dart';
import '../me/main.dart';

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
      List dataList = [];

      if (getAll.users![index].gender != '' &&
          getAll.users![index].gender != null) {
        dataList.add({
          'data': 'Gender',
          'detail': getAll.users![index].gender,
        });
      }
      if (getAll.users![index].college != '' &&
          getAll.users![index].college != null) {
        dataList.add({
          'data': 'College',
          'detail': getAll.users![index].college,
        });
      }
      if (getAll.users![index].job != '' && getAll.users![index].job != null) {
        dataList.add({
          'data': 'Designation',
          'detail': getAll.users![index].job,
        });
      }
      if (getAll.users![index].profileScore != '' &&
          getAll.users![index].profileScore != null) {
        dataList.add({
          'data': 'Profile Score',
          'detail': getAll.users![index].profileScore.toString(),
        });
      }
      if (getAll.users![index].company != '' &&
          getAll.users![index].company != null) {
        dataList.add({
          'data': 'Company',
          'detail': getAll.users![index].company,
        });
      }

      return Wrap(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: NetworkImage(
                  //             '${getAll.users![index].images != null && getAll.users![index].images!.isNotEmpty ? getAll.users![index].images![1] : ''}'),
                  //         fit: BoxFit.cover),
                  //   ),
                  //   width: MediaQuery.of(context).size.width,
                  //   height: MediaQuery.of(context).size.height,
                  //   padding: EdgeInsets.only(left: 15, right: 15),
                  // ),
                  CachedNetworkImage(
                    imageUrl:
                        '${getAll.users![index].images != null && getAll.users![index].images!.isNotEmpty ? getAll.users![index].images![0] : ''}',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    placeholder: (context, url) => Image.asset(
                      'assets/images/image_placeholder.png',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/image_placeholder.png',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
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
                      Row(
                        children: [
                          Text(
                            getAll.users?[index].name ?? "",
                            style: mulish14400.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: ColorRes.darkGrey,
                            ),
                          ),
                          // Spacer(),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => MyUpload_Photo(
                          //               imageUrl:
                          //                   getAll.users![index].images?[0] ??
                          //                       '',
                          //               userId: getAll.users?[index].id ?? ''),
                          //         ));
                          //   },
                          //   child: Text(
                          //     'Comment',
                          //     style: mulish14400.copyWith(
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.w600,
                          //       color: ColorRes.darkGrey,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Text(
                        getAll.users?[index].location ?? "",
                        style: mulish14400.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: ColorRes.grey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: dataList.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
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
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(50),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dataList[index]['data'],
                                      style: mulish14400.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: ColorRes.darkGrey,
                                      ),
                                    ),
                                    Text(
                                      dataList[index]?['detail'] ?? '',
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
                          );
                        },
                      )
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: GestureDetector(
                      //         child: Container(
                      //           height: 80,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(8),
                      //             color: ColorRes.colorF4f4f4,
                      //           ),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Container(
                      //                 height: 30,
                      //                 width: 30,
                      //                 decoration: BoxDecoration(
                      //                     boxShadow: [
                      //                       BoxShadow(
                      //                         color:
                      //                             Colors.grey.withOpacity(0.5),
                      //                         spreadRadius: 1,
                      //                         blurRadius: 2,
                      //                         offset: Offset(0,
                      //                             3), // changes position of shadow
                      //                       ),
                      //                     ],
                      //                     borderRadius:
                      //                         BorderRadius.circular(50),
                      //                     color: Colors.grey.shade50),
                      //                 child: Icon(
                      //                   Icons.close,
                      //                   color: ColorRes.darkGrey,
                      //                   size: 14,
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 width: 7,
                      //               ),
                      //               Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.center,
                      //                 children: [
                      //                   Text(
                      //                     Strings.genderss,
                      //                     style: mulish14400.copyWith(
                      //                       fontSize: 12,
                      //                       fontWeight: FontWeight.w300,
                      //                       color: ColorRes.darkGrey,
                      //                     ),
                      //                   ),
                      //                   Text(
                      //                     '${getAll.users![index].gender}' ??
                      //                         '',
                      //                     style: mulish14400.copyWith(
                      //                       fontSize: 14,
                      //                       fontWeight: FontWeight.w600,
                      //                       color: ColorRes.darkGrey,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         onTap: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => LikeMatches(),
                      //               ));
                      //         },
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 7,
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         height: 80,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(8),
                      //           color: ColorRes.colorF4f4f4,
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //               height: 30,
                      //               width: 30,
                      //               decoration: BoxDecoration(
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: Colors.grey.withOpacity(0.5),
                      //                       spreadRadius: 1,
                      //                       blurRadius: 2,
                      //                       offset: Offset(0,
                      //                           3), // changes position of shadow
                      //                     ),
                      //                   ],
                      //                   borderRadius: BorderRadius.circular(50),
                      //                   color: Colors.grey.shade50),
                      //               child: Icon(
                      //                 Icons.close,
                      //                 color: ColorRes.darkGrey,
                      //                 size: 14,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 7,
                      //             ),
                      //             Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   Strings.RelationStatus,
                      //                   style: mulish14400.copyWith(
                      //                     fontSize: 12,
                      //                     fontWeight: FontWeight.w300,
                      //                     color: ColorRes.darkGrey,
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   '${getAll.users![index].gender ?? ''}' ??
                      //                       '',
                      //                   style: mulish14400.copyWith(
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w600,
                      //                     color: ColorRes.darkGrey,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Container(
                      //         height: 80,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(8),
                      //           color: ColorRes.colorF4f4f4,
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //               height: 30,
                      //               width: 30,
                      //               decoration: BoxDecoration(
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: Colors.grey.withOpacity(0.5),
                      //                       spreadRadius: 1,
                      //                       blurRadius: 2,
                      //                       offset: Offset(0,
                      //                           3), // changes position of shadow
                      //                     ),
                      //                   ],
                      //                   borderRadius: BorderRadius.circular(50),
                      //                   color: Colors.grey.shade50),
                      //               child: Icon(
                      //                 Icons.close,
                      //                 color: ColorRes.darkGrey,
                      //                 size: 14,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 7,
                      //             ),
                      //             Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   Strings.degree,
                      //                   style: mulish14400.copyWith(
                      //                     fontSize: 12,
                      //                     fontWeight: FontWeight.w300,
                      //                     color: ColorRes.darkGrey,
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   '${getAll.users![index].college ?? ''}' ??
                      //                       '',
                      //                   style: mulish14400.copyWith(
                      //                     fontSize: 10,
                      //                     fontWeight: FontWeight.w600,
                      //                     color: ColorRes.darkGrey,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 7,
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         height: 80,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(8),
                      //           color: ColorRes.colorF4f4f4,
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //               height: 30,
                      //               width: 30,
                      //               decoration: BoxDecoration(
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: Colors.grey.withOpacity(0.5),
                      //                       spreadRadius: 1,
                      //                       blurRadius: 2,
                      //                       offset: Offset(0,
                      //                           3), // changes position of shadow
                      //                     ),
                      //                   ],
                      //                   borderRadius: BorderRadius.circular(50),
                      //                   color: Colors.grey.shade50),
                      //               child: Icon(
                      //                 Icons.close,
                      //                 color: ColorRes.darkGrey,
                      //                 size: 14,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 7,
                      //             ),
                      //             Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   Strings.designation,
                      //                   style: mulish14400.copyWith(
                      //                     fontSize: 12,
                      //                     fontWeight: FontWeight.w300,
                      //                     color: ColorRes.darkGrey,
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   '${getAll.users![index].job ?? ''}' ??
                      //                       '',
                      //                   style: mulish14400.copyWith(
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w600,
                      //                     color: ColorRes.darkGrey,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Container(
                      //         height: 80,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(8),
                      //           color: ColorRes.colorF4f4f4,
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //               height: 30,
                      //               width: 30,
                      //               decoration: BoxDecoration(
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: Colors.grey.withOpacity(0.5),
                      //                       spreadRadius: 1,
                      //                       blurRadius: 2,
                      //                       offset: Offset(0,
                      //                           3), // changes position of shadow
                      //                     ),
                      //                   ],
                      //                   borderRadius: BorderRadius.circular(50),
                      //                   color: Colors.grey.shade50),
                      //               child: Icon(
                      //                 Icons.close,
                      //                 color: ColorRes.darkGrey,
                      //                 size: 14,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 7,
                      //             ),
                      //             Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   Strings.companys,
                      //                   style: mulish14400.copyWith(
                      //                     fontSize: 12,
                      //                     fontWeight: FontWeight.w300,
                      //                     color: ColorRes.darkGrey,
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   '${getAll.users![index].company ?? ''}' ??
                      //                       '',
                      //                   style: mulish14400.copyWith(
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w600,
                      //                     color: ColorRes.darkGrey,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 7,
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         height: 80,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(8),
                      //           color: ColorRes.colorF4f4f4,
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //               height: 30,
                      //               width: 30,
                      //               decoration: BoxDecoration(
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: Colors.grey.withOpacity(0.5),
                      //                       spreadRadius: 1,
                      //                       blurRadius: 2,
                      //                       offset: Offset(0,
                      //                           3), // changes position of shadow
                      //                     ),
                      //                   ],
                      //                   borderRadius: BorderRadius.circular(50),
                      //                   color: Colors.grey.shade50),
                      //               child: Icon(
                      //                 Icons.close,
                      //                 color: ColorRes.darkGrey,
                      //                 size: 14,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 7,
                      //             ),
                      //             Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   Strings.profileScore,
                      //                   style: mulish14400.copyWith(
                      //                     fontSize: 12,
                      //                     fontWeight: FontWeight.w300,
                      //                     color: ColorRes.darkGrey,
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   '${getAll.users![index].profileScore}' ??
                      //                       '',
                      //                   style: mulish14400.copyWith(
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w600,
                      //                     color: ColorRes.darkGrey,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      ,
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
                          InkWell(
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
                                    builder: (context) => Profile(
                                        userId: getAll.users?[index].id ?? ''),
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
                      Container(
                        height: 230,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: getAll.users![index].images!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, i) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: (getAll.users![index].images !=
                                            null &&
                                        getAll.users![index].images!.isNotEmpty)
                                    ? getAll.users![index].images![i]
                                    : '',
                                height: 230,
                                width: 155,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        height: 230,
                                        width: 155,
                                        'assets/images/image_placeholder.png',
                                        fit: BoxFit.cover),
                                placeholder: (context, url) => Image.asset(
                                    height: 230,
                                    width: 155,
                                    'assets/images/image_placeholder.png',
                                    fit: BoxFit.cover),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
/*import 'package:cached_network_image/cached_network_image.dart';
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
                          image: NetworkImage(
                              '${getAll.users![index].images != null && getAll.users![index].images!.isNotEmpty ? getAll.users![index].images![1] : ''}'),
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
                                          Strings.genderss,
                                          style: mulish14400.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: ColorRes.darkGrey,
                                          ),
                                        ),
                                        Text(
                                          '${getAll.users![index].gender}',
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
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(50),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(50),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        '${getAll.users![index].degree}',
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
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(50),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        '${getAll.users![index].designation}',
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
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(50),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        '${getAll.users![index].company}',
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
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(50),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        '${getAll.users![index].profileScore}',
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
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        height: height * 0.5,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Other UI elements here
                              // ...
                              // Conditional check to show GridView or placeholder
                              getAll.users![index].images!.length > 1
                                  ? Container(
                                      height: 230,
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5,
                                          childAspectRatio: 0.9,
                                        ),
                                        itemCount:
                                            getAll.users![index].images!.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1),
                                            ),
                                            height: 230,
                                            width: 155,
                                            child: CachedNetworkImage(
                                              imageUrl: getAll
                                                  .users![index].images![index],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/images/image_placeholder.png',
                                      height: height * 0.58,
                                      width: width * 0.7,
                                      fit: BoxFit.fill,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
*/
