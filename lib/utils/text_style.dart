import 'package:flutter/material.dart';

import 'colors.dart';
import 'font_family.dart';

TextStyle greyText() {
  return TextStyle(
    color: ColorRes.grey,
    fontWeight: FontWeight.w300,
    fontSize: 12,
    fontFamily: 'Poppins'
  );
}

 TextStyle lightGreyText() {
  return TextStyle(
      fontFamily: 'Mushlin',
      color: ColorRes.grey, fontSize: 13);
}

TextStyle errorText() {
  return TextStyle(
      color: ColorRes.red,
      fontWeight: FontWeight.w400,
      fontSize: 10,
      fontFamily: 'Poppins'
  );
}

TextStyle popinsbold() {
  return TextStyle(
      color: ColorRes.darkGrey,
      fontWeight: FontWeight.w600,
      fontSize: 21,
      fontFamily: Fonts.poppinsBold
  );
}

TextStyle appbarTitle() {
  return TextStyle(
      color: ColorRes.appColor,
      fontWeight: FontWeight.w900,
      fontSize: 18,
      fontFamily: Fonts.poppins
  );
}