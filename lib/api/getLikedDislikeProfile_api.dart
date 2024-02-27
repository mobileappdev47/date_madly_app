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
      String url = EndPoints.getLikedDislikeProfile;
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
