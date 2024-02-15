import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import '../chat/call.dart';
import 'main.dart';

class MyPhotoScreen extends StatelessWidget {
  const MyPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white, // AppBar background color
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
                      "My Photo",
                      style: appbarTitle(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Material(
                        elevation: 5,
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //  childAspectRatio: 0.95,
                    crossAxisCount: 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 5
                    // childAspectRatio: 2,
                    // crossAxisSpacing: 40,
                    // mainAxisSpacing: 20
        
                    ),
                itemCount: photoPic.length,
                itemBuilder: (context, index) {
                  return Container(
                      height: 60,
                      child: Image.asset(
                        profilePic[index],
                      ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 120),
              child: Align(
                // alignment: Alignment(0.9, 0.1),
                alignment: Alignment.bottomCenter,
                child: Center(
                  // heightFactor: 4,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyPhotoScreen(),
                          ));
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: ColorRes.appColor,
                      child: Image.asset(
                        'assets/icons/Camera.png',
                        scale: 3.5,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
