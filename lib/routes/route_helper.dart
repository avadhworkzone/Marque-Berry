import 'package:socialv/routes/route_constant.dart';
import 'package:socialv/view/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  ////ROUTE
  static String getSplashRoute() => RouteConstant.splash;

  //// LIST GETPAGE
  static List<GetPage> routes = [
    GetPage(name: RouteConstant.splash, page: () => SplashScreen()),
  ];
}
