import 'package:date_madly_app/api/changePassword_api.dart';
import 'package:date_madly_app/common/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../api/log_in_api.dart';
import '../../../../common/text_feild_common.dart';
import '../../../../models/changePassword_model.dart';
import '../../../../service/pref_service.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/pref_key.dart';
import '../../../../utils/text_style.dart';
import '../../../../utils/texts.dart';
import 'changepassword_provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String textPassword = '';
  Map<String, dynamic> body = {};
  bool loader = false;

  // ChangePasswordModel changePasswordModel = ChangePasswordModel();

  currentpassword(
      String? currentPassword, String? newPassword, String? userId) async {
    try {
      loader = true;
      setState(() {});
      await ChangePasswordApi.changepasswordapi(body, context);
      loader = false;
      setState(() {});
    } catch (e) {
      loader = false;
      setState(() {});
      print('==============>${e.toString()}');
    }
  }

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
  @override
  Widget build(BuildContext context) {
    print(PrefService.getString(PrefKeys.password));
    return Consumer<ChangePasswordProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                Strings.change_password,
                style: mulishbold.copyWith(
                  fontSize: 20,
                  color: ColorRes.appColor,
                ),
              ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Strings.current_password,
                            style: mulish14400.copyWith(
                                color: ColorRes.grey, fontSize: 14.06),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        NewTextField(
                          controller: value.currentController,
                          hintText: Strings.current_password,
                          color: ColorRes.darkGrey,
                          obscureText: true,
                        ),
                        value.currentError != ""
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    value.currentError,
                                    style: errorText(),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Strings.new_password,
                            style: mulish14400.copyWith(
                                color: ColorRes.grey, fontSize: 14.06),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        NewTextField(
                          controller: value.passwordController,
                          hintText: Strings.new_password,
                          color: ColorRes.darkGrey,
                          obscureText: true,
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
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Strings.confirm_new_password,
                            style: mulish14400.copyWith(
                                color: ColorRes.grey, fontSize: 14.06),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        NewTextField(
                          controller: value.confirmPasswordController,
                          hintText: Strings.confirm_new_password,
                          color: ColorRes.darkGrey,
                          obscureText: true,
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
                      ],
                    ),
                  ),
                ),
                loader == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(30),
              child: GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  body = {
                    "_id": PrefService.getString(PrefKeys.userId),
                    "newPassword": value.passwordController.text,
                    "currentPassword": PrefService.getString(PrefKeys.password),
                  };
                  if (value.validation()) {
                    print('validation conform');
                    await currentpassword(
                      PrefService.getString(PrefKeys.password),
                      textPassword,
                      PrefService.getString(PrefKeys.userId),
                    );
                    // print('${changePasswordModel.message}');
                  }
                  // Navigator.pop(context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 11,
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
                  )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
/*
import 'package:flutter/material.dart';
import '../service/login_api.dart';

class ChangePasswordPage extends StatefulWidget {
  final String userId;
  final String currentPassword;

  ChangePasswordPage({required this.userId, required this.currentPassword});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
              ),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            SizedBox(height: 20),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (currentPasswordController.text != widget.currentPassword) {
                  setState(() {
                    errorMessage = 'Current password is incorrect';
                  });
                } else if (newPasswordController.text !=
                    confirmPasswordController.text) {
                  setState(() {
                    errorMessage = 'New passwords do not match';
                  });
                } else {
                  _changePassword();
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword() async {
    String message = await LoginApi.changePassword(
      widget.userId,
      currentPasswordController.text,
      newPasswordController.text,
    );

    setState(() {
      errorMessage = message;
    });
  }
}
put condation user inputed currentpassword and login time geted password is match then call api change password
*/
