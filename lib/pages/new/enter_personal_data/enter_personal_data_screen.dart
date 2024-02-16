import 'dart:io';

import 'package:date_madly_app/common/text_feild_common.dart';
import 'package:date_madly_app/pages/home/main.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../common/text_style.dart';
import '../../../utils/text_style.dart';

class EnterPersonalDataScreen extends StatefulWidget {
  const EnterPersonalDataScreen({Key? key}) : super(key: key);

  @override
  State<EnterPersonalDataScreen> createState() =>
      _EnterPersonalDataScreenState();
}

class _EnterPersonalDataScreenState extends State<EnterPersonalDataScreen> {
  @override
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  bool isMale = true;
  bool isFemale = false;
  File? imageFile;
  var currentindex = 0;
  List gender = ['Male', 'Female'];
  List genderIcon = ['assets/icons/Male.png', 'assets/icons/Female.png'];
  Future<void> pickImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile =
            File(pickedFile.path); // Update imageFile with selected image
      });
    } else {
      print('No image selected.');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          GestureDetector(
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
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 15,
                            ),
                            Text(
                              'Add Photos',
                              style: title(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 40,
                            ),
                            Container(
                              padding: EdgeInsets.zero,
                              height: MediaQuery.of(context).size.height / 13,
                              width: MediaQuery.of(context).size.width / 1,
                              child: CupertinoButton(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorRes.appColor,
                                child: Text('ADD FROM GALLERY'),
                                onPressed: () {
                                  pickImage(source: ImageSource.gallery);
                                  Navigator.pop(
                                      context); // Close bottom sheet after selecting image
                                },
                              ),
                            ),
                            SizedBox(
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
                                  pickImage(source: ImageSource.camera);
                                  Navigator.pop(
                                      context); // Close bottom sheet after selecting image
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Stack(
              children: [
                Container(
                  height: 225,
                  width: 375,
                  decoration: BoxDecoration(
                    color: ColorRes.lightGrey,
                  ),
                  child: imageFile == null
                      ? SizedBox()
                      : ClipRRect(
                          child: Image.file(
                            imageFile!,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
                // Conditionally display the camera icon only if imageFile is null
                if (imageFile == null)
                  Center(
                    heightFactor: 9,
                    child: Image.asset(
                      "assets/icons/Camera.png",
                      height: 25,
                      width: 29,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 42,
                  ),
                  Text(
                    'Name',
                    style: mulish14400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NewTextField(
                    controller: nameController,
                    hintText: 'Enter name',
                    suffix: 'assets/icons/Human_Icon.png',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Birthday',
                    style: mulish14400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var picked = await showDatePicker(
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: ColorRes.grey,
                              colorScheme: const ColorScheme.light(
                                  primary: ColorRes.darkGrey),
                              buttonTheme: const ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary),
                            ),
                            child: child!,
                          );
                        },
                        context: context,
                        firstDate: DateTime(1970),
                        // the earliest allowable
                        lastDate: DateTime.now(),
                        // the latest allowable
                        currentDate: DateTime.now(),
                        initialDate: DateTime.now(),
                      );
                      birthDateController.text = dateFormat.format(picked!);
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorRes.grey),
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: birthDateController,
                        enabled: false,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: ColorRes.darkGrey,
                        ),
                        decoration: InputDecoration(
                            hintText: 'DD/MM/YYYY',
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 13.0),
                              child: Image.asset(
                                'assets/icons/Date_Icon.png',
                                color: ColorRes.grey,
                                scale: 3,
                              ),
                            )),
                        onChanged: ((value) => {print(value)}),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Gender',
                    style: mulish14400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: gender.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentindex = index;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: 175,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: index == currentindex
                                              ? ColorRes.appColor
                                              : ColorRes.grey),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          genderIcon[index],
                                          scale: 3,
                                          color: index == currentindex
                                              ? ColorRes.appColor
                                              : ColorRes.grey,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          gender[index],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: index == currentindex
                                                ? ColorRes.appColor
                                                : ColorRes.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Location',
                    style: mulish14400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NewTextField(
                    controller: locationController,
                    hintText: 'Enter location',
                    suffix: 'assets/icons/Location_Icon.png',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Job',
                    style: mulish14400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NewTextField(
                    controller: jobController,
                    hintText: 'Enter job',
                    suffix: 'assets/icons/Worrk_Icon.png',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Company',
                    style: mulish14400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NewTextField(
                    controller: companyController,
                    hintText: 'Enter company',
                    suffix: 'assets/icons/Company_Icon.png',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'College',
                    style: mulish14400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NewTextField(
                    controller: collegeController,
                    hintText: 'Enter college',
                    suffix: 'assets/icons/Education_Icon.png',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'About Me',
                    style: mulish14400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorRes.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "I'm here when you need a sunny day, something good We can sing together on the beach and burn bonfires at night with the moonlight.",
                        style: mulish14400.copyWith(
                            color: ColorRes.darkGrey, fontSize: 12),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => HomeMain()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        color: ColorRes.appColor,
                      ),
                      child: Text('Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
