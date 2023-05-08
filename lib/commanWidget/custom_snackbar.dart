import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';

SnackbarController showSnackBar({
  // Color? snackColor,
  bool? snackbarSuccess = false,
  required String message,
}) {
  return Get.showSnackbar(
    GetSnackBar(
      // message: message.tr,
      duration: const Duration(seconds: 3),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,

      messageText: Center(
          child: AdoroText(
        message.tr,
        color: ColorUtils.white,
        textAlign: TextAlign.center,
      )),
      margin: EdgeInsets.only(bottom: 5.h, left: 40.sp, right: 40.sp),
      backgroundColor: Colors.black45,
      // backgroundColor:
      //     snackbarSuccess == true ? ColorUtils.green4E : ColorUtils.red29,
    ),
  );
}
