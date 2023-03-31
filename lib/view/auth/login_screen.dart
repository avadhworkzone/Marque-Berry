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
import '../../utils/validation_utils.dart';
import '../../utils/variable_utils.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedIndex = 0;
  TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
            Container(
              width: Get.width,
              height: 10.h,
              decoration: DecorationUtils.loginDecoration(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                          fontSize: 13.sp,
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
                          fontSize: 13.sp,
                          color: selectedIndex == 1
                              ? Colors.white
                              : ColorUtils.blueE7,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 4.w,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodyText2?.color,
                      // color: ColorUtils.red29,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.w),
                          topRight: Radius.circular(8.w)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              child: Column(
                children: [
                  selectedIndex == 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AdoroText(
                              VariableUtils.welcomeBack,
                              fontSize: 15.sp,
                              color:
                                  Theme.of(context).textTheme.subtitle1?.color,
                              fontWeight: FontWeight.bold,
                            ),
                            AdoroText(VariableUtils.youHaveBeenMissed,
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.color),
                            SizeConfig.sH5,
                            AdoroText(VariableUtils.mobileNumber,
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.color),
                            CommonTextFieldContainer(
                              keyboardType: TextInputType.number,
                            ),

                            // VariableUtils.welcomeBack,
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AdoroText(
                              VariableUtils.welcomeCreator,
                              fontSize: 15.sp,
                              color:
                                  Theme.of(context).textTheme.subtitle1?.color,
                              fontWeight: FontWeight.bold,
                            ),
                            AdoroText(VariableUtils.joinTheWorld,
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.color),
                            SizeConfig.sH5,
                            AdoroText(VariableUtils.fullName,
                                fontFamily:
                                    RegularExpression.fullNameKeyboardPattern,
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.color),
                            CommonTextFieldContainer(
                              keyboardType: TextInputType.name,
                            ),
                            SizeConfig.sH2,
                            AdoroText(VariableUtils.userName,
                                fontFamily:
                                    RegularExpression.nameKeyboardPattern,
                                color:
                                    Theme.of(context).textTheme.subtitle2?.color
                                // color: ColorUtils.black92,
                                ),
                            CommonTextFieldContainer(
                              keyboardType: TextInputType.name,
                            ),
                            SizeConfig.sH2,
                            AdoroText(VariableUtils.mobileNumber,
                                fontFamily:
                                    RegularExpression.contactKeyboardPattern,
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.color),
                            CommonTextFieldContainer(
                              keyboardType: TextInputType.number,
                            ),

                            // VariableUtils.welcomeBack,
                          ],
                        ),
                ],
              ),
            ),
            SizeConfig.sH10,
            CustomBtn(
              onTap: () {
                FocusScope.of(context).unfocus();
                {
                  if (otp.text.length != 6 && otp.text != "1234") {
                  } else {}
                }
                Get.to(OtpScreen());
              },
              text: 'GET OTP',
            ),
          ],
        ),
      ),
    );
  }
}
