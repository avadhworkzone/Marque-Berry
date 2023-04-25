import 'package:get/get.dart';

class LoginController extends GetxController {
  int selectedIndex = 0;

  changeindex(index) {
    selectedIndex = index;
    update();
  }
}
