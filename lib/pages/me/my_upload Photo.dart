import 'package:date_madly_app/common/text_feild_common.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/text_style.dart';
import 'package:flutter/material.dart';

class MyUpload_Photo extends StatelessWidget {
  MyUpload_Photo({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Stack(
        children: [
          SizedBox(
            height: 375,
            width: double.maxFinite,
            child: Image(
              image: AssetImage("assets/icons/Add Image_01.png"),
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 375,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: NewTextField(
                      controller: controller,
                      hintText: "Write a caption ...",
                      maxLines: 5),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 30, right: 30, bottom: 30),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1,
                      decoration: BoxDecoration(
                          color: ColorRes.appColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 16, color: ColorRes.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
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
