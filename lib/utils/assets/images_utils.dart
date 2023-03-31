import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

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

  ///APPBAR HOME
  static String drawerImage = '$iconsbasePath/drawer.png';
  static String messageImage = '$iconsbasePath/message.png';
  static String searchImage = '$iconsbasePath/search.png';

  static String heartImage = '$iconsbasePath/heart.png';
  static String chatImage = '$iconsbasePath/chat.png';
  static String sendImage = '$iconsbasePath/send.png';

  /// DRAWER
  static String notificationImage = '$iconsbasePath/notification.png';
  static String resultImage = '$iconsbasePath/result.png';
  static String noteImage = '$iconsbasePath/note.png';
  static String walletImage = '$iconsbasePath/wallet.png';
  static String templateImage = '$iconsbasePath/template.png';
  static String referImage = '$iconsbasePath/refer.png';
  static String supportImage = '$iconsbasePath/support.png';
  static String settingImage = '$iconsbasePath/setting.png';

  static Image homeImages = Image.asset(
    '$iconsbasePath/home.png',
    scale: 1.2.w,
  );
  static Image plusCircleImages = Image.asset(
    '$iconsbasePath/plus_circle.png',
    scale: 1.w,
  );
  static Image medalLightImages = Image.asset(
    '$iconsbasePath/medal_light.png',
    scale: 1.w,
  );
  static Image userImages = Image.asset(
    '$iconsbasePath/user.png',
    scale: 1.w,
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
