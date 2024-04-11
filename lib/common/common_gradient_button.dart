import 'package:date_madly_app/common/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CommonGradientButton extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? color;
  final String? text;
  final String? textColor;
  final VoidCallback? ontap;

  const CommonGradientButton(
      {super.key,
      this.height,
      this.width,
      this.color,
      this.text,
      this.textColor,
      this.ontap});

  @override
  State<CommonGradientButton> createState() => _CommonGradientButtonState();
}

class _CommonGradientButtonState extends State<CommonGradientButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap ?? () {},
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // color: ColorRes.appColor,

          borderRadius: BorderRadius.circular(
            67,
          ),
          gradient: LinearGradient(colors: [
            Color(0xffC1272D),
            Color(0xffED1E79),
          ]),
        ),
        child: Center(
          child: Text(
            widget.text ??'Continue'.toUpperCase(),
            style: inter.copyWith(color: Colors.white, fontSize: 18.4),
          ),
        ),
      ),
    );
  }
}
