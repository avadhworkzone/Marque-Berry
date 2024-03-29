import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/appService/notification_service.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/commanWidget/success_screen.dart';
import 'package:socialv/controllers/validate_otp_controller.dart';
import 'package:socialv/model/apiModel/requestModel/login_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/otp_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/otp_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import 'package:socialv/viewModel/setting_viewmodel.dart';

import '../../commanWidget/custom_btn.dart';
import '../../model/apiModel/responseModel/login_res_model.dart';
import '../../utils/adoro_text.dart';
import '../../utils/color_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/variable_utils.dart';

class ValidateOtpScreen extends StatefulWidget {
  String type;
  String mobile;

  ValidateOtpScreen({
    Key? key,
    required this.mobile,
    required this.type,
  }) : super(key: key);

  @override
  State<ValidateOtpScreen> createState() => _ValidateOtpScreenState();
}

class _ValidateOtpScreenState extends State<ValidateOtpScreen> {
  TextEditingController otp = TextEditingController(text: "");

  final otpFormKey = GlobalKey<FormState>();

  LoginReqModel loginReqModel = LoginReqModel();
  ValidateOTPReqModel validateOTPReqModel = ValidateOTPReqModel();

  AuthViewModel authViewModel = Get.find<AuthViewModel>();
  OtpController otpController = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: AuthViewModel(),
      builder: (authViewModel) {
        return GetBuilder<OtpController>(
          init: OtpController(),
          initState: (_) {
            otpController.startTimer();
            authViewModel.validateOTPApiResponse =
                ApiResponse.initial('INITIAL');
          },
          builder: (otpController) {
            return Material(
              // color: Theme.of(context).scaffoldBackgroundColor,
              color: Theme.of(context).cardColor,
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
                          textAlign: TextAlign.center,
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        ),
                        SizeConfig.sH5,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Column(
                            children: [
                              Theme(
                                data: ThemeData(),
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
                                  // errorAnimationController: errorController,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 15.w,
                                    fieldWidth: 12.w,
                                    activeColor: ColorUtils.grey[200],
                                    activeFillColor: ColorUtils.grey[200],
                                    selectedFillColor: ColorUtils.grey[200],
                                    inactiveColor: ColorUtils.grey[200],
                                    inactiveFillColor: ColorUtils.grey[200],
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
                        SizeConfig.sH1,
                        AdoroText(
                          (otpController.timer - otpController.tick) < 10
                              ? "00: 0${otpController.timer - otpController.tick}"
                              : "00: ${otpController.timer - otpController.tick}",
                          color: ColorUtils.green4E,
                          fontWeight: FontWeightClass.fontWeight600,
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
                                    if ((otpController.timer -
                                            otpController.tick) ==
                                        0) {
                                      otpController.startTimer();
                                      resendOTP(authViewModel: authViewModel);
                                    }
                                  },
                                text: ' ${VariableUtils.resendOTP}',
                                style: TextStyle(
                                  fontWeight: (otpController.timer -
                                              otpController.tick) ==
                                          0
                                      ? FontWeightClass.fontWeightBold
                                      : FontWeightClass.fontWeightNormal,
                                  color: (otpController.timer -
                                              otpController.tick) ==
                                          0
                                      ? ColorUtils.blueB9
                                      : ColorUtils.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizeConfig.sH5,
                        CustomBtn(
                          onTap: () async {
                            print("===========${Get.arguments}");
                            if (otpFormKey.currentState!.validate()) {
                              validateOTPReqModel.mobileNo = widget.mobile;
                              // Get.arguments['mobile'];
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
                                    snackbarSuccess: true,
                                  );
                                  final deviceToken = await NotificationService
                                      .getDeviceToken();
                                  await PreferenceUtils.setString(
                                    key: PreferenceUtils.deviceToken,
                                    value:
                                        response.data?.deviceToken.toString() ??
                                            deviceToken,
                                  );
                                  await PreferenceUtils.setString(
                                    key: PreferenceUtils.referId,
                                    value: response.data?.referId ?? "",
                                  );
                                  await PreferenceUtils.setString(
                                    key: PreferenceUtils.token,
                                    value: response.token ?? "",
                                  );

                                  await PreferenceUtils.setString(
                                    key: PreferenceUtils.username,
                                    value: response.data?.username ?? "",
                                  );
                                  await PreferenceUtils.setString(
                                    key: PreferenceUtils.fullname,
                                    value: response.data?.fullName ?? "",
                                  );

                                  await PreferenceUtils.setString(
                                    key: PreferenceUtils.coverImage,
                                    value: response.data?.coverPhoto ?? "",
                                  );
                                  await PreferenceUtils.setString(
                                    key: PreferenceUtils.profileImage,
                                    value: response.data?.image ?? "",
                                  );

                                  await PreferenceUtils.setInt(
                                    key: PreferenceUtils.userid,
                                    value: response.data?.id ?? 0,
                                  );

                                  await PreferenceUtils.setInt(
                                    key: PreferenceUtils.login,
                                    value: 1,
                                  );
                                  await PreferenceUtils.setBool(
                                    key: PreferenceUtils.isNotification,
                                    value: response.data?.notification ?? true,
                                  );
                                  Get.find<SettingViewModel>().isNotification =
                                      response.data?.notification ?? true;
                                  Get.to(() => SuccessLogin());

                                  // Get.offAllNamed(RouteHelper.getDoneRoute());
                                } else if (response.status.toString() ==
                                    "500") {
                                  showSnackBar(
                                    message: response.msg ??
                                        VariableUtils.somethingWentWrong,
                                  );
                                } else {
                                  showSnackBar(
                                    message: VariableUtils.somethingWentWrong,
                                  );
                                }
                              } else {
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
    if (widget.mobile != "") {
      loginReqModel.mobileNo = widget.mobile;
      await authViewModel.login(loginReqModel);
      if (authViewModel.loginApiResponse.status == Status.COMPLETE) {
        LoginResModel response = authViewModel.loginApiResponse.data;

        if (response.status.toString() == "200") {
          showSnackBar(
            message: response.msg.toString(),
            snackbarSuccess: true,
          );
        } else {
          showSnackBar(
            message: response.msg ?? VariableUtils.somethingWentWrong,
          );
        }
      }
    } else {
      logs("SOMETHING WRONG");
    }
  }
}
