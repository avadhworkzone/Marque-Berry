import 'package:get/get.dart';
import 'package:socialv/utils/color_utils.dart';

SnackbarController showSnackBar({
  // Color? snackColor,
  bool? snackbarSuccess = false,
  required String message,
}) {
  return Get.showSnackbar(
    GetSnackBar(
      message: message.tr,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:
          snackbarSuccess == true ? ColorUtils.green4E : ColorUtils.red29,
    ),
  );
}
