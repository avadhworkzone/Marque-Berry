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
  static String circleImage = '$imagesbasePath/circle.png';
  static String profile2Image = '$imagesbasePath/profile2.png';
  static String rectangleImage = '$imagesbasePath/Rectangle.png';
  static String ellipseImage = '$imagesbasePath/Ellipse.png';
  static String bgProfileImage = '$imagesbasePath/bgProfile.png';
  static String profileImagesImage = '$imagesbasePath/profileimages.png';
  static String submitButtonImage = '$imagesbasePath/submitButton.png';

  static Image logoISImage = Image.asset(logoImage, scale: 3.6.w);
  static Image adoroImage = Image.asset(
    '$imagesbasePath/adoro.png',
    scale: 1.5.w,
  );
  static Image verifiedImage = Image.asset(
    '$imagesbasePath/verifieduser.png',
    scale: 1.5.w,
  );
  static Image userImage = Image.asset(
    '$imagesbasePath/profile3.png',
  );
  static Image profileImage = Image.asset(
    '$imagesbasePath/profile1.png',
  );
  static Image vectorImage = Image.asset(
    '$imagesbasePath/Vector.png',
    scale: 1.1.w,
  );
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

  static String imageNotFoundImages = '$iconsbasePath/image_not_found.png';
  static String adoroTextImages = '$iconsbasePath/adoro_text.png';
  // static String userImages = '$iconsbasePath/user.png';

  ///APPBAR HOME
  static String drawerImage = '$iconsbasePath/drawer.png';
  static String menuImage = '$iconsbasePath/menu.png';
  // static String messageImage = '$iconsbasePath/message.png';
  static String searchImage = '$iconsbasePath/search.png';

  static String heartImage = '$iconsbasePath/heart.png';
  static String heartFilledImage = '$iconsbasePath/heart_filled.png';
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
  static String homeImages = '$iconsbasePath/home.png';
  static String messageImage = '$iconsbasePath/message.png';
  static String selectHomeImage = '$iconsbasePath/selectHome.png';
  static String selectMedalLightImage = '$iconsbasePath/selectMedalLight.png';
  static String selectPlusCircleImage = '$iconsbasePath/selectplusCircle.png';
  static String selectUserImage = '$iconsbasePath/selectUser.png';
  static String dropdownButtonImage = '$iconsbasePath/dropdownButton.png';

  static String plusCircleImages = '$iconsbasePath/plus_circle.png';
  static String medalLightImages = '$iconsbasePath/medal_light.png';
  static String userImages = '$iconsbasePath/user.png';

  static String submitBtnImages = '$iconsbasePath/submit_btn.png';
  static String clipboardImages = '$iconsbasePath/clipboard.png';
  static String shareBtnImages = '$iconsbasePath/share_btn.png';
  static String linkImages = '$iconsbasePath/link.png';

  // static Image plusCircleImages = Image.asset(
  //   '$iconsbasePath/plus_circle.png',
  //   scale: 1.w,
  // );
  // static Image medalLightImages = Image.asset(
  //   '$iconsbasePath/medal_light.png',
  //   scale: 1.w,
  // );
  // static Image userImages = Image.asset(
  //   '$iconsbasePath/user.png',
  //   scale: 1.w,
  // );
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
