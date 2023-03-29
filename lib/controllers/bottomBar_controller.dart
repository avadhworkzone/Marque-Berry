// ignore_for_file: file_names

import 'package:socialv/utils/const_utils.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  int selectedIndex = 0;

  void pageChange(int index) {
    selectedIndex = index;
    logs("INDEX======> $index");
    update();
  }
}
