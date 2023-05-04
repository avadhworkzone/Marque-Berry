import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AdoroText extends StatelessWidget {
  final String title;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final TextAlign? textAlign;
  final double? height;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  final double? letterSpacing;

  const AdoroText(
    this.title, {
    Key? key,
    this.color,
    this.fontWeight,
    this.fontFamily,
    this.fontSize,
    this.textAlign,
    this.height,
    this.fontStyle,
    this.maxLines,
    this.overflow,
    this.decoration = TextDecoration.none,
    this.letterSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        overflow: overflow,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        decoration: decoration,
        fontSize: fontSize ?? 14,
        letterSpacing: letterSpacing,
        color: color ?? Theme.of(context).textTheme.titleSmall?.color,
      ),
    );
  }
}
