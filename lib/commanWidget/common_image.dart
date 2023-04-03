// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class CommonImage extends StatelessWidget {
  String img;
  Color? color;

  CommonImage({Key? key, required this.img, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(img, color: color);
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
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(img, scale: scale, color: color);
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
    required this.img,
    required this.width,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(img, width: width, color: color);
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
    return Image.asset(img, width: width, height: height, color: color);
  }
}
