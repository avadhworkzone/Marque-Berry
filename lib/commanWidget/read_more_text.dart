import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:socialv/utils/color_utils.dart';

class ReadMoreTextWidget extends StatelessWidget {
  const ReadMoreTextWidget({
    Key? key,
    required this.text,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.trimLines,
  }) : super(key: key);
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? trimLines;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: trimLines ?? 2,
      colorClickableText: ColorUtils.blueB9,
      lessStyle: TextStyle(
          color: ColorUtils.blueB9, fontSize: 14, fontWeight: FontWeight.bold),
      trimMode: TrimMode.Line,
      trimCollapsedText: ' Show more',
      trimExpandedText: ' Show less',
      style: TextStyle(color: color, fontSize: fontSize),
      moreStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: ColorUtils.blueB9,
      ),
    );
  }
}
