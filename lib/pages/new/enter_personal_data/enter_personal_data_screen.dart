import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/api/get_single_profile_api.dart';
import 'package:date_madly_app/models/get_single_profile_model.dart';
import 'package:date_madly_app/pages/login/profile_photo/profile_photo_screen.dart';
import 'package:date_madly_app/pages/new/enter_personal_data/personal_data_provider.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../api/updateuserfeilds_api.dart';
import '../../../common/text_feild_common.dart';
import '../../../common/text_style.dart';
import '../../../models/update_user.dart';
import '../../../utils/assert_re.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_style.dart';
import '../../../utils/texts.dart';
import '../../home/main.dart';

class EnterPersonalDataScreen extends StatefulWidget {
  const EnterPersonalDataScreen({Key? key}) : super(key: key);

  @override
  State<EnterPersonalDataScreen> createState() =>
      _EnterPersonalDataScreenState();
}

class _EnterPersonalDataScreenState extends State<EnterPersonalDataScreen> {
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  bool isMale = true;
  bool isFemale = false;
  File? imageFile;
  var currentindex = 0;
  List gender = ['Male', 'Female'];
  List genderIcon = ['assets/icons/Male.png', 'assets/icons/Female.png'];
  bool obscureText = true;
  bool confirmPass = true;

