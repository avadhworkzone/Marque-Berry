import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import '../../commanWidget/custom_btn.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/validation_utils.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedIndex = 0;

  final signinKey = GlobalKey<FormState>();
  final signupKey = GlobalKey<FormState>();

  var mobile = TextEditingController();
  var fullname = TextEditingController();
  var username = TextEditingController();
  var signUpNumber = TextEditingController();

  TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizeConfig.sH10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImagesWidgets.adoroImage,
              ],
            ),
            SizeConfig.sH7,
            Container(
              height: Get.height - 25.h,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 0.5.w),
                    width: Get.width,
                    height: 10.h,
                    decoration: DecorationUtils.loginDecoration(context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            fontWeight: FontWeightClass.fontWeight600,
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
                            fontWeight: FontWeightClass.fontWeight600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: Get.width,
                      height: Get.height - 31.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(7.w),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 6.w),
                        child: Column(
                          children: [
                            selectedIndex == 0
                                ? Form(
                                    key: signinKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AdoroText(
                                          VariableUtils.welcomeBack,
                                          fontSize: 15.sp,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.color,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        AdoroText(
                                          VariableUtils.youHaveBeenMissed,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color,
                                        ),
                                        SizeConfig.sH5,
                                        AdoroText(
                                          VariableUtils.mobileNumber,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color,
                                        ),
                                        CommonTextFormField(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.color,
                                          validator: (v) => mobileValidation(v),
                                          controller: mobile,
                                          mobilelength: 10,
                                          keyboardType: TextInputType.number,
                                          denyInputFormatters: RegularExpression
                                              .noSpaceAllowPattern,
                                          allowInputFormatters:
                                              RegularExpression
                                                  .contactKeyboardPattern,
                                        ),
                                        SizeConfig.sH5,
                                        Center(
                                          child: CustomBtn(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              if (signinKey.currentState!
                                                  .validate()) {
                                                Get.to(() => OtpScreen());
                                              }
                                            },
                                            text: 'GET OTP',
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Form(
                                    key: signupKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AdoroText(
                                          VariableUtils.welcomeCreator,
                                          fontSize: 15.sp,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.color,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        AdoroText(
                                          VariableUtils.joinTheWorld,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color,
                                        ),
                                        SizeConfig.sH5,
                                        AdoroText(
                                          VariableUtils.fullName,
                                          fontFamily: RegularExpression
                                              .fullNameKeyboardPattern,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color,
                                        ),
                                        CommonTextFormField(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.color,
                                          keyboardType: TextInputType.name,
                                          validator: (v) => userValidation(v),
                                          controller: fullname,
                                          denyInputFormatters: RegularExpression
                                              .onlyFirstSpaceNoAllowPattern,
                                          allowInputFormatters:
                                              RegularExpression
                                                  .alphabetSpacePattern,
                                        ),
                                        SizeConfig.sH2,
                                        AdoroText(
                                          VariableUtils.userName,
                                          fontFamily: RegularExpression
                                              .nameKeyboardPattern,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color,
                                        ),
                                        CommonTextFormField(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.color,
                                          keyboardType: TextInputType.name,
                                          validator: (v) => userValidation(v),
                                          controller: username,
                                          denyInputFormatters: RegularExpression
                                              .noSpaceAllowPattern,
                                          allowInputFormatters:
                                              RegularExpression
                                                  .nameKeyboardPattern,
                                        ),
                                        SizeConfig.sH2,
                                        AdoroText(
                                          VariableUtils.mobileNumber,
                                          fontFamily: RegularExpression
                                              .contactKeyboardPattern,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color,
                                        ),
                                        CommonTextFormField(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.color,
                                          keyboardType: TextInputType.number,
                                          mobilelength: 10,
                                          validator: (v) => mobileValidation(v),
                                          controller: signUpNumber,
                                          denyInputFormatters: RegularExpression
                                              .noSpaceAllowPattern,
                                          allowInputFormatters:
                                              RegularExpression
                                                  .contactKeyboardPattern,
                                        ),
                                        SizeConfig.sH5,
                                        Center(
                                          child: CustomBtn(
                                            onTap: () {
                                              if (signupKey.currentState!
                                                  .validate()) {
                                                Get.to(() => OtpScreen());
                                              }
                                              // FocusScope.of(context).unfocus();
                                              // if (otp.text.length != 6 &&
                                              //     otp.text != "1234") {
                                              // } else {}
                                            },
                                            text: 'GET OTP',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginController extends GetxController {
  int selectedIndex = 0;

  changeindex(index) {
    selectedIndex = index;
    update();
  }
}
