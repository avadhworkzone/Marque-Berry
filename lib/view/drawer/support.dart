// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/requestModel/suppor_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/viewModel/drawer_viewmodel.dart';

import '../../utils/assets/images_utils.dart';

class Support extends StatelessWidget {
  Support({Key? key}) : super(key: key);

  SupportReqModel reqModel = SupportReqModel();

  final DrawerVideModel viewModel = Get.find<DrawerVideModel>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: CommonAppBar(
          title: VariableUtils.supportText,
          onTap: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Container(
                    height: Get.height - (8.h + 30),
                    width: Get.width,
                    child: Stack(
                      children: [
                        Container(
                          height: size.height / 2.4,
                          width: size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorUtils.linearGradient7,
                                ColorUtils.linearGradient4,
                                ColorUtils.linearGradient5,
                                ColorUtils.linearGradient8,
                              ],
                              // stops: [0, 0.5, 1],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 20.w, left: 8.w, right: 8.w),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AdoroText(
                                    "Hi, ${PreferenceUtils.getString(key: PreferenceUtils.fullname)}",
                                    fontSize: 15.sp,
                                    color: ColorUtils.white,
                                    fontWeight: FontWeightClass.fontWeightBold,
                                  ),
                                  SizeConfig.sH3,
                                  AdoroText(
                                    'Please fill this form, our team will reach out to you soon',
                                    fontSize: 13.sp,
                                    color: ColorUtils.white,
                                    fontWeight: FontWeightClass.fontWeightBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 5.w,
                          right: 5.w,
                          // top: (size.height / 2.4) - 50,
                          bottom: 0,
                          child: Container(
                            width: Get.width,
                            height: Get.height - (size.height / 2.4) + 20,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorUtils.white,
                                    borderRadius: BorderRadius.circular(6.w),
                                    border: GradientBoxBorder(
                                      gradient: LinearGradient(
                                        colors: [
                                          ColorUtils.linearGradient7,
                                          ColorUtils.linearGradient4,
                                          ColorUtils.linearGradient5,
                                          ColorUtils.linearGradient8,
                                        ],
                                        //   stops: [0, 0.3, 0.8],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                  ),
                                  // height: 63.h,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Column(
                                      children: [
                                        SizeConfig.sH3,
                                        TextFormField(
                                          cursorColor: ColorUtils.black,
                                          style: TextStyle(
                                            color: ColorUtils.black,
                                          ),
                                          onChanged: (value) {
                                            reqModel.fullName = value;
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            filled: true,
                                            fillColor: ColorUtils.transparent,
                                            contentPadding: EdgeInsets.zero,
                                            hintText: VariableUtils.fullName,
                                            hintStyle: TextStyle(
                                                color: ColorUtils.black92),
                                          ),
                                        ),
                                        Container(
                                          height: 0.4.w,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                ColorUtils.linearGradient7,
                                                ColorUtils.linearGradient4,
                                                ColorUtils.linearGradient5,
                                                ColorUtils.linearGradient8,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              // stops: [0.0, 0.6, 0.8],
                                              tileMode: TileMode.clamp,
                                            ),
                                          ),
                                        ),
                                        SizeConfig.sH1,
                                        TextFormField(
                                          cursorColor: ColorUtils.black,
                                          style: TextStyle(
                                            color: ColorUtils.black,
                                          ),
                                          onChanged: (value) {
                                            reqModel.email = value;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: ColorUtils.transparent,
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                            hintText: VariableUtils.Email,
                                            hintStyle: TextStyle(
                                                color: ColorUtils.black92),
                                          ),
                                        ),
                                        Container(
                                          height: 0.4.w,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                ColorUtils.linearGradient7,
                                                ColorUtils.linearGradient4,
                                                ColorUtils.linearGradient5,
                                                ColorUtils.linearGradient8,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              // stops: [0.0, 0.6, 0.8],
                                            ),
                                          ),
                                        ),
                                        SizeConfig.sH4,
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(0.3.w),
                                            child: Container(
                                              width: 80.w,
                                              height: 40.w,
                                              child: TextFormField(
                                                cursorColor: ColorUtils.black,
                                                style: TextStyle(
                                                  color: ColorUtils.black,
                                                ),
                                                maxLines: 8,
                                                onChanged: (value) {
                                                  reqModel.message = value;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Your Message',
                                                  hintStyle: TextStyle(
                                                    color: Color(0xFFA9A9A9),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(4.w),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                              decoration: kInnerDecoration,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                ColorUtils.linearGradient7,
                                                ColorUtils.linearGradient4,
                                                ColorUtils.linearGradient5,
                                                ColorUtils.linearGradient8,
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              // stops: [0.0, 0.25, 0.55],
                                            ),
                                          ),
                                        ),
                                        SizeConfig.sH3,
                                      ],
                                    ),
                                  ),
                                ),
                                SizeConfig.sH2,
                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () async {
                                    final validationCheck = reqModel
                                        .toJson()
                                        .values
                                        .where((element) =>
                                            element == null || element == "")
                                        .toList();
                                    print('validationCheck=>$validationCheck');
                                    if (validationCheck.isNotEmpty) {
                                      showSnackBar(
                                        message: "All fields all required",
                                        snackbarSuccess: true,
                                      );
                                      return;
                                    }
                                    FocusScope.of(context).unfocus();
                                    await viewModel.support(reqModel);
                                    if (viewModel
                                            .postSupportApiResponse.status ==
                                        Status.COMPLETE) {
                                      CommonStatusMsgResModel resModel =
                                          viewModel.postSupportApiResponse.data;
                                      if (resModel.status == 200) {
                                        showSnackBar(
                                          message: resModel.msg ??
                                              "Support added successfully",
                                          snackbarSuccess: true,
                                        );
                                        formKey.currentState!.reset();
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 40.w,
                                    height: 13.w,
                                    child: Image.asset(
                                      IconsWidgets.submitBtnImages,
                                    ),
                                  ),
                                ),
                                //SizeConfig.sH3,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          GetBuilder<DrawerVideModel>(
            builder: (controller) {
              if (controller.postSupportApiResponse.status == Status.LOADING) {
                return Container(
                  height: Get.height,
                  width: Get.width,
                  color: ColorUtils.black26,
                  child: Loader(),
                );
              }
              return SizedBox();
            },
          )
        ],
      ),
    );
  }

  final borderWidth = 1.0;
  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
  );
  final kGradientBoxDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        ColorUtils.linearGradient1,
        ColorUtils.linearGradient6,
        ColorUtils.linearGradient7,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 0.2, 0.4],
    ),
  );
}
