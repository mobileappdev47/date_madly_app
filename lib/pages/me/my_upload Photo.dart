import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/text_style.dart';
import 'package:flutter/material.dart';

class MyUpload_Photo extends StatelessWidget {
  const MyUpload_Photo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/icons/Add Image_01.png"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Write a caption ...",
                        style: greyText(),
                      ),
                    ),
                    height: 115,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 2, color: ColorRes.lightGrey),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 30, right: 30,bottom: 30),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 11,
                      width: MediaQuery.of(context).size.width / 1,
                      decoration: BoxDecoration(
                          color: ColorRes.appColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                        'Save',
                        style: TextStyle(fontSize: 16, color: ColorRes.white),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 65,
            left: 29,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ColorRes.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
