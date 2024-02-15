import 'package:date_madly_app/common/common_field.dart';
import 'package:date_madly_app/pages/login/signup/signup_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/text_feild_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_style.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: SingleChildScrollView(
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
                        'Sign Up',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: ColorRes.darkBlue,
                            fontSize: 18),
                      ),
                      Text(
                        'Cancel',
                        style: TextStyle(color: ColorRes.appColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'By click the sign up button, you’re agree to ',
                          style: greyText(),
                          children: [
                            TextSpan(
                                text: 'Parken’s Terms and Service ',
                                style: greyText().copyWith(
                                  fontWeight: FontWeight.w700,
                                )),
                            TextSpan(
                              text: 'and acknlowledge the ',
                              style: greyText(),
                            ),
                            TextSpan(
                                text: 'Privacy and Policy',
                                style: greyText().copyWith(
                                  fontWeight: FontWeight.w700,
                                )),
                          ])),
                  SizedBox(height: 40),
                  CommonField(
                    label: 'Email',
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
                    label: 'Name',
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
                  CommonField(
                    ontap: ()=> value.selectDate(context),
                    label: 'Date of Birth',
                    controller: value.dobController,
                  ),
                  value.dobError != ""
                      ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        value. dobError,
                        style: errorText(),
                      ),
                    ),
                  )
                      : SizedBox(),
                  SizedBox(height: 20),
                  TextField(
                    controller:value. passwordController,
                    obscureText:value.obscureText,
                    onChanged: (value) {
                     setState(() {
                        textPassword = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: greyText(),
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
                    controller:value. confirmPasswordController,
                    obscureText: value.confirmPass,
                    onChanged: (value) {
                      setState(() {
                         textConfirm  = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: greyText(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          !value.  confirmPass
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            value.  confirmPass = !value.confirmPass;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Image.asset('assets/icons/check (1).png',scale: 3,),
                      SizedBox(width: 4,),
                      Text('Password must be at least 8 character, uppercase,\n lowercase, and unique code like #%!',style: greyText(),),
                    ],
                  ),

                  value. confirmPasswordError != ""
                      ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        value. confirmPasswordError,
                        style: errorText(),
                      ),
                    ),
                  )
                      : SizedBox(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 11,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 13,
                    width: MediaQuery.of(context).size.width / 1,
                    child: CupertinoButton(
                        color: ColorRes.appColor,
                        child: Text('Sign Up'),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (value.validation()) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (c) => ProfilePhotoScreen()));
                          }
                        }),
                  ),SizedBox(
                    height: MediaQuery.of(context).size.height / 11,
                  ),

                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
