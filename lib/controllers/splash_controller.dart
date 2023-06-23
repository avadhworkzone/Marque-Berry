import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:socialv/appService/dynamic_link.dart';
import 'package:socialv/utils/shared_preference_utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    getMode();
    DynamicLink.getInitialDynamicLinks();
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
