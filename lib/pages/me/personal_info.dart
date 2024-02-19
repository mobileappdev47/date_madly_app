import 'package:date_madly_app/common/text_style.dart';
import 'package:flutter/material.dart';

import '../../common/text_feild_common.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  var currentIndex = -1;
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
          'Personal Info',
          style: appbarTitle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Provide personal information for the security of your account, do not give personal information to anyone.',
                  textAlign: TextAlign.center,
                  style: mulish14400.copyWith(color: ColorRes.darkGrey),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email Address',
                  style: mulish14400,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              NewTextField(
                controller: emailController,
                hintText: 'Brian03@gmail.com',
                color: ColorRes.darkGrey,
                suffix: 'assets/icons/Email.png',
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Number Phone',
                  style: mulish14400,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorRes.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(left: 15),
                child: TextField(
                  maxLines: 1,
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorRes.darkGrey,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '+62 812 0101 0101',
                    hintStyle: TextStyle(
                        color: ColorRes.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    suffixIcon: Image.asset(
                      'assets/icons/new_phone.png',
                      scale: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Birthday',
                  style: mulish14400,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              NewTextField(
                controller: emailController,
                hintText: 'January 5, 1996',
                color: ColorRes.darkGrey,
                readOnly: true,
                suffix: 'assets/icons/Date_Icon.png',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gender',
                    style: mulish14400,
                  )),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: gender.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Container(
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: index == currentIndex
                                        ? ColorRes.appColor
                                        : ColorRes.grey),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    genderIcon[index],
                                    scale: 3,
                                    color: index == currentIndex
                                        ? ColorRes.appColor
                                        : ColorRes.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    gender[index],
                                    style: mulish14400.copyWith(
                                      fontFamily: "MulishBold",
                                      fontSize: 13,
                                      color: index == currentIndex
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                    color: ColorRes.appColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: mulish14400.copyWith(
                          fontSize: 16,
                          color: ColorRes.white,
                          fontFamily: 'MulishBold'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List gender = ['Male', 'Female'];
  List genderIcon = ['assets/icons/Male.png', 'assets/icons/Female.png'];
}
