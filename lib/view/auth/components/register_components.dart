// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/appService/notification_service.dart';
import 'package:socialv/commanWidget/custom_btn.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/model/apiModel/requestModel/register_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/register_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/custom_text_field.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/validation_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/viewModel/auth_view_model.dart';

import '../otp_screen.dart';

final username = TextEditingController();
final fullNameController = TextEditingController();
final registerContact = TextEditingController();
final _formKey = GlobalKey<FormState>();

class RegisterComponents extends StatelessWidget {
  AuthViewModel authViewModel;
  final String? referId;

  RegisterComponents({Key? key, required this.authViewModel, this.referId})
      : super(key: key);

  RegisterReqModel registerReqModel = RegisterReqModel();

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdoroText(
            VariableUtils.welcomeCreator,
            fontSize: 15.sp,
            color: blackWhite,
            fontWeight: FontWeightClass.fontWeightBold,
          ),
          AdoroText(VariableUtils.joinTheWorld, color: black92White),
          SizeConfig.sH5,
          AdoroText(VariableUtils.fullName, color: black92White),
          CommonTextFormField(
            color: blackWhite,
            controller: fullNameController,
            keyboardType: TextInputType.name,
            validator: (v) => userValidation(v),
            denyInputFormatters: RegularExpression.onlyFirstSpaceNoAllowPattern,
            allowInputFormatters: RegularExpression.alphabetSpacePattern,
          ),
          SizeConfig.sH2,
          AdoroText(VariableUtils.userName, color: black92White),
          CommonTextFormField(
            color: blackWhite,
            controller: username,
            keyboardType: TextInputType.name,
            validator: (v) => userValidation(v),
            denyInputFormatters: RegularExpression.noSpaceAllowPattern,
            allowInputFormatters: RegularExpression.alphabetDigitsUnderPattern,
          ),
          SizeConfig.sH2,
          AdoroText(VariableUtils.mobileNumber, color: black92White),
          CommonTextFormField(
            color: blackWhite,
            keyboardType: TextInputType.number,
            mobilelength: 10,
            validator: (v) => mobileValidation(v),
            controller: registerContact,
            denyInputFormatters: RegularExpression.noSpaceAllowPattern,
            allowInputFormatters: RegularExpression.contactKeyboardPattern,
          ),
          SizeConfig.sH5,
          Center(
            child: CustomBtn(
              onTap: () async {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  registerReqModel.username = username.text;
                  registerReqModel.mobileNo = registerContact.text;
                  registerReqModel.fullName = fullNameController.text;
                  registerReqModel.deviceToken =
                      await NotificationService.getDeviceToken();
                  registerReqModel.referId = referId;
                  await authViewModel.register(registerReqModel);

                  if (authViewModel.registerApiResponse.status ==
                      Status.COMPLETE) {
                    RegisterResModel response =
                        authViewModel.registerApiResponse.data;

                    if (response.status.toString() == VariableUtils.status200) {
                      showSnackBar(
                        message: response.msg.toString(),
                        snackbarSuccess: true,
                      );

                      Get.to(
                        () => ValidateOtpScreen(
                          mobile: registerContact.text,
                          type: 'register',
                        ),
                      );

                      _formKey.currentState!.reset();
                      // Get.toNamed(
                      //   RouteHelper.getValidateOTPRoute(),
                      //   arguments: {
                      //     "mobile": registerContact.text,
                      //     "type": "register"
                      //   },
                      // );
                    } else {
                      showSnackBar(
                        message:
                            response.msg ?? VariableUtils.somethingWentWrong,
                      );
                    }
                  }
                }
              },
              text: 'GET OTP',
            ),
          ),
        ],
      ),
    );
  }
}
