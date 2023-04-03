import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/custom_btn.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/model/apiModel/requestModel/login_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/login_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/routes/route_helper.dart';
import 'package:socialv/utils/custom_text_field.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/validation_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/viewModel/auth_view_model.dart';

class LoginComponents extends StatelessWidget {
  AuthViewModel authViewModel;

  LoginComponents({Key? key, required this.authViewModel}) : super(key: key);

  final loginKey = GlobalKey<FormState>();
  var loginContact = TextEditingController();

  LoginReqModel loginReqModel = LoginReqModel();
  // AuthViewModel authViewModel = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdoroText(
            VariableUtils.welcomeBack,
            fontSize: 15.sp,
            color: Theme.of(context).textTheme.titleSmall?.color,
            fontWeight: FontWeight.bold,
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
            color: Theme.of(context).textTheme.titleSmall?.color,
            validator: (v) => mobileValidation(v),
            controller: loginContact,
            mobilelength: 10,
            keyboardType: TextInputType.number,
            denyInputFormatters: RegularExpression.noSpaceAllowPattern,
            allowInputFormatters: RegularExpression.contactKeyboardPattern,
          ),
          SizeConfig.sH5,
          Center(
            child: CustomBtn(
              onTap: () async {
                FocusScope.of(context).unfocus();
                if (loginKey.currentState!.validate()) {
                  loginReqModel.mobileNo = loginContact.text;
                  await authViewModel.login(loginReqModel);
                  if (authViewModel.loginApiResponse.status ==
                      Status.COMPLETE) {
                    LoginResModel response =
                        authViewModel.loginApiResponse.data;

                    if (response.status.toString() == "200") {
                      showSnackBar(
                        message: response.msg.toString(),
                      );
                      Get.toNamed(
                        RouteHelper.getValidateOTPRoute(),
                        arguments: {
                          "mobile": loginContact.text,
                          "type": "login",
                        },
                      );
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
