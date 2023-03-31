import 'package:get/get.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/auth/interest.dart';
import 'package:socialv/view/auth/login_screen.dart';
import 'package:socialv/view/bottomBar/bottombar.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.to(
        () => PreferenceUtils.getInt(key: PreferenceUtils.login) == 0
            ? LoginScreen()
            : PreferenceUtils.getInt(key: PreferenceUtils.welcome) == 0
                ? InterestScreen()
                : BottomBar(),
      ),
    );

    super.onInit();
  }
}
