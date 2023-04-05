import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:socialv/routes/route_helper.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    getMode();
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offAllNamed(
        PreferenceUtils.getInt(key: PreferenceUtils.login) == 0
            ? RouteHelper.getLoginRoute()
            : PreferenceUtils.getInt(key: PreferenceUtils.welcome) == 0
                ? RouteHelper.getDoneRoute()
                : RouteHelper.getBottomRoute(),
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
