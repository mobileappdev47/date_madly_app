import 'dart:io';

import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/colors.dart';

class ProfilePhotoScreen extends StatefulWidget {
  const ProfilePhotoScreen({super.key});

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  File? imageFile;
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

  validation (){
    val();
    if(imageError == ''){
      return true;
    } else {
      return false;
    }
  }
  Future<void> pickImage({required source}) async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
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
                alignment: Alignment.centerLeft, child: GestureDetector(
                onTap: (){
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
              height: MediaQuery.of(context).size.height / 20,
            ),
            Text(
              'Please upload atleast one real photo of yourself to startliking profiles.',
              style: greyText(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    // Content of the bottom sheet
                    return Container(
                      decoration: BoxDecoration(

                          color: Colors.white,

                        borderRadius: BorderRadius.circular(20)
                      ),
                      height: MediaQuery.of(context).size.height/3,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 040),
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 15,
                              ),
                              Text(
                                'Add Photos',
                                style: title(),
                              ), SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                              Container(
                                padding: EdgeInsets.zero,
                                height: MediaQuery.of(context).size.height / 13,
                                width: MediaQuery.of(context).size.width / 1,
                                child: CupertinoButton(borderRadius: BorderRadius.circular(20),
                                    color: ColorRes.appColor,
                                    child: Text('ADD FROM GALLERY'),
                                    onPressed: () {
                                      pickImage(source: pickImage(source: ImageSource.gallery));
                                    }),
                              ), SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 13,
                                width: MediaQuery.of(context).size.width / 1,
                                child: CupertinoButton(
                                  borderRadius: BorderRadius.circular(20),
                                    color: ColorRes.appColor,
                                    child: Text('USE CAMERA'),
                                    onPressed: () {
                                      pickImage(source: pickImage(source: ImageSource.camera));
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    );

                  },
                );
              },
              child: Container(
                  height: MediaQuery.of(context).size.height / 2.2,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorRes.lightGrey),
                  child: imageFile == null
                      ? Image.asset(
                          'assets/icons/gallary.png',
                          scale: 1.5,
                        )
                      : Image.file(imageFile!,fit: BoxFit.fill)),
            ),
            imageError != '' ? Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  imageError,
                  style: errorText(),
                ),
              ),
            ): SizedBox(),
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
