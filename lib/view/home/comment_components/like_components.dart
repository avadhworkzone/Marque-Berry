// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';

class LikeButton extends StatelessWidget {
  String likecounter;
  bool isLiked;

  LikeButton({Key? key, required this.likecounter, this.isLiked = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 2.1.w,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isLiked
                ? Image.asset(
                    IconsWidgets.heartFilledImage,
                    scale: 1.w,
                    color: Colors.red,
                  )
                : CommonImageScale(
                    img: IconsWidgets.unLikeComment,
                    // img: IconsWidgets.heartImage,
                    scale: 2.5,
                    color: ColorUtils.black92,
                  ),
            SizeConfig.sW2,
            AdoroText(
              '$likecounter',
              color: ColorUtils.black92,
              fontWeight: FontWeightClass.fontWeight600,
            ),
          ],
        ),
      ),
    );
  }
}
