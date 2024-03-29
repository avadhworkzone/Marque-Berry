// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/typedef_utils.dart';

class CommonAppBar extends StatelessWidget {
  var title;

  Color? color;

  OnTab onTap;

  CommonAppBar({
    Key? key,
    this.title,
    this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? whiteBlack = Theme.of(context).scaffoldBackgroundColor;

    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: color ?? Theme.of(context).cardColor,
      leading: IconButton(
        splashRadius: 7.w,
        onPressed: () => onTap(),
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

PreferredSizeWidget customAppbar(
    {required String title,
    required BuildContext context,
    Color? color,
    Widget? icon,
    VoidCallback? leadingOnTap}) {
  Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
  Color? whiteBlack = Theme.of(context).scaffoldBackgroundColor;

  return PreferredSize(
    preferredSize: Size(100.w, 60),
    child: AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: color ?? Theme.of(context).cardColor,
      title: AdoroText(
        title,
        fontSize: 15.sp,
        color: blackWhite,
        fontWeight: FontWeightClass.fontWeightBold,
      ),
      leading: IconButton(
        onPressed: leadingOnTap ?? () => Get.back(),
        splashRadius: 6.w,
        icon: Icon(Icons.arrow_back, color: blackWhite),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
      ],
    ),
  );
}
