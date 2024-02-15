import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/text_style.dart';

class CommonField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? ontap;
  final String? label;

  const CommonField({super.key, required this.controller, this.label, this.ontap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ColorRes.appColor,
      onTap: ontap,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: greyText(),
        hintStyle: TextStyle(color: Colors.black)
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final String label;
  final TextEditingController con;
  final Widget? prefix;
  final bool isprefix;
  final Widget? sufix;
  final bool issufix;
  final bool? isclick;
  const PasswordField(
      {Key? key,
      required this.con,
      this.prefix,
      required this.isprefix,
      this.sufix,
      required this.issufix,
      this.isclick,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier _visiblePassword = ValueNotifier<bool>(true);

    return ValueListenableBuilder(
      valueListenable: _visiblePassword,
      builder: (context, value, child) => TextFormField(
        obscureText: value,
        controller: con,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: greyText(),
          hintStyle: greyText(),
          prefixIcon: isprefix
              ? IconButton(
                  iconSize: 18,
                  icon: prefix ?? SizedBox(),
                  onPressed: () {},
                )
              : SizedBox(),
          suffixIcon: issufix
              ? IconButton(
                  color: ColorRes.black,
                  iconSize: 18,
                  onPressed: () =>
                      _visiblePassword.value = !_visiblePassword.value,
                  icon: value
                      ? Icon(
                          Icons.visibility_off,
                          color: ColorRes.grey,
                        )
                      : Icon(Icons.visibility_rounded, color: ColorRes.grey))
              : SizedBox(),
        ),
      ),
    );
  }
}
