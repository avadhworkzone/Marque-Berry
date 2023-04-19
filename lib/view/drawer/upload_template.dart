import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../commanWidget/common_appbar.dart';
import '../../commanWidget/custom_btn.dart';

import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/variable_utils.dart';

class UploadTemplate extends StatefulWidget {
  UploadTemplate({Key? key}) : super(key: key);

  @override
  State<UploadTemplate> createState() => _UploadTemplateState();
}

class _UploadTemplateState extends State<UploadTemplate> {
  // int selectedIndex = 0;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   selectedIndex = 0;
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(16.w),
        child: CommonAppBar(
          title: VariableUtils.uploadTemplate,
          ontap: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          SizeConfig.sH3,
          BtnUpload(),
          SizeConfig.sH6,
          ImagesWidgets.vectorImage,
          SizeConfig.sH10,
          CustomBtn(
            height: 5.h,
            onTap: () {},
            text: 'UPLOAD MEME TEMPLATE',
          ),
        ],
      ),
    ));
  }
}

class BtnUpload extends StatefulWidget {
  const BtnUpload({Key? key}) : super(key: key);

  @override
  State<BtnUpload> createState() => _BtnUploadState();
}

class _BtnUploadState extends State<BtnUpload> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UploadBtn(
          height: 5.h,
          width: 30.w,
          onTap: () {
            setState(() {
              selectedIndex = 0;
            });
          },
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorUtils.linearGradient1,
                  ColorUtils.linearGradient2,
                  ColorUtils.linearGradient3,
                  ColorUtils.linearGradient4,
                  ColorUtils.linearGradient5,
                  ColorUtils.linearGradient6,
                  ColorUtils.linearGradient7,
                ],
                stops: [0.0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8],
              ),
              // color: selectedIndex == 0
              //     ? ColorUtils.red29
              //     : ColorUtils.white,
              borderRadius: BorderRadius.circular(2.w)),
          text: 'Standard',
          textColor: selectedIndex == 0 ? ColorUtils.white : ColorUtils.black92,
        ),
        SizeConfig.sW5,
        UploadBtn(
          height: 5.h,
          width: 30.w,
          onTap: () {
            setState(() {
              selectedIndex = 1;
            });
          },
          decoration: BoxDecoration(

              // color: selectedIndex == 0
              //     ? ColorUtils.white
              //     : ColorUtils.red29,
              borderRadius: BorderRadius.circular(2.w)),
          text: 'Licensed',
          textColor: selectedIndex == 0 ? ColorUtils.black92 : ColorUtils.white,
        ),
      ],
    );
  }
}
