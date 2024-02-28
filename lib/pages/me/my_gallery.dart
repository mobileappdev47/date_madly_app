import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/me/my_photo.dart';
import 'package:date_madly_app/pages/me/my_upload%20Photo.dart';
import 'package:date_madly_app/pages/me/widgets/profile_view_bottomsheet.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';
import 'main.dart';

class MyGalleryScreen extends StatefulWidget {
  const MyGalleryScreen({super.key});

  @override
  State<MyGalleryScreen> createState() => _MyGalleryScreenState();
}

class _MyGalleryScreenState extends State<MyGalleryScreen> {
  bool isClick = false;
  bool isClicked = false;
  var currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: ColorRes.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorRes.appColor,
            )),
        title: Text(
          Strings.mygallery,
          style: mulishbold.copyWith(
            fontSize: 20,
            color: ColorRes.appColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image.asset(
                          AssertRe.addimageprofile,
                          scale: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => MyUpload_Photo(),
                            //   ),
                            // );
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ColorRes.white,
                            ),
                            child: Image.asset(
                              AssertRe.Edit_Icon,
                              scale: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text(getEmail().toString()),
                  Text(
                    Strings.brianimmanuel,
                    style: mulishbold.copyWith(
                      fontSize: 23.44,
                      color: ColorRes.darkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    Strings.graphicdesigner,
                    style: mulishbold.copyWith(
                      fontSize: 18.75,
                      color: ColorRes.grey,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            Strings.size,
                            style: mulishbold.copyWith(
                              fontSize: 32.81,
                              color: ColorRes.darkGrey,
                            ),
                          ),
                          Text(
                            Strings.photo,
                            style: mulishbold.copyWith(
                              fontSize: 14.06,
                              color: ColorRes.grey,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            Strings.size2,
                            style: mulishbold.copyWith(
                              fontSize: 32.81,
                              color: ColorRes.darkGrey,
                            ),
                          ),
                          Text(
                            Strings.video,
                            style: mulishbold.copyWith(
                              fontSize: 14.06,
                              color: ColorRes.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 65,
                    child: ListView.builder(
                        padding: EdgeInsets.only(left: 0),
                        scrollDirection: Axis.horizontal,
                        itemCount: year.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentindex = index;
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      width: 160,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          year[index],
                                          scale: 2.5,
                                          color: index == currentindex
                                              ? ColorRes.appColor
                                              : ColorRes.grey,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: 3,
                                        width: 160,
                                        color: index == currentindex
                                            ? ColorRes.appColor
                                            : Colors.transparent)
                                  ],
                                ),
                              ),
                            )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: photoPic.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            profileViewBottomSheet(context);
                          },
                          child: Container(
                            height: 60,
                            child: Image.asset(
                              photoPic[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 480),
            child: Align(
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
                      AssertRe.Camera,
                      scale: 3.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List year = [
    AssertRe.Feed,
    AssertRe.Movie,
  ];
}
