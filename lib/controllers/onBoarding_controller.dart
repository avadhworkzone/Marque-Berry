// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnboardingController extends GetxController {
  RxInt selectedPageIndex = RxInt(0);
  var pageController = PageController();

  pageChange(v) {
    selectedPageIndex = RxInt(v);
    update();
  }

  zeroIndex() {
    selectedPageIndex = RxInt(0);
  }
}
