import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class CommonAppBar extends StatelessWidget {
  var title;
  CommonAppBar({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? whiteBlack = Theme.of(context).scaffoldBackgroundColor;

    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: whiteBlack,
      leading: IconButton(
        splashRadius: 7.w,
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back, color: blackWhite),
      ),
      title: AdoroText(
        title,
        fontSize: 15.sp,
        color: blackWhite,
        fontWeight: FontWeightClass.fontWeightBold,
      ),
    );
  }
}

AppBar customAppbar(final String title) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: ColorUtils.greyFA,
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.arrow_back, color: ColorUtils.black2E),
    ),
    title: AdoroText(title, fontSize: 13.sp, color: ColorUtils.black2E),
  );
}
