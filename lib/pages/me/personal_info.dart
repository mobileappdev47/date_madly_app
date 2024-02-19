import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:flutter/material.dart';

import '../../common/text_feild_common.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';

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
          Strings.personal_info,
          style: mulishbold.copyWith(
            fontSize: 18.75,
            color: ColorRes.appColor,
          ),
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
                  Strings.provide,
                  textAlign: TextAlign.center,
                  style: mulish14400.copyWith(
                    color: ColorRes.darkGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.email_address,
                  style: mulish14400.copyWith(fontSize: 14.06),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              NewTextField(
                controller: emailController,
                hintText: Strings.email,
                color: ColorRes.darkGrey,
                suffix: AssertRe.Email,
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.number_phone,
                  style: mulish14400.copyWith(fontSize: 14.06),
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
                    hintText: Strings.number,
                    hintStyle: TextStyle(
                        color: ColorRes.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    suffixIcon: Image.asset(
                      AssertRe.new_phone,
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
                  Strings.birthday,
                  style: mulish14400.copyWith(fontSize: 14.06),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              NewTextField(
                controller: emailController,
                hintText: Strings.January5,
                color: ColorRes.darkGrey,
                readOnly: true,
                suffix: AssertRe.Date_Icon,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Strings.gender,
                    style: mulish14400.copyWith(fontSize: 14.06),
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
                                    AssertRe.genderIcon[index],
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
                                    style: mulishbold.copyWith(
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
                      Strings.save,
                      style: mulishbold.copyWith(
                        fontSize: 16,
                        color: ColorRes.white,
                      ),
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
}
