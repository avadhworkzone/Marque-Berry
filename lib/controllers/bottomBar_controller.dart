// ignore_for_file: file_names

import 'package:get/get.dart';

class BottomBarController extends GetxController {
  int selectedIndex = 0;

  void pageChange(int index) {
    selectedIndex = index;
    update();
  }
}
