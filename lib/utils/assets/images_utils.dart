import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

String imagesbasePath = 'assets/images';
String iconsbasePath = 'assets/icons';
String svgbasePath = 'assets/svg';
String lottiebasePath = 'assets/lotties';

/// Images
class ImagesWidgets {
  /// LOGO & SPLASH
  static String logoImage = '$imagesbasePath/logo.png';
  static String templatePlaceHolder = '$imagesbasePath/templatePlaceHolder.png';
  static String circleImage = '$imagesbasePath/circle.png';
  static String profile2Image = '$imagesbasePath/profile2.png';
  static String rectangleImage = '$imagesbasePath/Rectangle.png';
  static String ellipseImage = '$imagesbasePath/Ellipse.png';
  static String bgProfileImage = '$imagesbasePath/bgProfile.png';
  static String profileImagesImage = '$imagesbasePath/profileimages.png';
  static String submitButtonImage = '$imagesbasePath/submitButton.png';
  static String gradientRectangle = '$imagesbasePath/gradientRectangle.png';

  // static String splashImage = '$imagesbasePath/splash.png';
  static String splashGifImage = '$imagesbasePath/splashGif.gif';
  static String doneGifImage = '$imagesbasePath/doneGif.gif';
  static String darkDoneGif = '$imagesbasePath/darkDoneGif.gif';
  static String tickSquareImage = '$imagesbasePath/TickSquare.png';
  static String closeSquareImage = '$imagesbasePath/CloseSquare.png';
  static String referEarnImage = '$imagesbasePath/referEarn.png';

  static Image logoISImage = Image.asset(logoImage, scale: 3.6.w);
  static Image adoroImage = Image.asset(
    '$imagesbasePath/adoro.png',
    scale: 1.2.w,
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

  /// categories

  static String sadPostImage = '$imagesbasePath/sadpost.png';
  static String savageImage = '$imagesbasePath/savage.png';
  static String relatableImage = '$imagesbasePath/relatable.png';
  static String shitPostImage = '$imagesbasePath/shitpost.png';
  static String dankImage = '$imagesbasePath/dank.png';
  static String wholesomeImage = '$imagesbasePath/wholesome.png';
  static String webSeriesImage = '$imagesbasePath/webseries.png';
  static String techImage = '$imagesbasePath/tech.png';
  static String sportsImage = '$imagesbasePath/sports.png';
  static String movieImage = '$imagesbasePath/movie.png';
  static String nostalgiaImage = '$imagesbasePath/nostalgia.png';
  static String historyImage = '$imagesbasePath/history.png';
  static String gamingImage = '$imagesbasePath/gaming.png';
  static String desiImage = '$imagesbasePath/desi.png';
  static String celebsImage = '$imagesbasePath/celebs.png';
  static String animeImage = '$imagesbasePath/anime.png';
  static String parodyImage = '$imagesbasePath/parody.png';
  static String politicsImage = '$imagesbasePath/politics.png';
}

class SvgWidgets {
  /// ON-BOARDING
  static String chat = '$svgbasePath/chat.svg';
  static String heart = '$svgbasePath/heart.svg';
  static String selectedHeart = '$svgbasePath/selectedHeart.svg';
  static String send = '$svgbasePath/send.svg';
  static String copyLink = '$svgbasePath/copyLink.svg';
  static String reportPost = '$svgbasePath/reportPost.svg';
  static String shareSvg = '$svgbasePath/share.svg';
  static String deleteSvg = '$svgbasePath/delete.svg';
  static String unFollow = '$svgbasePath/unFollow.svg';
  static String videoPlay = '$svgbasePath/videoPlay.svg';
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
  static String unLikeComment = '$iconsbasePath/unLikeComment.png';
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
  static String copyLinkImages = '$iconsbasePath/copylink.png';
  static String tagImages = '$iconsbasePath/tag.png';
  static String imageImages = '$iconsbasePath/image.png';
  static String videoImages = '$iconsbasePath/video.png';
  static String gifImages = '$iconsbasePath/gif.png';
  static String chooseImages = '$iconsbasePath/choose.png';
  static String shareIconBtnImages = '$iconsbasePath/share_icon_btn.png';
  static String submitIconBtnImages = '$iconsbasePath/submit_icon_btn.png';
  static String lightImages = '$iconsbasePath/light.png';
  static String darkImages = '$iconsbasePath/dark.png';
  static String user1Images = '$iconsbasePath/user1.png';
  static String post2Images = '$iconsbasePath/post2.png';
  static String publicGroupImages = '$iconsbasePath/public_group.png';
  static String post3Images = '$iconsbasePath/post3.png';

  ///home
  static String shareImages = '$iconsbasePath/share.png';
  static String unfollowImages = '$iconsbasePath/unfollow.png';
  static String reportImages = '$iconsbasePath/report.png';

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
