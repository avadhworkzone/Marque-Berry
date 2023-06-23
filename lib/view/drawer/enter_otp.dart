import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/adoro_text.dart';

import '../../commanWidget/custom_snackbar.dart';
import '../../commanWidget/loader.dart';
import '../../model/apiModel/responseModel/post_comment_res_model.dart';
import '../../model/apis/api_response.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/variable_utils.dart';
import '../../viewModel/drawer_viewmodel.dart';
import '../bottomBar/bottombar.dart';

class EnterOtpScreen extends StatelessWidget {
  final String amount;

  EnterOtpScreen({
    Key? key,
    required this.amount,
  }) : super(key: key);

  String otp = '';

  final DrawerVideModel withdrawnAmountOtpValidate =
      Get.find<DrawerVideModel>();

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.w),
        child: CommonAppBar(title: '', onTap: () => Get.back()),
      ),
      body: Stack(
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 18.h,
              ),
              AdoroText(
                VariableUtils.deepanshuSarmandal,
                fontSize: 13.sp,
                color: blackWhite,
                fontWeight: FontWeight.w300,
              ),
              SizedBox(
                height: 5.h,
              ),
              AdoroText(
                VariableUtils.enterTheOTP,
                color: blackWhite,
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 11.h,
                width: 75.w,
                decoration: BoxDecoration(
                  color: ColorUtils.white,
                  borderRadius: BorderRadius.circular(6.w),
                  boxShadow: [
                    BoxShadow(color: ColorUtils.grey, blurRadius: 2.w)
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.w),
                  child: Stack(
                    children: [
                      TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                        ],
                        onChanged: (value) {
                          otp = value;
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: ColorUtils.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '*******',
                            hintStyle: TextStyle(color: ColorUtils.grey)),
                      ),
                      Positioned(
                        top: 10.w,
                        child: Container(
                          height: 0.2.h,
                          width: 65.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorUtils.linearGradient7,
                                ColorUtils.linearGradient4,
                                ColorUtils.linearGradient5,
                                ColorUtils.linearGradient8,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.w),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              GestureDetector(
                onTap: () async {
                  if (otp.isEmpty) {
                    showSnackBar(
                      message: VariableUtils.pleaseEnterOtp,
                    );
                  } else {
                    await withdrawnAmountOtpValidate
                        .postWithdrawnAmountOtpValidate(otp, amount);
                    if (withdrawnAmountOtpValidate
                            .postWithdrawnAmountOtpValidateApiResponse.status ==
                        Status.COMPLETE) {
                      PostCommentResModel res = withdrawnAmountOtpValidate
                          .postWithdrawnAmountOtpValidateApiResponse.data;

                      if (res.status == 200) {
                        showSnackBar(
                          message: res.msg.toString(),
                          snackbarSuccess: true,
                        );
                        Get.offAll(BottomBar());
                      } else {
                        showSnackBar(message: res.msg.toString()
                            // snackbarSuccess: true,
                            );
                      }
                    }
                  }
                },
                child: Container(
                  height: 4.h,
                  width: 23.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            ImagesWidgets.rectangleImage,
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(5.w))),
                  child: Center(
                      child: AdoroText(
                    VariableUtils.verify,
                    color: ColorUtils.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  )),
                ),
              ),
              const Spacer(),
              Container(
                height: 28.h,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          ImagesWidgets.ellipseImage,
                        ),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.w),
                        topRight: Radius.circular(10.w))),
                child: Center(
                  child: Image.asset("assets/images/adoro.png", scale: 1.3.w),
                  //     child: AdoroText(
                  //   VariableUtils.adoro,
                  //   color: ColorUtils.white,
                  //   fontSize: 25.sp,
                  //   fontWeight: FontWeight.bold,
                  // )
                ),
              )
            ],
          ),
          GetBuilder<DrawerVideModel>(
            builder: (controller) {
              if (withdrawnAmountOtpValidate
                      .postWithdrawnAmountOtpValidateApiResponse.status ==
                  Status.LOADING) {
                return Container(
                  height: Get.height,
                  width: Get.width,
                  color: ColorUtils.black26,
                  child: Loader(),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
