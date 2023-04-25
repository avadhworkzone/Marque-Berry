import 'package:socialv/utils/decoration_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/typedef_utils.dart' as tpdf;

class CustomBtn extends StatelessWidget {
  final tpdf.OnTab? onTap;
  final String text;
  final double? radius;
  final double? height;
  final double? width;
  final double? fontSize;
  final BoxDecoration? decoration;
  final Color? bgColor;
  final Color? textColor;

  const CustomBtn({
    super.key,
    required this.onTap,
    required this.text,
    this.radius,
    this.height,
    this.width,
    this.fontSize,
    this.bgColor,
    this.textColor,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 6.2.h,
        width: width ?? 80.w,
        decoration: decoration ?? DecorationUtils.buttonDecoration(context),
        child: Center(
          child: AdoroText(
            text,
            fontSize: fontSize,
            color: textColor ?? ColorUtils.white,
            fontWeight: FontWeightClass.fontWeightBold,
          ),
        ),
      ),
    );
  }
}

class UploadBtn extends StatelessWidget {
  final tpdf.OnTab? onTap;
  final String text;
  final double? radius;
  final double? height;
  final double? width;
  final double? fontSize;
  final BoxDecoration? decoration;
  final Color? bgColor;
  final Color? textColor;

  const UploadBtn({
    super.key,
    required this.onTap,
    required this.text,
    this.radius,
    this.height,
    this.width,
    this.fontSize,
    this.bgColor,
    this.textColor,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: decoration ?? DecorationUtils.buttonDecoration(context),
        child: Center(
          child: AdoroText(
            text,
            fontSize: fontSize,
            color: textColor ?? ColorUtils.white,
            fontWeight: FontWeightClass.fontWeightBold,
          ),
        ),
      ),
    );
  }
}

class BorderBtn extends StatelessWidget {
  final tpdf.OnTab? onTap;
  final String text;
  final double? radius;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? bWidth;
  final Color? textColor;
  final bool? hasShadow;

  const BorderBtn({
    super.key,
    required this.onTap,
    required this.text,
    this.radius,
    this.height,
    this.width,
    this.fontSize,
    this.textColor,
    this.bWidth,
    this.hasShadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 6.2.h,
        width: width ?? 60.w,
        decoration: BoxDecoration(
          color: ColorUtils.transparent,
          borderRadius: BorderRadius.circular(radius ?? 4.w),
          boxShadow: hasShadow == false
              ? []
              : [
                  BoxShadow(color: Colors.black12.withOpacity(0.1)),
                  const BoxShadow(
                    color: ColorUtils.white,
                    blurRadius: 10.0,
                    spreadRadius: 0,
                  ),
                ],
        ),
        child: Center(
          child: AdoroText(
            text,
            color: textColor ??
                Theme.of(context).primaryTextTheme.labelMedium?.color ??
                ColorUtils.black,
            fontWeight: FontWeightClass.fontWeight500,
          ),
        ),
      ),
    );
  }
}
