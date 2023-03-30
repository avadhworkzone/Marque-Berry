import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/font_style_utils.dart';
import '../../commanWidget/custom_btn.dart';
import '../../utils/color_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';
import 'done_screen.dart';

class OtpScreen extends StatelessWidget {
  TextEditingController otp = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  OtpTimerButtonController controller = OtpTimerButtonController();
  _requestOtp() {
    controller.loading();
    Future.delayed(Duration(seconds: 60), () {
      controller.startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SizeConfig.sH25,
          AdoroText(
            VariableUtils.otpVerification,
            fontSize: 15.sp,
            color: Theme.of(context).textTheme.subtitle1?.color,
            fontWeight: FontWeight.bold,
          ),
          SizeConfig.sH2,
          AdoroText(
            VariableUtils.weHaveSentDigitCode,
            fontSize: 11.sp,
            color: Theme.of(context).textTheme.subtitle2?.color,
          ),
          SizeConfig.sH2,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                PinCodeTextField(
                  length: 4,
                  controller: otp,
                  appContext: context,
                  onChanged: (value) {},
                  enableActiveFill: true,
                  blinkWhenObscuring: true,
                  cursorColor: ColorUtils.black,
                  // animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  errorAnimationController: errorController,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 15.w,
                    fieldWidth: 12.w,
                    activeFillColor: ColorUtils.greyFA,
                    // activeColor: ColorUtils.transparent,
                    selectedFillColor: ColorUtils.greyFA,
                    inactiveColor: ColorUtils.greyFA,
                    inactiveFillColor: ColorUtils.greyFA,
                    // selectedColor: Colors.black,
                  ),
                  pastedTextStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeightClass.fontWeightBold),
                  animationDuration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
          SizeConfig.sH5,

          // OtpTimerButton(
          //   controller: controller,
          //   onPressed: () => _requestOtp(),
          //   text: Text('Resend OTP'),
          //   duration: 60,
          // ),
          SizeConfig.sH5,
          RichText(
            text: TextSpan(
              style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle2?.color),
              children: [
                TextSpan(
                  text: VariableUtils.dontReceiveTheOTP,
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.to(() => DoneScreen()),
                  text: ' ${VariableUtils.resendOTP}',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1?.color),
                ),
              ],
            ),
          ),
          SizeConfig.sH10,
          CustomBtn(
            onTap: () {
              Get.to(DoneScreen());
            },
            text: 'VERIFY NOW',
          ),
        ],
      ),
    );
  }
}
