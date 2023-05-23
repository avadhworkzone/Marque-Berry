// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/appService/notification_service.dart';
import 'package:socialv/commanWidget/custom_btn.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/model/apiModel/requestModel/login_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/login_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/routes/route_helper.dart';
import 'package:socialv/utils/custom_text_field.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/validation_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/auth/otp_screen.dart';
import 'package:socialv/viewModel/auth_view_model.dart';

final loginContact = TextEditingController();
final _formKey = GlobalKey<FormState>();

class LoginComponents extends StatelessWidget {
  AuthViewModel authViewModel;

  LoginComponents({Key? key, required this.authViewModel}) : super(key: key);

  LoginReqModel loginReqModel = LoginReqModel();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdoroText(
            VariableUtils.welcomeBack,
            fontSize: 15.sp,
            fontWeight: FontWeightClass.fontWeight600,
            color: Theme.of(context).textTheme.titleSmall?.color,
          ),
          AdoroText(
            VariableUtils.youHaveBeenMissed,
            color: Theme.of(context).textTheme.titleMedium?.color,
          ),
          SizeConfig.sH5,
          AdoroText(
            VariableUtils.mobileNumber,
            color: Theme.of(context).textTheme.titleMedium?.color,
          ),
          CommonTextFormField(
            mobilelength: 10,
            controller: loginContact,
            keyboardType: TextInputType.number,
            validator: (v) => mobileValidation(v),
            color: Theme.of(context).textTheme.titleSmall?.color,
            denyInputFormatters: RegularExpression.noSpaceAllowPattern,
            allowInputFormatters: RegularExpression.contactKeyboardPattern,
          ),
          SizeConfig.sH5,
          Center(
            child: CustomBtn(
              onTap: () async {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  loginReqModel.mobileNo = loginContact.text;
                  loginReqModel.deviceToken = await NotificationService.getDeviceToken();

                  await authViewModel.login(loginReqModel);
                  if (authViewModel.loginApiResponse.status ==
                      Status.COMPLETE) {
                    LoginResModel response =
                        authViewModel.loginApiResponse.data;

                    if (response.status.toString() == VariableUtils.status200) {
                      showSnackBar(
                        message: response.msg.toString(),
                        snackbarSuccess: true,
                      );
                      await Get.to(
                        () => ValidateOtpScreen(
                          mobile: loginContact.text,
                          type: 'login',
                        ),
                      );
                      loginContact.clear();
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
