import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/color_utils.dart';

SnackbarController showSnackBar({Color? snackColor, required String message}) {
  return Get.showSnackbar(
    GetSnackBar(
      message: message.tr,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: snackColor ?? ColorUtils.primaryColor,
    ),
  );
}
