import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import '../../commanWidget/custom_btn.dart';
import '../../utils/color_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';
import 'done_screen.dart';

class OtpScreen extends StatelessWidget {
  TextEditingController otp = TextEditingController(text: "");

  StreamController<ErrorAnimationType>? errorController;

  final otpFormKey = GlobalKey<FormState>();

  OtpTimerButtonController controller = OtpTimerButtonController();

  // _requestOtp() {
  //   controller.loading();
  //   Future.delayed(Duration(seconds: 60), () {
  //     controller.startTimer();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GetBuilder<OtpController>(builder: (otpController) {
        return Form(
          key: otpFormKey,
          child: Column(
            children: [
              SizeConfig.sH25,
              AdoroText(
                VariableUtils.otpVerification,
                fontSize: 15.sp,
                color: Theme.of(context).textTheme.titleSmall?.color,
                fontWeight: FontWeight.bold,
              ),
              SizeConfig.sH2,
              AdoroText(
                VariableUtils.weHaveSentDigitCode,
                fontSize: 11.sp,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
              SizeConfig.sH2,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Theme(
                      data: ThemeData(
                        accentColor: Colors.red,
                        primaryColor: Colors.orange,
                      ),
                      child: PinCodeTextField(
                        length: 4,
                        controller: otp,
                        appContext: context,
                        textStyle: TextStyle(color: ColorUtils.black92),
                        onChanged: (value) => otpController.changeotp(value),
                        enableActiveFill: true,
                        blinkWhenObscuring: true,
                        cursorColor: ColorUtils.black,
                        animationType: AnimationType.fade,
                        keyboardType: TextInputType.number,
                        errorAnimationController: errorController,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 15.w,
                          fieldWidth: 12.w,
                          activeColor: ColorUtils.grey[300],
                          activeFillColor: ColorUtils.grey[300],
                          selectedFillColor: ColorUtils.grey[300],
                          inactiveColor: ColorUtils.grey[300],
                          inactiveFillColor: ColorUtils.grey[300],
                          selectedColor: Colors.black,
                        ),
                        pastedTextStyle: TextStyle(
                            fontWeight: FontWeightClass.fontWeightBold),
                        animationDuration: const Duration(milliseconds: 300),
                      ),
                    ),
                  ],
                ),
              ),

              AdoroText("00 : 19", color: ColorUtils.green4E),
              otpController.hasError == true
                  ? Center(
                      child: AdoroText(
                        otp.text.isEmpty
                            ? "Please fill all the cell"
                            : 'Wrong OTP',
                        fontSize: 12,
                        color: ColorUtils.red29,
                        fontWeight: FontWeightClass.fontWeight400,
                      ),
                    )
                  : const SizedBox(),
              // SizeConfig.sH5,
              // OtpTimerButton(
              //   duration: 60,
              //   controller: controller,
              //   onPressed: () => _requestOtp(),
              //   text: Text('Resend OTP'),
              //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              // ),
              SizeConfig.sH3,
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleMedium?.color,
                  ),
                  children: [
                    TextSpan(
                      text: VariableUtils.dontReceiveTheOTP,
                    ),
                    TextSpan(
                      // recognizer: TapGestureRecognizer()
                      //   ..onTap = () => Get.to(() => DoneScreen()),
                      text: ' ${VariableUtils.resendOTP}',
                      style: TextStyle(color: ColorUtils.blueB9),
                    ),
                  ],
                ),
              ),
              SizeConfig.sH7,
              CustomBtn(
                onTap: () {
                  if (otpFormKey.currentState!.validate()) {
                    if (otpController.currentText != "0000") {
                      showSnackBar(message: "Wrong otp");
                      // errorController!.add(ErrorAnimationType.shake);
                      otpController.changeerror(true);
                      // setState(() {});
                    } else {
                      PreferenceUtils.setInt(
                        key: PreferenceUtils.login,
                        value: 1,
                      );
                      Get.to(() => DoneScreen());
                      otpController.changeerror(false);
                    }
                  }
                },
                text: 'VERIFY NOW',
              ),
            ],
          ),
        );
      }),
    );
  }
}

class OtpController extends GetxController {
  bool hasError = false;

  changeerror(val) {
    hasError = val;
    logs("HAS ERROR:=====> $hasError");
    update();
  }

  String currentText = "";
  changeotp(val) {
    currentText = val;
  }
}
