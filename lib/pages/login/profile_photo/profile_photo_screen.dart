
import 'dart:io';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/colors.dart';

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
        selectedindex =
            index;
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
                    child: Icon(Icons.arrow_back))),
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            Text(
              'Upload a profile Photo',
              style: title(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Text(
              'Please upload at least one real photo of yourself to start liking profiles.',
              style: greyText(),
            ),
            SizedBox(
              height: 13,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 7,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                children: List.generate(9, (index) {
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
                                      'Add Photos',
                                      style: title(),
                                    ),
                                    SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height /
                                          40,
                                    ),
                                    Container(
                                      padding: EdgeInsets.zero,
                                      height:
                                      MediaQuery.of(context).size.height /
                                          13,
                                      width:
                                      MediaQuery.of(context).size.width / 1,
                                      child: CupertinoButton(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          color: ColorRes.appColor,
                                          child: Text('ADD FROM GALLERY'),
                                          onPressed: () {
                                            pickImage(
                                                index: index,
                                                source: ImageSource.gallery);
                                          }),
                                    ),
                                    SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height /
                                          40,
                                    ),
                                    Container(
                                      height:
                                      MediaQuery.of(context).size.height /
                                          13,
                                      width:
                                      MediaQuery.of(context).size.width / 1,
                                      child: CupertinoButton(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          color: ColorRes.appColor,
                                          child: Text('USE CAMERA'),
                                          onPressed: () {
                                            pickImage(
                                                index: index,
                                                source: ImageSource.camera);
                                          }),
                                    )
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
                      child: index == selectedindex && imageFile != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          imageFile!,
                          fit: BoxFit.fill,
                        ),
                      )
                          : Image.asset(
                        'assets/icons/gallary.png',
                        scale: 2.0,
                        //,
                      ),
                    ),
                  );
                }),
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
                  child: Text('Done'),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (validation()) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (c) => HomeMain()));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
