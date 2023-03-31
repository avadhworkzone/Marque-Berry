import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialv/utils/color_utils.dart';

AppBar customAppbar(final String title) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: ColorUtils.greyFA,
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(
        Icons.arrow_back,
        color: ColorUtils.black2E,
      ),
    ),
    title: Text(
      title,
      style: const TextStyle(color: ColorUtils.black2E),
    ),
  );
}
