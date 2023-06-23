// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';

class CommonProfileImage extends StatelessWidget {
  double heightWidth;
  Color? bgColor;
  String? image;

  CommonProfileImage(
      {Key? key,
      required this.heightWidth,
      this.bgColor = ColorUtils.white,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightWidth,
      width: heightWidth,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: image != "" && image != null
              ? NetworkImage(image!) as ImageProvider
              : AssetImage(IconsWidgets.userImages),
          fit: BoxFit.contain,
        ),
      ),

      // color: ColorUtils.black,
    );
  }
}

class CommonCoverImage extends StatelessWidget {
  const CommonCoverImage({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      image: NetworkImage(
        image,
      ),
      placeholderBuilder: OctoPlaceholder.blurHash(
        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
      ),
      // fit: BoxFit.fill,
      fit: BoxFit.fitWidth,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          ImagesWidgets.bgProfileImage,
          fit: BoxFit.fill,
        );
      },
    );
  }
}
