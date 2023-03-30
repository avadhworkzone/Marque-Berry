import 'package:socialv/routes/route_helper.dart';
import 'package:get/get.dart';

import '../view/auth/login_screen.dart';
import '../view/bottomBar/bottombar.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      // () => Get.offAllNamed(
      // PreferenceUtils.getOnboarding() == 0
      //     ? RouteHelper.getOnBoardingRoute()
      //     : PreferenceUtils.getWelcomeLogin() == 0
      //         ? RouteHelper.getWelcomeLoginRoute()
      //         : RouteHelper.getBottomBarRoute(),
      // ),
      () => Get.off(LoginScreen()),
    );

    super.onInit();
  }
}
