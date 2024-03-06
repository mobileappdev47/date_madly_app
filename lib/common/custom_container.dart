import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomContainer extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? color;
  final String? text;
  final String? textColor;
  const CustomContainer(
      {super.key,
      this.height,
      this.width,
      this.color,
      this.text,
      this.textColor});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 11,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            color: ColorRes.appColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          'Continue',
          style: TextStyle(fontSize: 16, color: ColorRes.white),
        )),
      ),
    );
  }
}
