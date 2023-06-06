import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/view/drawer/enter_otp.dart';

import '../../utils/assets/images_utils.dart';
import '../../utils/variable_utils.dart';

class WithdrawlAmount extends StatelessWidget {
  const WithdrawlAmount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.w),
        child: CommonAppBar(title: '', onTap: () => Get.back()),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 15.h,
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
            VariableUtils.enterTheWithdrawalAmount,
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
                ]),
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.w),
              child: Stack(
                children: [
                  TextField(
                    // focusNode: FocusScope.of(context).unfocus(),
                    style: TextStyle(color: ColorUtils.black),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'withdrawal Amount',
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.w))),
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          GestureDetector(
            onTap: () => Get.to(() => EnterOtpScreen()),
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
                VariableUtils.next,
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
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(10.w),
              //     topRight: Radius.circular(10.w))
            ),
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
    );
  }
}
