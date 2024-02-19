import 'package:date_madly_app/common/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/text_feild_common.dart';
import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';

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
            Strings.change_password,
            style: mulishbold.copyWith(
              fontSize: 20,
              color: ColorRes.appColor,
            ),
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
                  Strings.current_password,
                  style: mulish14400.copyWith(
                    color: ColorRes.grey,fontSize: 14.06
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              NewTextField(
                controller: confirmController,
                hintText: Strings.current_password,
                color: ColorRes.darkGrey,
                obscureText: true,
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.new_password,
                  style: mulish14400.copyWith(
                    color: ColorRes.grey,fontSize: 14.06
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              NewTextField(
                controller: newController,
                hintText: Strings.new_password,
                color: ColorRes.darkGrey,
                obscureText: true,
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.confirm_new_password,
                  style: mulish14400.copyWith(
                    color: ColorRes.grey,fontSize: 14.06
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              NewTextField(
                controller: confirmNewController,
                hintText: Strings.confirm_new_password,
                color: ColorRes.darkGrey,
                obscureText: true,
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
  }
}
