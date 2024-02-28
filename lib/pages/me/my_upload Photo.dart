import 'package:date_madly_app/api/comment_api.dart';
import 'package:date_madly_app/common/text_feild_common.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/models/comment_model_new.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:date_madly_app/utils/text_style.dart';
import 'package:flutter/material.dart';

import '../../utils/font_family.dart';
import '../../utils/texts.dart';

class MyUpload_Photo extends StatefulWidget {
  MyUpload_Photo({super.key, required this.userId, required this.imageUrl});

  final String userId;
  final String imageUrl;

  @override
  State<MyUpload_Photo> createState() => _MyUpload_PhotoState();
}

class _MyUpload_PhotoState extends State<MyUpload_Photo> {
  TextEditingController controller = TextEditingController();

  Map<String, String> body = {};

  CommentModel commentModel = CommentModel();

  bool loader = false;

  val() async {
    commentValidation();
  }

  String commentError = '';
  commentValidation() {
    if (controller.text.trim() == "") {
      commentError = 'Enter the Comment';
      setState(() {});
    } else {
      commentError = '';

      setState(() {});
    }
  }

  validation() {
    val();
    if (commentError == '') {
      return true;
    } else {
      return false;
    }
  }

  uploadCommentApi() async {
    try {
      loader = true;

      setState(() {});
      commentModel = await CommentApi.commentApi(body, context);
      loader = false;
      setState(() {});
    } catch (e) {
      loader = false;
      setState(() {});
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Stack(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 375,
                width: double.maxFinite,
                child: Image(
                  image: AssetImage(
                    AssertRe.Add_Image_01,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 375,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: NewTextField(
                          controller: controller,
                          hintText: Strings.caption,
                          maxLines: 5),
                    ),
                    commentError.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              commentError,
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : SizedBox(),
                    GestureDetector(
                      onTap: () async {
                        // Navigator.pop(context);
                        body = {
                          "userId": widget.userId,
                          "commenterId": PrefService.getString(PrefKeys
                              .userId), // replace with the actual commenterId
                          "imageUrl": widget.imageUrl,
                          "text": controller.text,
                        };
                        if (validation()) {
                          await uploadCommentApi();
                        }
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
                              Strings.upload,
                              style: mulishbold.copyWith(
                                fontSize: 16,
                                color: ColorRes.white,
                                fontFamily: Fonts.poppinsBold,
                              ),
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
          loader == true
              ? Center(child: CircularProgressIndicator())
              : SizedBox(),
        ],
      ),
    );
  }
}
