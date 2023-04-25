import 'package:get/get.dart';
import 'package:socialv/view/auth/done_screen.dart';
import 'package:socialv/view/auth/otp_screen.dart';
import 'package:socialv/routes/route_constant.dart';
import 'package:socialv/view/auth/login_screen.dart';
import 'package:socialv/view/bottomBar/bottombar.dart';
import 'package:socialv/view/splash/splash_screen.dart';

class RouteHelper {
  ////ROUTE
  static String getSplashRoute() => RouteConstant.splash;

  static String getLoginRoute() => RouteConstant.login;
  static String getValidateOTPRoute() => RouteConstant.validateOTP;
  static String getDoneRoute() => RouteConstant.done;
  static String getBottomRoute() => RouteConstant.bottom;

  //// LIST GETPAGE
  static List<GetPage> routes = [
    GetPage(name: RouteConstant.splash, page: () => SplashScreen()),

    ///
    GetPage(name: RouteConstant.login, page: () => LoginScreen()),
    GetPage(name: RouteConstant.validateOTP, page: () => ValidateOtpScreen()),
    GetPage(name: RouteConstant.done, page: () => DoneScreen()),

    GetPage(name: RouteConstant.bottom, page: () => BottomBar()),
  ];
}
