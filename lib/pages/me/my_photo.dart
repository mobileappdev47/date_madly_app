import 'package:date_madly_app/pages/me/my_upload%20Photo.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:flutter/material.dart';

import '../../common/text_style.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';
import '../chat/call.dart';
import 'edit_profile.dart';
import 'main.dart';

class MyPhotoScreen extends StatelessWidget {
  const MyPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorRes.lgrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: Container(
          margin: EdgeInsets.only(
            bottom: 10,
          ),
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: ColorRes.grey, blurRadius: 10, spreadRadius: -2)
            ], // AppBar background color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: AppBar(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                // Remove the shadow
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorRes.appColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Row(
                  children: [
                    Text(
                      Strings.myPhoto,
                      style: mulishbold.copyWith(
                        fontSize: 18.75,
                        color: ColorRes.appColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Material(
                        elevation: 2,
                        shape: CircleBorder(),
                        color: Colors.white,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: ColorRes.appColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 3,
                ),
                itemCount: photoPic.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                    child: Image.asset(
                      photoPic[index],
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 35,
            right: 35,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPhotoScreen(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: ColorRes.white,
                    child: Image.asset(
                      AssertRe.Camera2,
                      scale: 2.5,
                      color: ColorRes.appColor,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyUpload_Photo(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: ColorRes.appColor,
                    child: Image.asset(
                      AssertRe.Upload_Icon,
                      scale: 1.1,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: ColorRes.white,
                    child: Image.asset(
                      AssertRe.Video_Call,
                      color: ColorRes.appColor,
                      scale: 3.5,
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
