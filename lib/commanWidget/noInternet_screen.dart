// ignore_for_file: file_names
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';

class NoInterNetConnected extends StatelessWidget {
  const NoInterNetConnected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'No internet connection',
                fontSize: 20.sp,
                color: Theme.of(context).buttonColor,
              ),
              SizeConfig.sH3,
              AdoroText(
                VariableUtils.noInternetText,
                fontSize: 15.sp,
                color: Theme.of(context).buttonColor,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
