// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/variable_utils.dart';

class NoInterNetConnected extends StatelessWidget {
  const NoInterNetConnected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AdoroText(
                VariableUtils.noInternetText,
                fontSize: 20.sp,
                color: blackWhite,
              ),
              SizeConfig.sH3,
              AdoroText(
                VariableUtils.noInternetDescText,
                fontSize: 15.sp,
                color: blackWhite,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
