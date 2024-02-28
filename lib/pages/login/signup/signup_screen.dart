import 'package:date_madly_app/api/sign_up_api.dart';
import 'package:date_madly_app/common/common_field.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/models/sign_up_model.dart';
import 'package:date_madly_app/pages/login/login/login_screen.dart';
import 'package:date_madly_app/pages/login/signup/signup_provider.dart';
import 'package:date_madly_app/pages/me/additional_details.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/text_feild_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_family.dart';
import '../../../utils/text_style.dart';
import '../../../utils/texts.dart';
import '../../new/enter_personal_data/enter_personal_data_screen.dart';
import '../Login_with_phone.dart';
import '../profile_photo/profile_photo_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String textPassword = '';
  String textConfirm = '';
  Map<String, dynamic> body = {};
  bool loader = false;
  SignUpModel signup = SignUpModel();

  signUpApiCall() async {
    try {
      loader = true;
      setState(() {});
      signup = await SignUpApi.signUpApi(body: body, context: context,password: textPassword);
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
    return Consumer<SignUpProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Strings.sign_up,
                            style: mulish14400.copyWith(
                              fontFamily: Fonts.poppins,
                              fontWeight: FontWeight.w700,
                              color: ColorRes.darkBlue,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            Strings.cancle,
                            style: TextStyle(color: ColorRes.appColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RichText(
                          text: TextSpan(
                              text: Strings.by_click,
                              style: mulish14400,
                              children: [
                            TextSpan(
                                text: Strings.parken,
                                style: greyText().copyWith(
                                  fontWeight: FontWeight.w700,
                                )),
                            TextSpan(
                              text: Strings.acknlowledge,
                              style: greyText(),
                            ),
                            TextSpan(
                                text: Strings.Privacy,
                                style: mulish14400.copyWith(
                                  fontWeight: FontWeight.w700,
                                )),
                          ])),
                      SizedBox(height: 40),
                      CommonField(
                        label: Strings.emails,
                        controller: value.emailController,
                      ),
                      value.emailError != ""
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  value.emailError,
                                  style: errorText(),
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: 20),
                      CommonField(
                        label: Strings.name,
                        controller: value.nameController,
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
                      SizedBox(height: 20),
                      TextField(
                        controller: value.dobController,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: ColorRes.appColor,
                        ),
                        onTap: () => value.selectDate(context),
                        decoration: InputDecoration(
                          labelText: Strings.date_of_birth,
                          labelStyle: mulish14400.copyWith(
                              fontSize: 14, fontFamily: Fonts.poppins),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorRes.colorE5E5E5,
                            ),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorRes.colorE5E5E5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorRes.colorE5E5E5,
                            ),
                          ),
                        ),
                      ),
                      value.dobError != ""
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  value.dobError,
                                  style: errorText(),
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: 20),
                      TextField(
                        controller: value.passwordController,
                        obscureText: value.obscureText,
                        onChanged: (value) {
                          setState(() {
                            textPassword = value;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorRes.colorE5E5E5,
                            ),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorRes.colorE5E5E5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorRes.colorE5E5E5,
                            ),
                          ),
                          labelText: Strings.password,
                          labelStyle: mulish14400.copyWith(
                              fontSize: 14, fontFamily: Fonts.poppins),
                          suffixIcon: IconButton(
                            icon: Icon(
                              !value.obscureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                value.obscureText = !value.obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      value.passwordError != ""
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  value.passwordError,
                                  style: errorText(),
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: 20),
                      TextField(
                        controller: value.confirmPasswordController,
                        obscureText: value.confirmPass,
                        onChanged: (value) {
                          setState(() {
                            textConfirm = value;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorRes.colorE5E5E5,
                            ),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorRes.colorE5E5E5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorRes.colorE5E5E5,
                            ),
                          ),
                          labelText: Strings.conform_passwod,
                          labelStyle: greyText(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              !value.confirmPass
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                value.confirmPass = !value.confirmPass;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      value.confirmPasswordError != ""
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  value.confirmPasswordError,
                                  style: errorText(),
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AssertRe.check,
                            scale: 3,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              child: Text(
                            Strings.password_must,
                            style:
                                TextStyle(fontSize: 12, color: ColorRes.black),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 11,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 13,
                        width: MediaQuery.of(context).size.width / 1,
                        child: CupertinoButton(
                            color: ColorRes.appColor,
                            child: Text(
                              Strings.sign_up,
                              style: mulish14400.copyWith(
                                  fontSize: 14,
                                  color: ColorRes.white,
                                  fontFamily: Fonts.poppinsBold),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              body = {
                                "name": value.nameController.text,
                                "email": value.emailController.text,
                                "password": value.passwordController.text,
                                "dob": value.dobController.text,
                                "type": "email"
                              };
                              if (value.validation()) {
                                await signUpApiCall();
                                await PrefService.setValue(
                                    PrefKeys.email, value.emailController.text);
                                await PrefService.setValue(
                                    PrefKeys.password, value.passwordController.text);
                              }
                            }),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: ColorRes.appColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 11,
                      ),
                    ],
                  ),
                ),
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
