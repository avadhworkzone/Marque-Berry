// ignore_for_file: file_names
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/color_utils.dart';

class NoInterNetConnected extends StatelessWidget {
  const NoInterNetConnected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorUtils.white,
      child: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.w,
                child: OverflowBox(
                  maxHeight: 60.w,
                  minHeight: 60.w,
                  child: Center(child: LottieWidgts.nointernet),
                ),
              ),
              SizeConfig.sH3,
              AdoroText(
                VariableUtils.noInternetText,
                fontSize: 12.sp,
                textAlign: TextAlign.center,
                fontWeight: FontWeightClass.fontWeightBold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
