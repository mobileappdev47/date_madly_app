import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  CommonTextField(
      {Key? key,
        required this.controller,
        required this.hintText,
        this.suffix,
        this.textInputType,
        this.isSuffixIcon,
        this.isPrefixIcon,
        this.prefix,
        this.labelText,
        this.readOnly,
        this.color,
        this.padding,
        this.obscureText})
      : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool? isPrefixIcon;
  final String? prefix;
  final String? suffix;
  bool? readOnly;
  final Color? color;
  bool? obscureText;
  final double? padding;
  final bool? isSuffixIcon;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorRes.grey),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: TextField(
        obscureText: obscureText ?? false,
        readOnly: readOnly ?? false,
        keyboardType: textInputType ?? TextInputType.text,
        controller: controller,
        // keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: padding ?? 0.0),
            labelText: labelText ?? '',
            hintText: hintText ?? '',
            hintStyle: TextStyle(color: color ?? ColorRes.grey),
            border: InputBorder.none,
            suffixIcon: isSuffixIcon != null
                ? suffix != null
                ? Padding(
              padding: const EdgeInsets.only(right: 13.0),
              child: Image.asset(
                suffix ?? "",
                color: ColorRes.grey,
                scale: 3,
              ),
            )
                : SizedBox()
                : null,
            prefixIcon: isPrefixIcon != null
                ? prefix != null
                ? Padding(
              padding: const EdgeInsets.only(right: 13.0),
              child: Image.asset(
                prefix ?? "",
                color: ColorRes.grey,
                scale: 3,
              ),
            )
                : SizedBox()
                : null),

        // onTap: () {},
        // onChanged: ((value) => {print(value)}),
      ),
    );
  }
}

