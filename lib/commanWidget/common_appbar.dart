import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class CommonAppBar extends StatelessWidget {
  var title;

  Color? color;
  CommonAppBar({Key? key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? whiteBlack = Theme.of(context).scaffoldBackgroundColor;

    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: color ?? whiteBlack,
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

AppBar customAppbar({required String title, Icon? icon}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: ColorUtils.greyFA,
    title: AdoroText(
      title,
      fontSize: 18,
      color: ColorUtils.black2E,
    ),
    leading: const Icon(
      Icons.arrow_back,
      color: ColorUtils.black2E,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: icon,
      ),
    ],
  );
}
