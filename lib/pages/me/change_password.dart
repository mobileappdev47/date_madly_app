import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/text_feild_common.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController confirmController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmNewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            'Change Password',
            style: appbarTitle(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Current Password',
                  style: TextStyle(color: ColorRes.grey),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CommonTextField(
                padding: 10,
                color: ColorRes.darkGrey,
                obscureText: true,
                controller: confirmController,
                hintText: 'Current Password',
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'New Password',
                  style: TextStyle(color: ColorRes.grey),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CommonTextField(
                padding: 10,
                color: ColorRes.darkGrey,
                obscureText: true,
                controller: confirmController,
                hintText: 'New Password',
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirm New Password',
                  style: TextStyle(color: ColorRes.grey),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CommonTextField(
                padding: 10,
                color: ColorRes.darkGrey,
                obscureText: true,
                controller: confirmController,
                hintText: 'Confirm New Password',
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(30),
          child: GestureDetector(
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
        ),
      ),
    );
  }
}
