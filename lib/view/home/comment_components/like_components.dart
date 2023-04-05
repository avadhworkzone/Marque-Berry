import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class LikeButton extends StatelessWidget {
  String likecounter;

  LikeButton({Key? key, required this.likecounter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.5.w,
          vertical: 2.7.w,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonImageScale(
              img: IconsWidgets.heartImage,
              scale: 1.3.w,
              color: ColorUtils.black92,
            ),
            SizeConfig.sW2,
            AdoroText('$likecounter', color: ColorUtils.black92),
          ],
        ),
      ),
    );
  }
}
