import 'package:get/get.dart';

class OtpController extends GetxController {
  bool hasError = false;

  changeerror(val) {
    hasError = val;
    update();
  }

  String currentText = "";
  changeotp(val) {
    currentText = val;
  }
}
