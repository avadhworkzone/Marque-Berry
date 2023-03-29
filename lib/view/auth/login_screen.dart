import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../../commanWidget/custom_btn.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SizeConfig.sH10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImagesWidgets.adoroImage,
              // 8.width,
            ],
          ),
          SizeConfig.sH7,
          Stack(
            children: [
              Container(
                width: Get.width,
                height: 45.h,
                decoration: DecorationUtils.loginDecoration(context),
                child: Column(
                  children: [
                    SizeConfig.sH2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            selectedIndex = 0;
                            setState(() {});
                          },
                          child: AdoroText(
                            "LOGIN",
                            color: selectedIndex == 0
                                ? Colors.white
                                : ColorUtils.blueE7,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            selectedIndex = 1;
                            setState(() {});
                          },
                          child: AdoroText(
                            "SIGN UP",
                            color: selectedIndex == 1
                                ? Colors.white
                                : ColorUtils.blueE7,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizeConfig.sH7,
              selectedIndex == 0
                  ? Positioned(
                      top: 15.w,
                      bottom: 0.h,
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ColorUtils.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.w),
                              topRight: Radius.circular(5.w)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AdoroText(
                                VariableUtils.welcomeBack,
                                fontSize: 15.sp,
                                color: ColorUtils.black,
                                fontWeight: FontWeight.bold,
                              ),
                              AdoroText(
                                VariableUtils.youHaveBeenMissed,
                                color: ColorUtils.black92,
                              ),
                              SizeConfig.sH5,
                              AdoroText(
                                VariableUtils.mobileNumber,
                                color: ColorUtils.black92,
                              ),
                              CommonTextFieldContainer(
                                keyboardType: TextInputType.number,
                              ),
                              SizeConfig.sH5,
                              CustomBtn(
                                onTap: () {},
                                text: 'GET OTP',
                              ),

                              // VariableUtils.welcomeBack,
                            ],
                          ),
                        ),
                      ),
                    )
                  : Positioned(
                      top: 15.w,
                      bottom: 0.h,
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ColorUtils.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.w),
                              topRight: Radius.circular(5.w)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AdoroText(
                                VariableUtils.welcomeBack,
                                fontSize: 15.sp,
                                color: ColorUtils.black,
                                fontWeight: FontWeight.bold,
                              ),
                              AdoroText(
                                VariableUtils.youHaveBeenMissed,
                                color: ColorUtils.black92,
                              ),
                              SizeConfig.sH5,
                              AdoroText(
                                VariableUtils.mobileNumber,
                                color: ColorUtils.black92,
                              ),
                              CommonTextFieldContainer(
                                keyboardType: TextInputType.number,
                              ),
                              SizeConfig.sH5,
                              CustomBtn(
                                onTap: () {},
                                text: 'GET OTP',
                              ),

                              // VariableUtils.welcomeBack,
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          // getFragment().expand(),
        ],
      ),
    );
  }
}
