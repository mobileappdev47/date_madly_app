// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:date_madly_app/api/add_like_dislike.dart';
// import 'package:date_madly_app/common/text_style.dart';
// import 'package:date_madly_app/pages/chat/new_provider.dart';
// import 'package:date_madly_app/pages/home/like_matches.dart';
// import 'package:date_madly_app/pages/me/my_gallery.dart';
// import 'package:date_madly_app/pages/me/my_upload%20Photo.dart';
// import 'package:date_madly_app/providers/home_main_provider.dart';
// import 'package:date_madly_app/utils/assert_re.dart';
// import 'package:date_madly_app/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../models/user_model.dart';
// import '../../utils/texts.dart';
// import '../me/main.dart';
//
//
// ladyBottomSheetUI(BuildContext context, GetAllUser getAll, int index) {
//   double width = MediaQuery.of(context).size.width;
//   double height = MediaQuery.of(context).size.height;
//   showModalBottomSheet<dynamic>(
//     backgroundColor: Colors.white,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(12),
//       ),
//     ),
//     context: context,
//     builder: (context) {
//       List dataList = [];
//
//       if (getAll.users![index].gender != '' &&
//           getAll.users![index].gender != null) {
//         dataList.add({
//           'data': 'Gender',
//           'detail': getAll.users![index].gender,
//         });
//       }
//       if (getAll.users![index].college != '' &&
//           getAll.users![index].college != null) {
//         dataList.add({
//           'data': 'College',
//           'detail': getAll.users![index].college,
//         });
//       }
//       if (getAll.users![index].job != '' && getAll.users![index].job != null) {
//         dataList.add({
//           'data': 'Designation',
//           'detail': getAll.users![index].job,
//         });
//       }
//       if (getAll.users![index].profileScore != '' &&
//           getAll.users![index].profileScore != null) {
//         dataList.add({
//           'data': 'Profile Score',
//           'detail': getAll.users![index].profileScore.toString(),
//         });
//       }
//       if (getAll.users![index].company != '' &&
//           getAll.users![index].company != null) {
//         dataList.add({
//           'data': 'Company',
//           'detail': getAll.users![index].company,
//         });
//       }
//       HomeMainProvider homeMainProvider =
//       Provider.of<HomeMainProvider>(context, listen: false);
//
//       return Wrap(
//         children: [
//           Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               Stack(
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.6,
//                         child: CachedNetworkImage(
//                           imageUrl:
//                               '${getAll.users![index].images != null && getAll.users![index].images!.isNotEmpty ? getAll.users![index].images![0] : ''}',
//                           fit: BoxFit.fill,
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.height * 0.6,
//                           placeholder: (context, url) => Image.asset(
//                             'assets/images/image_placeholder.png',
//                             width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height * 0.6,
//                             fit: BoxFit.fill,
//                           ),
//                           errorWidget: (context, url, error) => Image.asset(
//                             'assets/images/image_placeholder.png',
//                             width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height * 0.6,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.4,
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20, top: 30),
//                       child: Icon(
//                         Icons.arrow_back_ios_sharp,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Container(
//                     height: height * 0.64,
//                     // color: Colors.white10,
//                     width: width,
//                     child: Stack(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(top: 35),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 20),
//                           height: height * 0.6,
//                           width: width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(30),
//                               topLeft: Radius.circular(30),
//                             ),
//                             color: Colors.white,
//                           ),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       getAll.users?[index].name ?? "",
//                                       style: mulish14400.copyWith(
//                                         fontSize: 24,
//                                         fontWeight: FontWeight.w600,
//                                         color: ColorRes.darkGrey,
//                                       ),
//                                     ),
//                                     // Spacer(),
//                                     // GestureDetector(
//                                     //   onTap: () {
//                                     //     Navigator.push(
//                                     //         context,
//                                     //         MaterialPageRoute(
//                                     //           builder: (context) => MyUpload_Photo(
//                                     //               imageUrl:
//                                     //                   getAll.users![index].images?[0] ??
//                                     //                       '',
//                                     //               userId: getAll.users?[index].id ?? ''),
//                                     //         ));
//                                     //   },
//                                     //   child: Text(
//                                     //     'Comment',
//                                     //     style: mulish14400.copyWith(
//                                     //       fontSize: 18,
//                                     //       fontWeight: FontWeight.w600,
//                                     //       color: ColorRes.darkGrey,
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                   ],
//                                 ),
//
//                              SizedBox(
//                                   height: 20,
//                                 ),
//
//                              Row(
//                                   children: [
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width* 0.4,
//                                       child: Row(
//                                         children: [
//                                           getAll.users![index].job != null &&
//                                               getAll.users![index].job != ''
//                                               ? Image.asset(
//                                             'assets/icons/Worrk_Icon.png',
//                                             height: 18,
//                                             width: 18,
//                                             fit: BoxFit.contain,
//                                           )
//                                               : SizedBox(),
//                                           SizedBox(
//                                             width: 1.5,
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               getAll.users![index].job ?? '',
//                                               style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),
//
//
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(width: 7,),
//                                     Expanded(
//                                       child: SizedBox(
//                                         child:
//                                         Row(
//                                           children: [
//                                             getAll.users![index].company!= null &&
//                                                 getAll.users![index].company != ''
//                                                 ? Image.asset(
//                                               'assets/icons/Company.png',
//                                               height: 18,
//                                               width: 18,
//                                               fit: BoxFit.contain,
//                                             )
//                                                 : SizedBox(),
//                                             SizedBox(
//                                               width: 1.5,
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                 getAll.users![index].company ?? '',
//                                                 style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width* 0.4,
//
//                                       child:
//                                       Row(
//                                         children: [
//                                           getAll.users![index].location != null &&
//                                               getAll.users![index].location != ''
//                                               ? Image.asset(
//                                             'assets/icons/Location_Icon.png',
//                                             height: 20,
//                                             width: 18,
//                                             fit: BoxFit.contain,
//                                           )
//                                               : SizedBox(),
//                                           SizedBox(
//                                             width: 1.5,
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               getAll.users![index].location ?? '',
//                                               style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(width: 7,),
//
//                                     Expanded(
//                                       child: SizedBox(
//                                         width: MediaQuery.of(context).size.width* 0.4,
//                                         child: Row(
//                                           children: [
//
//                                             getAll.users![index].college != null &&
//                                                 getAll.users![index].college != ''
//                                                 ? Image.asset(
//                                               'assets/icons/Education_Icon.png',
//                                               height: 18,
//                                               width: 18,
//                                               fit: BoxFit.contain,
//                                             )
//                                                 : SizedBox(),
//                                             SizedBox(
//                                               width: 1.5,
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                 getAll.users![index].college ?? '',
//                                                 style: TextStyle(color: ColorRes.grey,overflow: TextOverflow.ellipsis),
//
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                                   /*      GridView.builder(
//                                   shrinkWrap: true,
//                                   itemCount: dataList.length,
//                                   physics: NeverScrollableScrollPhysics(),
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     mainAxisSpacing: 10,
//                                     crossAxisSpacing: 10,
//                                     childAspectRatio: 2,
//                                   ),
//                                   itemBuilder: (context, index) {
//                                     return Container(
//                                       height: 80,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: ColorRes.colorF4f4f4,
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             height: 30,
//                                             width: 30,
//                                             decoration: BoxDecoration(
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey
//                                                         .withOpacity(0.5),
//                                                     spreadRadius: 1,
//                                                     blurRadius: 2,
//                                                     offset: Offset(0, 3),
//                                                   ),
//                                                 ],
//                                                 borderRadius:
//                                                     BorderRadius.circular(50),
//                                                 color: Colors.grey.shade50),
//                                             child: Icon(
//                                               Icons.close,
//                                               color: ColorRes.darkGrey,
//                                               size: 14,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 7,
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 dataList[index]['data'],
//                                                 style: mulish14400.copyWith(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w300,
//                                                   color: ColorRes.darkGrey,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 dataList[index]?['detail'] ??
//                                                     '',
//                                                 style: mulish14400.copyWith(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w600,
//                                                   color: ColorRes.darkGrey,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 )*/
//
//    SizedBox(
//                                   height: 20,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       Strings.gallery,
//                                       style: mulish14400.copyWith(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w300,
//                                         color: ColorRes.darkGrey,
//                                       ),
//                                     ),
//                                     Spacer(),
//                                     InkWell(
//                                       child: Text(
//                                         Strings.seeall,
//                                         style: mulish14400.copyWith(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w300,
//                                           color: ColorRes.appColor,
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) => Profile(
//                                                   userId:
//                                                       getAll.users?[index].id ??
//                                                           ''),
//                                             ));
//                                       },
//                                     ),
//                                     Icon(
//                                       Icons.arrow_forward_outlined,
//                                       color: ColorRes.appColor,
//                                       size: 15,
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Container(
//                                   height: 230,
//                                   child: GridView.builder(
//                                     shrinkWrap: true,
//                                     physics: NeverScrollableScrollPhysics(),
//                                     gridDelegate:
//                                         SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 2,
//                                       mainAxisSpacing: 10,
//                                       crossAxisSpacing: 10,
//                                       childAspectRatio: 0.7,
//                                     ),
//                                     itemCount:
//                                         getAll.users![index].images!.length,
//                                     scrollDirection: Axis.vertical,
//                                     itemBuilder: (context, i) {
//                                       return ClipRRect(
//                                         borderRadius: BorderRadius.circular(10),
//                                         child: CachedNetworkImage(
//                                           imageUrl: (getAll.users![index]
//                                                           .images !=
//                                                       null &&
//                                                   getAll.users![index].images!
//                                                       .isNotEmpty)
//                                               ? getAll.users![index].images![i]
//                                               : '',
//                                           height: 230,
//                                           width: 155,
//                                           fit: BoxFit.cover,
//                                           errorWidget: (context, url, error) =>
//                                               Image.asset(
//                                                   height: 230,
//                                                   width: 155,
//                                                   'assets/images/image_placeholder.png',
//                                                   fit: BoxFit.cover),
//                                           placeholder: (context, url) =>
//                                               Image.asset(
//                                                   height: 230,
//                                                   width: 155,
//                                                   'assets/images/image_placeholder.png',
//                                                   fit: BoxFit.cover),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 70,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: Align(
//                                   alignment: Alignment.topCenter,
//                                   child: Container(
//                                     height: 50,
//                                     width: 50,
//                                     decoration: BoxDecoration(
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             spreadRadius: 1,
//                                             blurRadius: 2,
//                                             offset: Offset(
//                                                 0, 3), // changes position of shadow
//                                           ),
//                                         ],
//                                         borderRadius: BorderRadius.circular(50),
//                                         color: Colors.grey.shade50),
//                                     child: Icon(
//                                       Icons.close,
//                                       color: ColorRes.darkGrey,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 30,
//                               ),
//                               Align(
//                                 alignment: Alignment.topCenter,
//                                 child: GestureDetector(
//                                   onTap: () async {
//                                     if(getAll.users?[index].id != null){
//                                       try{
//                                         homeMainProvider.bottomSheetLoader= true ;
//                                         homeMainProvider.notifyListeners();
//                                         await AddLikedDislikeProfileApi.addLikedDislikeProfileapi(getAll.users![index].id, 1);
//                                         homeMainProvider.bottomSheetLoader= false ;
//                                         homeMainProvider.notifyListeners();
//                                       }catch(e){
//                                         homeMainProvider.bottomSheetLoader= false ;
//                                         homeMainProvider.notifyListeners();
//                                       }
//                                     }
//                                   },
//                                   child: Container(
//                                     height: 70,
//                                     width: 70,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(50),
//                                         color: ColorRes.appColor,
//                                         gradient: LinearGradient(
//                                           begin: Alignment.topCenter,
//                                           end: Alignment.bottomCenter,
//                                           colors: [
//                                             Color(
//                                               0xffED1E79,
//                                             ),
//                                             Color(
//                                               0xffC1272D,
//                                             ),
//                                           ],
//                                         ),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             spreadRadius: 1,
//                                             blurRadius: 2,
//                                             offset: Offset(
//                                                 0, 3), // changes position of shadow
//                                           ),
//                                         ]),
//                                     child: Icon(
//                                       Icons.favorite_border,
//                                       color: ColorRes.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 30,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: Align(
//                                   alignment: Alignment.topCenter,
//                                   child: Container(
//                                     height: 50,
//                                     width: 50,
//                                     decoration: BoxDecoration(
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             spreadRadius: 1,
//                                             blurRadius: 2,
//                                             offset: Offset(
//                                                 0, 3), // changes position of shadow
//                                           ),
//                                         ],
//                                         borderRadius: BorderRadius.circular(50),
//                                         color: Colors.grey.shade50),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.favorite_border,
//                                           color: ColorRes.appColor,
//                                           size: 18,
//                                         ),
//                                         SizedBox(
//                                           height: 2,
//                                         ),
//                                         Text(
//                                           '10',
//                                           style: TextStyle(
//                                               color: ColorRes.colorACACAC),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               homeMainProvider.bottomSheetLoader==true ? Center(child: CircularProgressIndicator()): SizedBox(),
//             ],
//           ),
//         ],
//       );
//     },
//   );
// }
//
//
//
//
//
//
//
//
//
