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
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  var currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
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
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                  'Provide personal information for the security of your account, do not give personal information to anyone.'),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email Address',
                  style: lightGreyText(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              NewTextField(
                controller: emailController,
                hintText: 'Brian03@gmail.com',
                color: ColorRes.darkGrey,
                readOnly: true,
                suffix: 'assets/icons/Email.png',
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Number Phone',
                  style: lightGreyText(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              NewTextField(
                controller: emailController,
                hintText: '+62 812 0101 0101',
                color: ColorRes.darkGrey,
                suffix: 'assets/icons/Phone.png',
              ),
              // NewTextField(
              //   hintText:
              //
              //   readOnly: true,
              //
              // ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Birthday',
                  style: lightGreyText(),
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
                    style: lightGreyText(),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              SizedBox(
                height: 45,
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
                              width: 140,
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
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
            ],
          ),
        ),
      ),
    );
  }

  List gender = ['Male', 'Female'];
  List genderIcon = ['assets/icons/Male.png', 'assets/icons/Female.png'];
}
