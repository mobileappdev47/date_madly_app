// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:date_madly_app/pages/chat/call.dart';
// import 'package:date_madly_app/pages/chat/chat_message.dart';
// import 'package:date_madly_app/service/pref_service.dart';
// import 'package:date_madly_app/utils/colors.dart';
// import 'package:date_madly_app/utils/font_family.dart';
// import 'package:date_madly_app/utils/pref_key.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class PickUpScreen extends StatefulWidget {
//   PickUpScreen({super.key, required this.otherEmail, required this.photo, required this.callerName});
//
//   final String otherEmail;
//   final String photo;
//   final String callerName;
//
//   @override
//   State<PickUpScreen> createState() => _PickUpScreenState();
// }
//
// class _PickUpScreenState extends State<PickUpScreen> {
//   @override
//   Widget build(BuildContext context) {
//
//
//        FirebaseFirestore.instance
//         .collection('calls').doc(channelName).get().then((value) async {
//
//       print('-----------------------------------888888888888888888888888888888${value.data()}');
//
//       if(value.data()!=null && value.data()!.isNotEmpty){
//         return
//           Scaffold(
//             backgroundColor: ColorRes.white,
//             appBar: AppBar(
//               centerTitle: true,
//               backgroundColor: ColorRes.white,
//               leading: GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Icon(
//                     Icons.arrow_back_ios_new_rounded,
//                     color: ColorRes.grey,
//                   )),
//
//             ),
//             body: Column(
//               children: [
//                 SizedBox(
//                   height: 90,
//                 ),
//                 Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     ClipOval(
//                       child: Image.network(
//                         widget.photo,
//                         height: 120,
//                         width: 120,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 5.0, right: 5),
//                       child: CircleAvatar(
//                         radius: 11,
//                         backgroundColor: ColorRes.white,
//                         child: CircleAvatar(
//                           radius: 8,
//                           backgroundColor: ColorRes.green,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   widget.callerName,
//                   style: TextStyle(
//                       color: ColorRes.darkGrey,
//                       fontSize: 28,
//                       fontFamily: Fonts.mulishBold,
//                       fontWeight: FontWeight.w700),
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Text('Incoming Call.......',
//                     style: TextStyle(
//                         color: ColorRes.darkGrey,
//                         fontSize: 12,
//                         fontFamily: Fonts.mulishRegular,
//                         fontWeight: FontWeight.w400)),
//                 SizedBox(
//                   height: 170,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         join();
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 80,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle
//                           ,
//
//                           color: Colors.green,
//
//                         ),
//                         child: Image.asset('assets/icons/Call.png', scale: 3.5),
//                       ),
//                     ),
//                     SizedBox(width: 20,),
//                     GestureDetector(
//                       onTap: () {
//                         leave(context);
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 80,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle
//                           ,
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Color(0xffED1E79,),
//                               Color(0xffC1272D,),
//                             ],
//                           ),
//                         ),
//                         child: Image.asset('assets/icons/Call_hangUp.png', scale: 3.5),
//                       ),
//                     ),
//                   ],
//                 ),
//
//               ],
//             ),
//           );
//       }
//       else {
// return Container();
//       }
//     });
//
//
//
//
//
//
//
//   }
// }


import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_madly_app/pages/chat/call.dart';
import 'package:date_madly_app/pages/chat/chat_message.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/font_family.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PickUpScreen extends StatefulWidget {
  PickUpScreen({super.key, required this.otherEmail, required this.photo, required this.callerName});

  final String otherEmail;
  final String photo;
  final String callerName;

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  @override
  Widget build(BuildContext context) {
    return
                StreamBuilder<QuerySnapshot>(
                  stream:     FirebaseFirestore.instance
                    .collection('calls').where(FieldPath.documentId,isEqualTo: channelName)
                    .snapshots(), builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {

                    return SizedBox();
                  }

                  if (snapshot.hasError) {
                    Navigator.pop(context);
                    return Text('Error: ${snapshot.error}');
                  }


                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    Navigator.pop(context);
                    return Text('No calls found');
                  }



        var documentSnapshot = snapshot.data!.docs.first;
      Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
       print(map);
    if(map['receiverId'] == PrefService.getString(PrefKeys.userId)){


      return
        Scaffold(
          backgroundColor: ColorRes.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: ColorRes.white,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ColorRes.grey,
                )),

          ),
          body: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipOval(
                    child: Image.network(
                      widget.photo,
                      height: 120,
                      width: 120,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, right: 5),
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: ColorRes.white,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: ColorRes.green,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.callerName,
                style: TextStyle(
                    color: ColorRes.darkGrey,
                    fontSize: 28,
                    fontFamily: Fonts.mulishBold,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 4,
              ),
              Text('Incoming Call.......',
                  style: TextStyle(
                      color: ColorRes.darkGrey,
                      fontSize: 12,
                      fontFamily: Fonts.mulishRegular,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 170,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      join();
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle
                        ,

                        color: Colors.green,

                      ),
                      child: Image.asset('assets/icons/Call.png', scale: 3.5),
                    ),
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      leave(context);
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle
                        ,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffED1E79,),
                            Color(0xffC1272D,),
                          ],
                        ),
                      ),
                      child: Image.asset('assets/icons/Call_hangUp.png', scale: 3.5),
                    ),
                  ),
                ],
              ),

            ],
          ),
        );


    }


    else {

      return SizedBox();
    }



                    },);
  }
}
