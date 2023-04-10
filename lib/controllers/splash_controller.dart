import 'package:get/get.dart';
import 'package:flutter/scheduler.dart';
import 'package:socialv/routes/route_helper.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/auth/done_screen.dart';
import 'package:socialv/view/auth/login_screen.dart';
import 'package:socialv/view/bottomBar/bottombar.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // getMode();
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offAll(
        () => PreferenceUtils.getInt(key: PreferenceUtils.login) == 0
            ? LoginScreen()
            : PreferenceUtils.getWelcome() == 0
                ? DoneScreen()
                : BottomBar(),
      ),
    );

    super.onInit();
  }

  getMode() async {
    if (PreferenceUtils.getInt(key: PreferenceUtils.system) == 0) {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      await PreferenceUtils.setString(
        key: PreferenceUtils.mode,
        value: brightness.name,
      );
    }
  }
}
