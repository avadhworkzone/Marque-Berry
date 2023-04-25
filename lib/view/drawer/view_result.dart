import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/size_config_utils.dart';

import '../../commanWidget/common_appbar.dart';
import '../../utils/color_utils.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';

class ViewResult extends StatelessWidget {
  const ViewResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorUtils.greyFA,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(16.w),
              child: CommonAppBar(
                title: VariableUtils.viewResult,
                ontap: () => Get.back(),
              ),
            ),
            body: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    children: [
                      SizeConfig.sH2,
                      Container(
                        height: 6.h,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: ColorUtils.white,
                            borderRadius: BorderRadius.circular(4.w)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(" ${index + 1} ",
                                style: TextStyle(
                                    color: ColorUtils.black92,
                                    fontSize: 15.sp)),
                            Padding(
                              padding: EdgeInsets.only(right: 45.w),
                              child: AdoroText(
                                VariableUtils.userName,
                                fontSize: 13.sp,
                                fontWeight: FontWeightClass.fontWeightBold,
                                color: ColorUtils.black,
                              ),
                            ),
                            AdoroText(
                              VariableUtils.price,
                              fontSize: 13.sp,
                              fontWeight: FontWeightClass.fontWeightBold,
                              color: ColorUtils.green4E,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            )));
  }
}
