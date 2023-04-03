import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/controllers/validate_otp_controller.dart';
import 'package:socialv/model/apiModel/requestModel/login_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/otp_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/register_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/otp_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/register_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/routes/route_helper.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import '../../commanWidget/custom_btn.dart';
import '../../model/apiModel/responseModel/login_res_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';
import 'done_screen.dart';

class ValidateOtpScreen extends StatefulWidget {
  @override
  State<ValidateOtpScreen> createState() => _ValidateOtpScreenState();
}

class _ValidateOtpScreenState extends State<ValidateOtpScreen> {
  TextEditingController otp = TextEditingController(text: "");

  StreamController<ErrorAnimationType>? errorController;

  final otpFormKey = GlobalKey<FormState>();

  LoginReqModel loginReqModel = LoginReqModel();

  RegisterReqModel registerReqModel = RegisterReqModel();

  AuthViewModel authViewModel = Get.find<AuthViewModel>();

  OtpController otpController = Get.find<OtpController>();

  ValidateOTPReqModel validateOTPReqModel = ValidateOTPReqModel();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: AuthViewModel(),
      builder: (authViewModel) {
        return GetBuilder<OtpController>(
          init: OtpController(),
          initState: (_) {
            otpController.startTimer();
          },
          builder: (otpController) {
            return Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Stack(
                children: [
                  Form(
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
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Column(
                            children: [
                              Theme(
                                data: ThemeData(
                                    // accentColor: Colors.red,
                                    // primaryColor: Colors.orange,
                                    ),
                                child: PinCodeTextField(
                                  length: 6,
                                  controller: otp,
                                  appContext: context,
                                  textStyle:
                                      TextStyle(color: ColorUtils.black92),
                                  onChanged: (value) =>
                                      otpController.changeotp(value),
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
                                    selectedColor: ColorUtils.black,
                                  ),
                                  pastedTextStyle: TextStyle(
                                    fontWeight: FontWeightClass.fontWeightBold,
                                  ),
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AdoroText(
                          (otpController.timer - otpController.tick) < 10
                              ? "00: 0${otpController.timer - otpController.tick}"
                              : "00: ${otpController.timer - otpController.tick}",
                          color: ColorUtils.green4E,
                        ),
                        if (otpController.hasError == true)
                          Column(
                            children: [
                              SizeConfig.sH3,
                              Center(
                                child: AdoroText(
                                  "Please fill all the cell",
                                  fontSize: 12,
                                  color: ColorUtils.red29,
                                  fontWeight: FontWeightClass.fontWeight400,
                                ),
                              ),
                            ],
                          ),
                        SizeConfig.sH3,
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.color,
                            ),
                            children: [
                              TextSpan(
                                text: VariableUtils.dontReceiveTheOTP,
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    resendOTP(authViewModel: authViewModel);
                                  },
                                text: ' ${VariableUtils.resendOTP}',
                                style: TextStyle(color: ColorUtils.blueB9),
                              ),
                            ],
                          ),
                        ),
                        SizeConfig.sH7,
                        CustomBtn(
                          onTap: () async {
                            if (otpFormKey.currentState!.validate()) {
                              validateOTPReqModel.mobileNo =
                                  Get.arguments['mobile'];
                              validateOTPReqModel.otp = otp.text;
                              await authViewModel
                                  .validateOTP(validateOTPReqModel);

                              if (authViewModel.validateOTPApiResponse.status ==
                                  Status.COMPLETE) {
                                ValidateOTPResModel response =
                                    authViewModel.validateOTPApiResponse.data;
                                if (response.status.toString() == "200") {
                                  showSnackBar(
                                    message: "Login successfully",
                                  );

                                  PreferenceUtils.setString(
                                    key: PreferenceUtils.token,
                                    value: response.token.toString(),
                                  );
                                  otpController.changeerror(false);

                                  PreferenceUtils.setInt(
                                    key: PreferenceUtils.login,
                                    value: 1,
                                  );

                                  Get.offAllNamed(RouteHelper.getDoneRoute());
                                } else {
                                  errorController!
                                      .add(ErrorAnimationType.shake);
                                  otpController.changeerror(true);
                                  showSnackBar(
                                    message: VariableUtils.somethingWentWrong,
                                  );
                                }
                              } else {
                                errorController!.add(ErrorAnimationType.shake);
                                otpController.changeerror(true);
                                showSnackBar(
                                  message: VariableUtils.somethingWentWrong,
                                );
                              }
                            }
                          },
                          text: 'VERIFY NOW',
                        ),
                      ],
                    ),
                  ),
                  if (authViewModel.validateOTPApiResponse.status ==
                      Status.LOADING)
                    loader(context),
                  if (authViewModel.loginApiResponse.status == Status.LOADING)
                    loader(context),
                  if (authViewModel.registerApiResponse.status ==
                      Status.LOADING)
                    loader(context)
                ],
              ),
            );
          },
        );
      },
    );
  }

  loader(context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).textTheme.titleSmall?.color,
      ),
    );
  }

  resendOTP({required AuthViewModel authViewModel}) async {
    if (Get.arguments != null &&
        Get.arguments.containsKey('mobile') &&
        Get.arguments['mobile'] != "") {
      if (Get.arguments['type'] == "login" &&
          Get.arguments.containsKey('type')) {
        loginReqModel.mobileNo = Get.arguments['mobile'];
        await authViewModel.login(loginReqModel);
        if (authViewModel.loginApiResponse.status == Status.COMPLETE) {
          LoginResModel response = authViewModel.loginApiResponse.data;

          if (response.status.toString() == "200") {
            showSnackBar(
              message: response.msg.toString(),
            );
          } else {
            showSnackBar(
              message: response.msg ?? VariableUtils.somethingWentWrong,
            );
          }
        }
      }
      if (Get.arguments['type'] == "register" &&
          Get.arguments.containsKey('type')) {
        registerReqModel.username = Get.arguments['username'];
        registerReqModel.mobileNo = Get.arguments['mobile'];
        await authViewModel.register(registerReqModel);
        if (authViewModel.registerApiResponse.status == Status.COMPLETE) {
          RegisterResModel response = authViewModel.registerApiResponse.data;

          if (response.status.toString() == VariableUtils.status200) {
            showSnackBar(
              message: response.msg.toString(),
              snackColor: ColorUtils.red29,
            );
          } else {
            showSnackBar(
              message: response.msg ?? VariableUtils.somethingWentWrong,
              snackColor: ColorUtils.red29,
            );
          }
        }
      }
    } else {
      logs("SOMETHING WRONG");
    }
  }
}