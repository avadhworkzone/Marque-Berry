// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/assets/images_utils.dart';

class CommonImage extends StatelessWidget {
  String img;
  Color? color;

  CommonImage({
    Key? key,
    required this.img,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(img, color: color);
  }
}

class CommonSvgImage extends StatelessWidget {
  String img;
  Color? color;

  CommonSvgImage({
    Key? key,
    required this.img,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      img,
      color: color,
      height: 28,
      width: 28,
    );
  }
}

class CommonImageScale extends StatelessWidget {
  String img;
  double scale;
  Color? color;

  CommonImageScale({
    Key? key,
    required this.img,
    required this.scale,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      img,
      scale: scale,
      color: color,
    );
  }
}

class CommonImageHeight extends StatelessWidget {
  String img;
  double height;
  Color? color;

  CommonImageHeight({
    Key? key,
    required this.img,
    required this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(img, height: height, color: color);
  }
}

class CommonImageWidth extends StatelessWidget {
  String img;
  double width;
  Color? color;

  CommonImageWidth({
    Key? key,
    this.color,
    required this.img,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      img,
      width: width,
      color: color,
    );
  }
}

class CommonImageHeightWidth extends StatelessWidget {
  String img;
  double width;
  double height;
  Color? color;

  CommonImageHeightWidth({
    Key? key,
    required this.img,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w),
      child: Image.asset(img, width: width, height: height, color: color),
    );
  }
}