  Future<void> pickImage({required ImageSource source}) async {
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

  Map<String, String> body = {};
  bool loader = false;
  UpdateUsers updateUsers = UpdateUsers();

  updateApiCall(BuildContext context) async {
    try {
      loader = true;
      setState(() {});
      updateUsers = await UpdateUserApi.updateUsers(body, context, imageFile);
      loader = false;
      setState(() {});
    } catch (e) {
      loader = false;
      setState(() {});
      print(e.toString());
    }
  }

  GetSingleProfileModel getSingleProfileModel = GetSingleProfileModel();

  getSingleProfileApi() async {
    try {
      loader = true;
      setState(() {});
      getSingleProfileModel =
          await GetSingleProfileApi.getSingleProfileApi(context);

      loader = false;
      setState(() {});
    } catch (e) {
      loader = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    getSingleProfileApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(getSingleProfileModel);
    return Consumer<Updateprovider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePhotoScreen(
                                from: 'enter',
                                networkImageListApi:
                                    getSingleProfileModel.profile?[0].images ??
                                        []),
                          ));
                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return Container(
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //       height: MediaQuery.of(context).size.height / 3,
                      //       child: Center(
                      //         child: Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 40),
                      //           child: Column(
                      //             children: [
                      //               SizedBox(
                      //                 height:
                      //                     MediaQuery.of(context).size.height /
                      //                         15,
                      //               ),
                      //               Text(
                      //                 'Add Photos',
                      //                 style: popinsbold(),
                      //               ),
                      //               SizedBox(
                      //                 height:
                      //                     MediaQuery.of(context).size.height /
                      //                         40,
                      //               ),
                      //               GestureDetector(
                      //                 onTap: () {
                      //                   pickImage(source: ImageSource.gallery);
                      //                   Navigator.pop(context);
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color: ColorRes.appColor,
                      //                       borderRadius:
                      //                           BorderRadius.circular(20)),
                      //                   padding: EdgeInsets.zero,
                      //                   height:
                      //                       MediaQuery.of(context).size.height /
                      //                           13,
                      //                   width:
                      //                       MediaQuery.of(context).size.width /
                      //                           1,
                      //                   child: Text('ADD FROM GALLERY',
                      //                       style: TextStyle(
                      //                         color: Colors.white,
                      //                       )),
                      //                   alignment: Alignment.center,
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 height:
                      //                     MediaQuery.of(context).size.height /
                      //                         40,
                      //               ),
                      //               GestureDetector(
                      //                 onTap: () {
                      //                   pickImage(source: ImageSource.camera);
                      //                   Navigator.pop(context);
                      //                 },
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color: ColorRes.appColor,
                      //                       borderRadius:
                      //                           BorderRadius.circular(20)),
                      //                   padding: EdgeInsets.zero,
                      //                   height:
                      //                       MediaQuery.of(context).size.height /
                      //                           13,
                      //                   width:
                      //                       MediaQuery.of(context).size.width /
                      //                           1,
                      //                   child: Text('USE CAMERA',
                      //                       style: TextStyle(
                      //                         color: Colors.white,
                      //                       )),
                      //                   alignment: Alignment.center,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 225,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: ColorRes.lightGrey,
                          ),
                          child: imageFile == null
                              ? CachedNetworkImage(
                                  imageUrl: getSingleProfileModel
                                          .profile?[0].images?[0] ??
                                      '',
                                  fit: BoxFit.fill,
                                  height: 225,
                                  width: MediaQuery.of(context).size.width,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/images/image_placeholder.png',
                                    fit: BoxFit.fill,
                                    height: 225,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/image_placeholder.png',
                                    fit: BoxFit.fill,
                                    height: 225,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                )
                              : ClipRRect(
                                  child: Image.file(
                                    imageFile!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        ),
                        Center(
                          heightFactor: 9,
                          child: Image.asset(
                            AssertRe.camera,
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
                            Strings.name,
                            style: mulish14400,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NewTextField(
                            controller: value.nameController,
                            hintText: Strings.enter_name,
                            suffix: AssertRe.human_Icon,
                          ),
                          value.nameError != ""
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      value.nameError,
                                      style: errorText(),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            Strings.birthday,
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
                                lastDate: DateTime.now(),
                                currentDate: DateTime.now(),
                                initialDate: DateTime.now(),
                              );
                              value.dobController.text =
                                  dateFormat.format(picked!);
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
                                controller: value.dobController,
                                enabled: false,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: ColorRes.darkGrey,
                                ),
                                decoration: InputDecoration(
                                  hintText: Strings.dats,
                                  border: InputBorder.none,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 13.0),
                                    child: Image.asset(
                                      AssertRe.Date_Icon,
                                      color: ColorRes.grey,
                                      scale: 3,
                                    ),
                                  ),
                                ),
                                onChanged: ((value) => {print(value)}),
                              ),
                            ),
                          ),
                          value.dobError != ""
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      value.nameError,
                                      style: errorText(),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            Strings.gender,
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
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentindex = index;
                                      value.gender =
                                          gender[index]; // Update gender value
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Container(
                                      width: 145,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: index == currentindex
                                              ? ColorRes.appColor
                                              : ColorRes.grey,
                                        ),
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
                                          SizedBox(width: 10),
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
                                ),
                              ),
                            ),
                          ),
                          value.genderError != ""
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      value.genderError,
                                      style: errorText(),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(height: 30),
                          Text(Strings.Location, style: mulish14400),
                          SizedBox(height: 10),
                          NewTextField(
                            controller: value.locationController,
                            hintText: Strings.ELocation,
                            suffix: AssertRe.Location_Icon,
                          ),
                          value.locationError != ""
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      value.locationError,
                                      style: errorText(),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(height: 30),
                          Text(Strings.job, style: mulish14400),
                          SizedBox(height: 10),
                          NewTextField(
                            controller: value.jobController,
                            hintText: Strings.enter_job,
                            suffix: AssertRe.Worrk_Icon,
                          ),
                          value.jobError != ""
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      value.jobError,
                                      style: errorText(),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(height: 30),
                          Text(Strings.company, style: mulish14400),
                          SizedBox(height: 10),
                          NewTextField(
                            controller: value.companyController,
                            hintText: Strings.enter_company,
                            suffix: AssertRe.Company_Icon,
                          ),
                          value.companyError != ""
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      value.companyError,
                                      style: errorText(),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(height: 30),
                          Text(Strings.college, style: mulish14400),
                          SizedBox(height: 10),
                          NewTextField(
                            controller: value.collegeController,
                            hintText: Strings.enter_college,
                            suffix: AssertRe.Education_Icon,
                          ),
                          value.collegeError != ""
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      value.collegeError,
                                      style: errorText(),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(height: 30),
                          Text(Strings.about_me, style: mulish14400),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: ColorRes.grey, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: value.aboutController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              body = {
                                "_id": PrefService.getString(PrefKeys.userId),
                                "name": value.nameController.text,
                                "dob": value.dobController.text,
                                "gender": value.gender,
                                "location": value.locationController.text,
                                "job": value.jobController.text,
                                "company": value.companyController.text,
                                "college": value.collegeController.text,
                                "about": value.aboutController.text,
                              };
                              if (value.validation()) {
                                // await updateApiCall(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeMain(),
                                    ));
                              } // Call the API method
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorRes.appColor,
                              ),
                              child: Text(
                                Strings.Continue,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
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
      },
    );
  }
}
