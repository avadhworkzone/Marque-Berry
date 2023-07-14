import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/auth/interest.dart';

class SuccessLogin extends StatefulWidget {
  final bool isBackRoute;

  const SuccessLogin({
    Key? key,
    this.isBackRoute = false,
  }) : super(key: key);

  @override
  State<SuccessLogin> createState() => _SuccessLoginState();
}

class _SuccessLoginState extends State<SuccessLogin> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    Future.delayed(
      Duration(seconds: 3),
      () =>
          widget.isBackRoute ? Get.back() : Get.offAll(() => InterestScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    String themeType = PreferenceUtils.getString(key: PreferenceUtils.mode);
    print('themeType:=>$themeType');
    if (themeType.isEmpty) {
      themeType = 'light';
    }
    return Material(
      color: Theme.of(context).cardColor,
      child: Image.asset(themeType == "light"
          ? ImagesWidgets.doneGifImage
          : ImagesWidgets.darkDoneGif),
    );
  }
}
