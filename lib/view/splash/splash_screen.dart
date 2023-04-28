// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:get/get.dart';

import '../../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  SplashController splash = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorUtils.white,
      child: Container(
        width: Get.width,
        height: Get.height,
        child: Image.asset(
          "assets/images/splash.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
