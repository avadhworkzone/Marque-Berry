// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialv/utils/color_utils.dart';

import '../../controllers/splash_controller.dart';
import '../../utils/assets/images_utils.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  SplashController splash = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorUtils.white,
      child: Image.asset(
        ImagesWidgets.splashGifImage,
      ),
    );
  }
}
