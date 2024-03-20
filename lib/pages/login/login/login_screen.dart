// import 'package:date_madly_app/common/text_feild_common.dart';
// import 'package:date_madly_app/utils/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../common/text_style.dart';
// import '../../../utils/font_family.dart';
// import '../../../utils/texts.dart';
//
// class LoginScreen extends StatefulWidget {
//   LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//   bool obscureText = true;
//   String textPassword = '';
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorRes.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   Strings.log_in,
//                   style: mulish14400.copyWith(
//                     fontSize: 24,
//                     color: ColorRes.darkGrey,
//                     fontFamily: Fonts.poppinsBold,
//                   ),
//                 ),
//                 Spacer(),
//                 Text(
//                   Strings.cancle,
//                   style: mulish14400.copyWith(
//                     fontSize: 12,
//                     color: ColorRes.appColor,
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Text(
//               Strings.emails,
//               style: TextStyle(color: ColorRes.grey),
//             ),
//             NewTextField(
//               controller: emailcontroller,
//               hintText: Strings.email,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               Strings.password,
//               style: TextStyle(color: ColorRes.grey),
//             ),
//             TextField(
//               controller: passwordcontroller,
//               obscureText: obscureText,
//               onChanged: (value) {
//                 setState(() {
//                   textPassword = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: ColorRes.colorE5E5E5,
//                   ),
//                 ),
//                 disabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: ColorRes.colorE5E5E5,
//                   ),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: ColorRes.colorE5E5E5,
//                   ),
//                 ),
//                 labelText: Strings.password,
//                 labelStyle: mulish14400.copyWith(
//                     fontSize: 14, fontFamily: Fonts.poppins),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     !obscureText
//                         ? Icons.visibility_outlined
//                         : Icons.visibility_off_outlined,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       obscureText = !obscureText;
//                     });
//                   },
//                 ),
//               ),
//             ),
//
//             SizedBox(
//               height: 30,
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height / 13,
//               width: MediaQuery.of(context).size.width / 1,
//               child: CupertinoButton(
//                 color: ColorRes.appColor,
//                 child: Text(
//                   Strings.log_in,
//                   style: mulish14400.copyWith(
//                       fontSize: 14,
//                       color: ColorRes.white,
//                       fontFamily: Fonts.poppinsBold),
//                 ),
//                 onPressed: () async {},
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:date_madly_app/api/log_in_api.dart';
import 'package:date_madly_app/api/sign_up_api.dart';
import 'package:date_madly_app/common/common_field.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:date_madly_app/models/sign_up_model.dart';
import 'package:date_madly_app/pages/login/login/login_provider.dart';
import 'package:date_madly_app/service/notification_service.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String textPassword = '';
  String textConfirm = '';
  Map<String, dynamic> body = {};
  bool loader = false;

  String lat = '';
  String long = '';
  Future getCurrentLatLang() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      LocationPermission result = await Geolocator.requestPermission();
      if (result == LocationPermission.always ||
          result == LocationPermission.whileInUse) {
        getCurrentLatLang();
      }
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      lat = position.latitude.toString();
      long = position.longitude.toString();
    }
  }
  void disposeKeyboard() {
    return FocusManager.instance.primaryFocus?.unfocus();
  }

  loginapi() async {
    try {
      loader = true;
      setState(() {});
      await LoginApi.login(body, context, textPassword, lat, long);
      loader = false;
      setState(() {});
    } catch (e) {
      loader = false;
      setState(() {});
      print(e.toString());
    }
  }

  @override
  void initState() {
    getCurrentLatLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: GestureDetector(
            onTap: () {
              disposeKeyboard();
            },
            child: Stack(
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: ColorRes.appColor,
                              ),
                            ),
                            Text(
                              Strings.log_in,
                              style: mulish14400.copyWith(
                                fontFamily: Fonts.poppins,
                                fontWeight: FontWeight.w700,
                                color: ColorRes.darkBlue,
                                fontSize: 18,
                              ),
                            ),
                            Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.transparent,
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
                                Strings.log_in,
                                style: mulish14400.copyWith(
                                    fontSize: 14,
                                    color: ColorRes.white,
                                    fontFamily: Fonts.poppinsBold),
                              ),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                String? token =
                                    await NotificationService.getToken();
                                body = {
                                  "email": value.emailController.text,
                                  "password": value.passwordController.text,
                                  'newDeviceTokens': [token],
                                };
                                if (value.validation()) {
                                  await loginapi();
                                }
                              }),
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
          ),
        );
      },
    );
  }
}
