import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/view/drawer/view_result.dart';

import '../../commanWidget/common_appbar.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/adoro_text.dart';
import '../../utils/variable_utils.dart';

class Result extends StatelessWidget {
  Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(16.w),
          child: CommonAppBar(
            color: ColorUtils.transparent,
            title: VariableUtils.resultText,
            onTap: () => Get.back(),
          ),
        ),
        body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  SizeConfig.sH1,
                  Container(
                    height: 8.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: whiteBlack2E,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3, color: ColorUtils.grey.shade200),
                      ],
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    child: Row(
                      children: [
                        SizeConfig.sW2,
                        CircleAvatar(
                          child: ImagesWidgets.userImage,
                        ),
                        SizeConfig.sW2,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizeConfig.sH1,
                            AdoroText(
                              VariableUtils.brandName,
                              fontSize: 11.sp,
                              fontWeight: FontWeightClass.fontWeightBold,
                              color: blackWhite,
                            ),
                            AdoroText(
                              VariableUtils.campaignName,
                              fontSize: 11.sp,
                              fontWeight: FontWeightClass.fontWeightBold,
                              color: ColorUtils.black92,
                            ),
                          ],
                        ),
                        SizeConfig.sW13,
                        InkWell(
                          onTap: () => Get.to(ViewResult()),
                          child: Container(
                            height: 4.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorUtils.linearGradient7,
                                  ColorUtils.linearGradient4,
                                  ColorUtils.linearGradient5,
                                  ColorUtils.linearGradient8,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.w),
                              ),
                            ),
                            child: Center(
                              child: AdoroText(
                                VariableUtils.viewResult,
                                color: ColorUtils.white,
                                fontWeight: FontWeightClass.fontWeight600,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
