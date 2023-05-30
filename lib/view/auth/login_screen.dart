import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/controllers/login_controller.dart';
import 'package:socialv/view/auth/components/login_components.dart';
import 'package:socialv/view/auth/components/register_components.dart';
import 'package:socialv/model/apiModel/requestModel/login_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/register_req_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, this.referId}) : super(key: key);
  final String? referId;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthViewModel authViewModel = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;

    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (loginController) {
        return GetBuilder<AuthViewModel>(
          builder: (authViewModel) {
            return Scaffold(
              backgroundColor: whiteBlack2E,
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
                        SizeConfig.sH4,
                        Container(
                          height: Get.height - 24.h,
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 1.w),
                                width: Get.width,
                                height: 15.h,
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
                                    color: whiteBlack2E,
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
                                        else if (loginController
                                                .selectedIndex ==
                                            1)
                                          RegisterComponents(
                                            authViewModel: authViewModel,
                                            referId: widget.referId,
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
