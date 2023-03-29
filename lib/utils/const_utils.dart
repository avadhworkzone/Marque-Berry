import 'dart:developer';
import 'package:socialv/utils/color_utils.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ConstUtils {}

logs(String message) {
  if (kDebugMode) {
    log(message);
  }
}

/// GET DISTANCE
///

/// TEXT FORM BORDER
OutlineInputBorder transparentBorder = const OutlineInputBorder(
  borderSide: BorderSide(color: ColorUtils.transparent),
);
OutlineInputBorder outlineBorder = OutlineInputBorder(
  borderSide: BorderSide(color: ColorUtils.primaryColor, width: 0.5.w),
);
OutlineInputBorder errorBorder = OutlineInputBorder(
  borderSide: BorderSide(color: ColorUtils.red29, width: 0.5.w),
);
OutlineInputBorder roundedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.w),
  borderSide: BorderSide(color: ColorUtils.primaryColor, width: 0.6.w),
);
InputBorder noneBorder = InputBorder.none;
