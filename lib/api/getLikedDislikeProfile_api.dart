import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/liked_dislike_profile_model.dart';
import '../service/http_services.dart';
import '../service/pref_service.dart';
import '../utils/endpoint.dart';
import '../utils/pref_key.dart';

class LikedDislikeProfileApi {
  static likedDislikeProfileapi(
    String? likeid,
    int? status,
  ) async {
    try {
      var data = {
        "userID": PrefService.getString(PrefKeys.userId),
        "likedID": likeid,
        "status": status,
      };
      String url = EndPoints.addLikeDislikeProfile;
      http.Response? response = await HttpService.postApi(
        body: data,
        url: url,
      );

      print('Status Code===========${response!.statusCode}');
      if (response != null && response.statusCode == 200) {
        return likedDislikeProfileFromJson(response.body);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      return null;
    }
  }
}
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   String? selectGender;
//   Map<String, dynamic> body = {};
//
//   List swipeList = [
//     AssertRe.homelady,
//     AssertRe.homelady,
//     AssertRe.homelady,
//   ];
//   bool loder = false;
//   GetAllUser getAll = GetAllUser();
//   LikedDislikeProfile likedDislikeProfileApis = LikedDislikeProfile();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getallapicall();
//   }
//
//   int status = 0;
//
//   getallapicall() async {
//     try {
//       loder = true;
//       setState(() {});
//       getAll = await GetAllApi.getallApi();
//       loder = false;
//       setState(() {});
//     } catch (e) {
//       print('==============>${e.toString()}');
//     }
//   }
//
//   LikeDislikeapicall(String? id) async {
//     try {
//       loder = true;
//       setState(() {});
//       likedDislikeProfileApis =
//       await LikedDislikeProfileApi.likedDislikeProfileapi(id, status);
//       loder = false;
//       setState(() {});
//     } catch (e) {
//       print('==============>${e.toString()}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//     return Consumer<HomeMainProvider>(
//       builder: (context, value, child) => Scaffold(
//         backgroundColor: ColorRes.white,
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: ColorRes.white,
//           leading: Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: Image.asset(
//                   AssertRe.drawer,
//                   scale: 3,
//                 ),
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//               );
//             },
//           ),
//           title: Text(
//             Strings.home,
//             style: mulishbold.copyWith(
//               fontSize: 18.75,
//               color: ColorRes.appColor,
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: IconButton(
//                 onPressed: () {
//                   value.showNotificationContainer(context);
//                 },
//                 icon: Image.asset(
//                   AssertRe.notification,
//                   scale: 2.5,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         drawer: Drawer(backgroundColor: ColorRes.white, child: CustomDrawer()),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             getAll.users != null && getAll.users!.length > 1
//                 ? Expanded(
//               child: Align(
//                 alignment: Alignment.center,
//                 child: CardSwiper(
//                   isDisabled: false,
//                   backCardOffset: const Offset(10, 0),
//                   initialIndex: 10,
//                   padding: EdgeInsets.zero,
//                   cardsCount: getAll.users?.length ?? 0,
//                   cardBuilder: (context,
//                       index,
//                       horizontalOffsetPercentage,
//                       verticalOffsetPercentage) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onPanUpdate: (details) async {
//                             if (details.delta.dx > 0) {
//                               // Swiped right
//                               log('true============${getAll.users![index].id}');
//                               await LikeDislikeapicall(
//                                   getAll.users![index].id);
//                             } else if (details.delta.dx < 0) {
//                               // Swiped left
//                               log('false=============${getAll.users![index].id}');
//
//                               await LikeDislikeapicall(
//                                   getAll.users![index].id);
//                             }
//                             setState(() {});
//                           },
//                           child: Container(
//                             height: height * 0.68,
//                             width: width * 0.8,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(40),
//                                 bottomRight: Radius.circular(
//                                   40,
//                                 ),
//                                 topRight: Radius.circular(40),
//                                 topLeft: Radius.circular(
//                                   40,
//                                 ),
//                               ),
//                             ),
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(10),
//                                         topRight: Radius.circular(10)),
//                                     child: CachedNetworkImage(
//                                       imageUrl: (getAll.users != null &&
//                                           getAll.users!.isNotEmpty &&
//                                           getAll.users![index]
//                                               .images !=
//                                               null &&
//                                           getAll.users![index].images!
//                                               .isNotEmpty)
//                                           ? getAll
//                                           .users![index].images![0]
//                                           : '',
//                                       fit: BoxFit.fill,
//                                       placeholder: (context, url) =>
//                                           Image.asset(
//                                             'assets/images/image_placeholder.png',
//                                             height: height * 0.68,
//                                             width: width * 0.8,
//                                             fit: BoxFit.fill,
//                                           ),
//                                       errorWidget:
//                                           (context, url, error) =>
//                                           Image.asset(
//                                             'assets/images/image_placeholder.png',
//                                             height: height * 0.68,
//                                             width: width * 0.8,
//                                             fit: BoxFit.fill,
//                                           ),
//                                     ),
//                                   ),
//                                 ),
//                                 //getAll.users![index].images![1],
//                                 Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     Column(
//                                       // mainAxisAlignment:
//                                       //     MainAxisAlignment.center,
//                                       // crossAxisAlignment:
//                                       //     CrossAxisAlignment.end,
//                                       children: [
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                         Text(
//                                           (getAll.users![index].name !=
//                                               null &&
//                                               getAll.users![index]
//                                                   .name!.isNotEmpty)
//                                               ? getAll.users![index].name!
//                                               : '',
//                                           style: mulishbold.copyWith(
//                                             color: ColorRes.darkGrey,
//                                             fontSize: 20,
//                                           ),
//                                         ),
//                                         //SizedBox(height: 10,),
//                                         Text(
//                                           Strings.modelfashion,
//                                           style: mulish14400.copyWith(
//                                             fontSize: 12,
//                                             color: ColorRes.grey,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       width: 60,
//                                     ),
//                                     Image.asset(
//                                       AssertRe.Location_Icon,
//                                       scale: 4.5,
//                                       color: ColorRes.appColor,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       Strings.homeKM,
//                                       style: mulish14400.copyWith(
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           onTap: () {
//                             ladyBottomSheetUI(context);
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             )
//                 : SizedBox(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //       builder: (context) => LikesYouScreen(),
//                       //     ));
//                     },
//                     child: Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 1,
//                               blurRadius: 2,
//                               offset:
//                               Offset(0, 3), // changes position of shadow
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(50),
//                           color: Colors.grey.shade50),
//                       child: Icon(
//                         Icons.close,
//                         color: ColorRes.darkGrey,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   GestureDetector(
//                     onTap: () async {},
//                     child: Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           color: ColorRes.appColor),
//                       child: Icon(
//                         Icons.favorite_border,
//                         color: ColorRes.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 60,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// class LikedDislikeProfileApi {
//   static Future<LikedDislikeProfile?> likedDislikeProfileapi(Map<String, dynamic> body) async {
//     try {
//       var headers = {'Content-Type': 'application/json'};
//       var url = 'YOUR_API_ENDPOINT'; // Replace with your API endpoint
//       var response = await http.post(Uri.parse(url), headers: headers, body: json.encode(body));
//
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         return LikedDislikeProfile.fromJson(jsonData);
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Exception occurred: $e');
//       return null;
//     }
//   }
// }
//
// class LikedDislikeProfile {
//   List<LikedDislikeProfileElement>? likedDislikeProfile;
//
//   LikedDislikeProfile({
//     this.likedDislikeProfile,
//   });
//
//   factory LikedDislikeProfile.fromJson(Map<String, dynamic> json) => LikedDislikeProfile(
//     likedDislikeProfile: json["likedDislikeProfile"] == null
//         ? null
//         : List<LikedDislikeProfileElement>.from(json["likedDislikeProfile"].map((x) => LikedDislikeProfileElement.fromJson(x))),
//   );
// }
//
// class LikedDislikeProfileElement {
//   String? id;
//   String? userId;
//   LikedId? likedId;
//   int? status;
//   int? v;
//
//   LikedDislikeProfileElement({
//     this.id,
//     this.userId,
//     this.likedId,
//     this.status,
//     this.v,
//   });
//
//   factory LikedDislikeProfileElement.fromJson(Map<String, dynamic> json) => LikedDislikeProfileElement(
//     id: json["_id"],
//     userId: json["userID"],
//     likedId: json["likedID"] == null ? null : LikedId.fromJson(json["likedID"]),
//     status: json["status"],
//     v: json["__v"],
//   );
// }
//
// class LikedId {
//   String? id;
//   String? name;
//   List<String>? images;
//   DateTime? dob;
//
//   LikedId({
//     this.id,
//     this.name,
//     this.images,
//     this.dob,
//   });
//
//   factory LikedId.fromJson(Map<String, dynamic> json) => LikedId(
//     id: json["_id"],
//     name: json["name"],
//     images: List<String>.from(json["images"].map((x) => x)),
//     dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//   );
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   LikedDislikeProfile? _likedDislikeProfile;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     Map<String, dynamic> requestBody = {
//       // Add your request parameters here
//     };
//
//     var likedDislikeProfile = await LikedDislikeProfileApi.likedDislikeProfileapi(requestBody);
//     setState(() {
//       _likedDislikeProfile = likedDislikeProfile;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: _likedDislikeProfile != null
//             ? Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Liked Dislike Profile Data:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             if (_likedDislikeProfile!.likedDislikeProfile != null)
//               for (var element in _likedDislikeProfile!.likedDislikeProfile!)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('ID: ${element.id}'),
//                     Text('User ID: ${element.userId}'),
//                     if (element.likedId != null) ...[
//                       Text('Liked ID: ${element.likedId!.id}'),
//                       Text('Liked Name: ${element.likedId!.name}'),
//                       if (element.likedId!.dob != null)
//                         Text('DOB: ${element.likedId!.dob!.toIso8601String()}'),
//                       Text('Images: ${element.likedId!.images}'),
//                     ],
//                     SizedBox(height: 10),
//                   ],
//                 ),
//           ],
//         )
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: HomeScreen(),
//   ));
// }

// class LikedDislikeProfileApis {
//   static Future<LikedDislikeProfile?> likedDislikeProfileapi(
//       Map<String, dynamic> body, context) async {
//     try {
//       var headers = {'Content-Type': 'application/json'};
//       var request = http.Request(
//         'POST',
//         Uri.parse(EndPoints.getLikedDislikeProfile),
//       );
//       request.body = json.encode(body);
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//       print('Status Code===========${response.statusCode}');
//
//       if (response.statusCode == 200) {
//         var data = await response.stream.bytesToString();
//         var likedDislikeProfile = likedDislikeProfileFromJson(data);
//         PrefService.setValue(PrefKeys.userId, data);
//         return likedDislikeProfile;
//       } else {
//         print('Something went wrong');
//         return null;
//       }
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   LikedDislikeProfile? likedDislikeProfile;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchLikedDislikeProfile();
//   }
//
//   void fetchLikedDislikeProfile() async {
//     Map<String, dynamic> body = {
//       // You can pass any necessary parameters here
//     };
//
//     LikedDislikeProfile? profile =
//         await LikedDislikeProfileApi.likedDislikeProfileapi(body, context);
//     setState(() {
//       likedDislikeProfile = profile;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: likedDislikeProfile != null
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Liked Dislike Profile Data:',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   SizedBox(height: 20),
//                   // Display your LikedDislikeProfile data here as needed
//                 ],
//               )
//             : CircularProgressIndicator(), // Show loading indicator while data is being fetched
//       ),
//     );
//   }
// }
