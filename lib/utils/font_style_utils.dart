import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/color_utils.dart';

/// FONT WEIGHT
class FontWeightClass {
  // static const fontWeight100 = FontWeight.w100;
  // static const fontWeight200 = FontWeight.w200;
  // static const fontWeight300 = FontWeight.w300;
  static const fontWeight400 = FontWeight.w400;
  static const fontWeight500 = FontWeight.w500;
  static const fontWeight600 = FontWeight.w600;
  static const fontWeight700 = FontWeight.w700;
  static const fontWeight800 = FontWeight.w800;
  // static const fontWeight900 = FontWeight.w900;
  static const fontWeightBold = FontWeight.bold;
  static const fontWeightNormal = FontWeight.normal;
}

/// FONT TEXT STYLE
class FontTextStyle {
  static TextStyle blackTextStyle = const TextStyle(color: ColorUtils.black);

  /// NO INTERNET
  static TextStyle noInternetStyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightClass.fontWeightBold,
  );
}
