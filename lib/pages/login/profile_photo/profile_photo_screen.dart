import 'dart:io';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/pages/new/enter_personal_data/enter_personal_data_screen.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_family.dart';
import '../../../utils/texts.dart';

class ProfilePhotoScreen extends StatefulWidget {
  const ProfilePhotoScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  File? imageFile;
  int selectedindex = -1;
  String imageError = '';

  imageValidation() {
    if (imageFile == null) {
      setState(() {
        imageError = 'Add Profile Image';
      });
    } else {
      setState(() {
        imageError = "";
      });
    }
  }

  val() async {
    imageValidation();
  }

  validation() {
    val();
    if (imageError == '') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> pickImage(
      {required ImageSource source, required int index}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        selectedindex = index;
        imageList[index] = imageFile!;
      });
    } else {
      print('No image selected.');
    }
  }

  List<File> imageList = List.generate(9, (index) => File(''));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            Text(
              Strings.upload_profile,
              style: mulish14400.copyWith(
                  fontFamily: Fonts.poppinsBold,
                  color: ColorRes.darkGrey,
                  fontSize: 21),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Text(
              Strings.Please_upload,
              style: mulish14400.copyWith(fontFamily: Fonts.poppins),
            ),
            SizedBox(
              height: 13,
            ),
            Expanded(
              child: GridView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: MediaQuery.of(context).size.height / 3,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                    ),
                                    Text(
                                      Strings.add_photos,
                                      style: mulish14400.copyWith(
                                        fontSize: 24,
                                        fontFamily: Fonts.poppinsSemiBold,
                                        color: ColorRes.darkGrey,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              40,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        pickImage(
                                            index: index,
                                            source: ImageSource.gallery);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorRes.appColor,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                13,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1,
                                        child: Text(
                                          Strings.add_from_galary,
                                          style: mulish14400.copyWith(
                                            fontFamily: Fonts.poppins,
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              40,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        pickImage(
                                            index: index,
                                            source: ImageSource.camera);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorRes.appColor,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                13,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1,
                                        child: Text(
                                          Strings.use_camera,
                                          style: mulish14400.copyWith(
                                            fontFamily: Fonts.poppins,
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      setState(() {
                        selectedindex == index;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorRes.lightGrey,
                      ),
                      child: imageList[index].path.isEmpty
                          ? Image.asset(
                              AssertRe.gallary,
                              scale: 3,
                              //,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                imageList[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                    ),
                  );
                },
                itemCount: imageList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 7,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                ),
              ),
            ),
            imageError != ''
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        imageError,
                        style: errorText(),
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width / 1,
              child: CupertinoButton(
                  color: ColorRes.appColor,
                  child: Text(Strings.done),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (validation()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (c) => EnterPersonalDataScreen()));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
