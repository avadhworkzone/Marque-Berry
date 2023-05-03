// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/const_utils.dart';

import '../../commanWidget/custom_btn.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/size_config_utils.dart';
import 'interest.dart';

class DoneScreen extends StatelessWidget {
  bool? isCampaign = false;

  DoneScreen({super.key, this.isCampaign = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 25.h,
            width: 50.w,
            decoration: DecorationUtils.doneDecoration(context),

            child: ImagesWidgets.verifiedImage,
          ),
          SizeConfig.sH10,
          CustomBtn(
            onTap: () {
              logs("message   $isCampaign");
              if (isCampaign == false) {
                Get.to(() => InterestScreen());
              } else {
                Get.back();
              }
            },
            text: 'DONE',
          ),
        ],
      ),
    );
  }
}
