import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/color_utils.dart';

String imagesbasePath = 'assets/images';
String iconsbasePath = 'assets/icons';
String svgbasePath = 'assets/svg';
String lottiebasePath = 'assets/lotties';

/// Images
class ImagesWidgets {
  /// LOGO & SPLASH
  static String logoImage = '$imagesbasePath/logo.png';
  static Image logoISImage = Image.asset(logoImage, scale: 3.6.w);
}

class SvgWidgets {
  /// ON-BOARDING
  // static String onBoarding2String = '$svgbasePath/onboarding_2.svg';
  // static SvgPicture backBtnImage = SvgPicture.asset('assets/svg/back.svg');
}

class IconsWidgets {
  /// IMG NOT FOUND
  // static String notFoundImage = '$iconsbasePath/image-not-found.png';
  // static Image plugsImages =
  //     Image.asset('$iconsbasePath/plug.png', scale: 2.5.w);
  static Image drawerImage = Image.asset(
    '$iconsbasePath/drawer.png',
    width: 25.w,
  );

  /// appbar home
  static Image searchImage = Image.asset(
    "assets/icons/search.png",
    width: 7.w,
    height: 7.w,
  );
  static Image messageImage = Image.asset(
    "assets/icons/message.png",
    width: 7.w,
    height: 7.w,
  );
}

/// All Lotties

class LottieWidgts {
  static LottieBuilder loaderPrimary = Lottie.asset(
    '$lottiebasePath/loader.json',
    width: 30.w,
    fit: BoxFit.cover,
  );
  static LottieBuilder nointernet = Lottie.asset(
    '$lottiebasePath/nointernet.json',
    width: 30.w,
    fit: BoxFit.cover,
  );
}
