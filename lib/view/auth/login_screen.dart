import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/routes/route_helper.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/validation_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/commanWidget/custom_btn.dart';
import 'package:socialv/utils/custom_text_field.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/view/auth/components/register_components.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/controllers/login_controller.dart';
import 'package:socialv/view/auth/components/login_components.dart';
import 'package:socialv/model/apiModel/requestModel/login_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/register_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/register_res_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginKey = GlobalKey<FormState>();
  final registerKey = GlobalKey<FormState>();

  var loginContact = TextEditingController();

  var fullName = TextEditingController();
  var username = TextEditingController();
  var registerContact = TextEditingController();

  LoginReqModel loginReqModel = LoginReqModel();
  RegisterReqModel registerReqModel = RegisterReqModel();

  AuthViewModel authViewModel = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (loginController) {
        return GetBuilder<AuthViewModel>(
          builder: (authViewModel) {
            return Scaffold(
              backgroundColor: Theme.of(context).cardColor,
              body: Stack(
                children: [
                  SingleChildScrollView(
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
                                decoration:
                                    DecorationUtils.loginDecoration(context),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          loginController.changeindex(0),
                                      child: AdoroText(
                                        "LOGIN",
                                        fontSize: 13.sp,
                                        color:
                                            loginController.selectedIndex == 0
                                                ? Colors.white
                                                : ColorUtils.blueE7,
                                        fontWeight:
                                            FontWeightClass.fontWeight600,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          loginController.changeindex(1),
                                      child: AdoroText(
                                        "SIGN UP",
                                        fontSize: 13.sp,
                                        color:
                                            loginController.selectedIndex == 1
                                                ? Colors.white
                                                : ColorUtils.blueE7,
                                        fontWeight:
                                            FontWeightClass.fontWeight600,
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
                                        if (loginController.selectedIndex == 0)
                                          LoginComponents(
                                            authViewModel: authViewModel,
                                          )
                                        // Form(
                                        //   key: loginKey,
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //     children: [
                                        //       AdoroText(
                                        //         VariableUtils.welcomeBack,
                                        //         fontSize: 15.sp,
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleSmall
                                        //             ?.color,
                                        //         fontWeight: FontWeight.bold,
                                        //       ),
                                        //       AdoroText(
                                        //         VariableUtils
                                        //             .youHaveBeenMissed,
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleMedium
                                        //             ?.color,
                                        //       ),
                                        //       SizeConfig.sH5,
                                        //       AdoroText(
                                        //         VariableUtils.mobileNumber,
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleMedium
                                        //             ?.color,
                                        //       ),
                                        //       CommonTextFormField(
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleSmall
                                        //             ?.color,
                                        //         validator: (v) =>
                                        //             mobileValidation(v),
                                        //         controller: loginContact,
                                        //         mobilelength: 10,
                                        //         keyboardType:
                                        //             TextInputType.number,
                                        //         denyInputFormatters:
                                        //             RegularExpression
                                        //                 .noSpaceAllowPattern,
                                        //         allowInputFormatters:
                                        //             RegularExpression
                                        //                 .contactKeyboardPattern,
                                        //       ),
                                        //       SizeConfig.sH5,
                                        //       Center(
                                        //         child: CustomBtn(
                                        //           onTap: () async {
                                        //             FocusScope.of(context)
                                        //                 .unfocus();
                                        //             if (loginKey.currentState!
                                        //                 .validate()) {
                                        //               loginReqModel.mobileNo =
                                        //                   loginContact.text;
                                        //               await authViewModel
                                        //                   .login(
                                        //                       loginReqModel);
                                        //               if (authViewModel
                                        //                       .loginApiResponse
                                        //                       .status ==
                                        //                   Status.COMPLETE) {
                                        //                 LoginResModel
                                        //                     response =
                                        //                     authViewModel
                                        //                         .loginApiResponse
                                        //                         .data;
                                        //
                                        //                 if (response.status
                                        //                         .toString() ==
                                        //                     "200") {
                                        //                   showSnackBar(
                                        //                     message: response
                                        //                         .msg
                                        //                         .toString(),
                                        //                   );
                                        //                   Get.toNamed(
                                        //                     RouteHelper
                                        //                         .getValidateOTPRoute(),
                                        //                     arguments: {
                                        //                       "mobile":
                                        //                           loginContact
                                        //                                   .text ??
                                        //                               ""
                                        //                     },
                                        //                   );
                                        //                 } else {
                                        //                   showSnackBar(
                                        //                     message:
                                        //                         "Something went wrong",
                                        //                   );
                                        //                 }
                                        //               }
                                        //             }
                                        //           },
                                        //           text: 'GET OTP',
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // )
                                        else if (loginController
                                                .selectedIndex ==
                                            1)
                                          RegisterComponents(
                                            authViewModel: authViewModel,
                                          ),
                                        // Form(
                                        //   key: registerKey,
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //     children: [
                                        //       AdoroText(
                                        //         VariableUtils.welcomeCreator,
                                        //         fontSize: 15.sp,
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleSmall
                                        //             ?.color,
                                        //         fontWeight: FontWeight.bold,
                                        //       ),
                                        //       AdoroText(
                                        //         VariableUtils.joinTheWorld,
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleMedium
                                        //             ?.color,
                                        //       ),
                                        //       SizeConfig.sH5,
                                        //       AdoroText(
                                        //         VariableUtils.fullName,
                                        //         fontFamily: RegularExpression
                                        //             .fullNameKeyboardPattern,
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleMedium
                                        //             ?.color,
                                        //       ),
                                        //       CommonTextFormField(
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleSmall
                                        //             ?.color,
                                        //         keyboardType:
                                        //             TextInputType.name,
                                        //         validator: (v) =>
                                        //             userValidation(v),
                                        //         controller: fullName,
                                        //         denyInputFormatters:
                                        //             RegularExpression
                                        //                 .onlyFirstSpaceNoAllowPattern,
                                        //         allowInputFormatters:
                                        //             RegularExpression
                                        //                 .alphabetSpacePattern,
                                        //       ),
                                        //       SizeConfig.sH2,
                                        //       AdoroText(
                                        //         VariableUtils.userName,
                                        //         fontFamily: RegularExpression
                                        //             .nameKeyboardPattern,
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleMedium
                                        //             ?.color,
                                        //       ),
                                        //       CommonTextFormField(
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleSmall
                                        //             ?.color,
                                        //         keyboardType:
                                        //             TextInputType.name,
                                        //         validator: (v) =>
                                        //             userValidation(v),
                                        //         controller: username,
                                        //         denyInputFormatters:
                                        //             RegularExpression
                                        //                 .noSpaceAllowPattern,
                                        //         allowInputFormatters:
                                        //             RegularExpression
                                        //                 .nameKeyboardPattern,
                                        //       ),
                                        //       SizeConfig.sH2,
                                        //       AdoroText(
                                        //         VariableUtils.mobileNumber,
                                        //         fontFamily: RegularExpression
                                        //             .contactKeyboardPattern,
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleMedium
                                        //             ?.color,
                                        //       ),
                                        //       CommonTextFormField(
                                        //         color: Theme.of(context)
                                        //             .textTheme
                                        //             .titleSmall
                                        //             ?.color,
                                        //         keyboardType:
                                        //             TextInputType.number,
                                        //         mobilelength: 10,
                                        //         validator: (v) =>
                                        //             mobileValidation(v),
                                        //         controller: registerContact,
                                        //         denyInputFormatters:
                                        //             RegularExpression
                                        //                 .noSpaceAllowPattern,
                                        //         allowInputFormatters:
                                        //             RegularExpression
                                        //                 .contactKeyboardPattern,
                                        //       ),
                                        //       SizeConfig.sH5,
                                        //       Center(
                                        //         child: CustomBtn(
                                        //           onTap: () async {
                                        //             FocusScope.of(context)
                                        //                 .unfocus();
                                        //             if (registerKey
                                        //                 .currentState!
                                        //                 .validate()) {
                                        //               registerReqModel
                                        //                       .username =
                                        //                   username.text;
                                        //               registerReqModel
                                        //                       .mobileNo =
                                        //                   registerContact
                                        //                       .text;
                                        //               await authViewModel
                                        //                   .register(
                                        //                       registerReqModel);
                                        //
                                        //               if (authViewModel
                                        //                       .registerApiResponse
                                        //                       .status ==
                                        //                   Status.COMPLETE) {
                                        //                 RegisterResModel
                                        //                     response =
                                        //                     authViewModel
                                        //                         .registerApiResponse
                                        //                         .data;
                                        //
                                        //                 if (response.status
                                        //                         .toString() ==
                                        //                     "200") {
                                        //                   showSnackBar(
                                        //                     message: response
                                        //                         .msg
                                        //                         .toString(),
                                        //                   );
                                        //                   Get.toNamed(
                                        //                     RouteHelper
                                        //                         .getValidateOTPRoute(),
                                        //                     arguments: {
                                        //                       "mobile":
                                        //                           registerContact
                                        //                               .text
                                        //                     },
                                        //                   );
                                        //                 } else {
                                        //                   showSnackBar(
                                        //                     message: VariableUtils
                                        //                         .somethingWentWrong,
                                        //                   );
                                        //                 }
                                        //               }
                                        //             }
                                        //           },
                                        //           text: 'GET OTP',
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
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
                  if (authViewModel.loginApiResponse.status == Status.LOADING)
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: ColorUtils.black,
                      ),
                    ),
                  if (authViewModel.registerApiResponse.status ==
                      Status.LOADING)
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: ColorUtils.black,
                      ),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
