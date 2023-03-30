import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../commanWidget/custom_btn.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/size_config_utils.dart';
import 'interest.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
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
              Get.to(InterestScreen());
            },
            text: 'DONE',
          ),
        ],
      ),
    );
  }
}
