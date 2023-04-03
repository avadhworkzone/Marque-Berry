import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/custom_btn.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/model/apiModel/requestModel/register_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/register_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/routes/route_helper.dart';
import 'package:socialv/utils/custom_text_field.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/validation_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/viewModel/auth_view_model.dart';

class RegisterComponents extends StatelessWidget {
  AuthViewModel authViewModel;

  RegisterComponents({Key? key, required this.authViewModel}) : super(key: key);

  final registerKey = GlobalKey<FormState>();

  var fullName = TextEditingController();
  var username = TextEditingController();
  var registerContact = TextEditingController();

  RegisterReqModel registerReqModel = RegisterReqModel();

  @override
  Widget build(BuildContext context) {
    Color? whiteBlack2E = Theme.of(context).cardColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92BlueB9 = Theme.of(context).textTheme.titleLarge?.color;

    return Form(
      key: registerKey,
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
            controller: fullName,
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
            allowInputFormatters: RegularExpression.nameKeyboardPattern,
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
                if (registerKey.currentState!.validate()) {
                  registerReqModel.username = username.text;
                  registerReqModel.mobileNo = registerContact.text;
                  await authViewModel.register(registerReqModel);

                  if (authViewModel.registerApiResponse.status ==
                      Status.COMPLETE) {
                    RegisterResModel response =
                        authViewModel.registerApiResponse.data;

                    if (response.status.toString() == VariableUtils.status200) {
                      showSnackBar(
                        message: response.msg.toString(),
                      );
                      Get.toNamed(
                        RouteHelper.getValidateOTPRoute(),
                        arguments: {
                          "mobile": registerContact.text,
                          "username": username.text,
                          "type": "register"
                        },
                      );
                    } else {
                      showSnackBar(message: VariableUtils.somethingWentWrong);
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
