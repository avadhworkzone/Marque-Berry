// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';

class CommonProfileImage extends StatelessWidget {
  double heightWidth;

  Color? bgColor;

  CommonProfileImage({
    Key? key,
    required this.heightWidth,
    this.bgColor = ColorUtils.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightWidth,
      width: heightWidth,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: PreferenceUtils.getString(key: 'profile') != ""
              ? NetworkImage(
                  PreferenceUtils.getString(key: 'profile'),
                ) as ImageProvider
              : AssetImage(
                  IconsWidgets.userImages,
                ),
          // scale: 0.28.w,
          fit: BoxFit.contain,
        ),
      ),
      // color: ColorUtils.black,
    );
  }
}

class CommonCoverImage extends StatelessWidget {
  const CommonCoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      image: NetworkImage(
        PreferenceUtils.getString(
          key: PreferenceUtils.coverImage,
        ),
      ),
      placeholderBuilder: OctoPlaceholder.blurHash(
        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
      ),
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          ImagesWidgets.bgProfileImage,
          fit: BoxFit.fill,
        );
      },
    );
  }
}
