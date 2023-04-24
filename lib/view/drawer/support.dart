import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';

import '../../commanWidget/noInternet_screen.dart';
import '../../viewModel/connectivity_view_model.dart';

class Support extends StatelessWidget {
  Support({Key? key}) : super(key: key);

  ConnectivityViewModel connectivityViewModel =
      Get.find<ConnectivityViewModel>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<ConnectivityViewModel>(
      init: ConnectivityViewModel(),
      initState: (_) {
        connectivityViewModel.startMonitoring();
      },
      builder: (connectivityViewModel) {
        if (connectivityViewModel.isOnline != null) {
          if (connectivityViewModel.isOnline!) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(16.w),
                child: CommonAppBar(
                  title: VariableUtils.supportText,
                  ontap: () => Get.back(),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  height: 88.h,
                  child: Stack(
                    children: [
                      Container(
                        height: size.height / 2.7,
                        width: size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorUtils.linearGradient1,
                              ColorUtils.linearGradient6,
                              ColorUtils.linearGradient7
                            ],
                            stops: [0, 0.5, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 10.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AdoroText(
                                VariableUtils.hiCheonYeoWoon,
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
                      Positioned(
                        left: 5.w,
                        right: 5.w,
                        top: 60.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorUtils.white,
                            borderRadius: BorderRadius.circular(6.w),
                            border:
                                Border.all(color: ColorUtils.linearGradient5),
                          ),
                          height: 53.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              children: [
                                SizeConfig.sH3,
                                TextFormField(
                                  cursorColor: ColorUtils.black,
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                  ),
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
                                    hintStyle:
                                        TextStyle(color: ColorUtils.black92),
                                  ),
                                ),
                                Container(
                                  height: 0.4.w,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorUtils.linearGradient1,
                                        ColorUtils.linearGradient6,
                                        ColorUtils.linearGradient7,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.0, 0.6, 0.8],
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
                                    hintStyle:
                                        TextStyle(color: ColorUtils.black92),
                                  ),
                                ),
                                Container(
                                  height: 0.4.w,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorUtils.linearGradient1,
                                        ColorUtils.linearGradient6,
                                        ColorUtils.linearGradient7,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      // stops: [0.0, 0.6, 0.8],
                                    ),
                                  ),
                                ),
                                SizeConfig.sH4,

                                // Container(
                                //   width: 70.w,
                                //   decoration: BoxDecoration(
                                //     gradient: LinearGradient(
                                //       colors: [
                                //         ColorUtils.linearGradient1,
                                //         ColorUtils.linearGradient6,
                                //         ColorUtils.linearGradient7,
                                //       ],
                                //       begin: Alignment.topLeft,
                                //       end: Alignment.bottomRight,
                                //       stops: [0.0, 0.6, 0.8],
                                //     ),
                                //   ),
                                //   child: TextFormField(
                                //     cursorColor: ColorUtils.black,
                                //     style: TextStyle(
                                //       color: ColorUtils.black,
                                //     ),
                                //     maxLines: 6,
                                //     decoration: InputDecoration(
                                //       hintText: 'Your Message',
                                //       hintStyle: TextStyle(
                                //         color: Color(0xFFA9A9A9),
                                //       ),
                                //       contentPadding: EdgeInsets.all(4.w),
                                //       border: InputBorder.none,
                                //       focusedBorder: InputBorder.none,
                                //       enabledBorder: InputBorder.none,
                                //       errorBorder: InputBorder.none,
                                //       disabledBorder: InputBorder.none,
                                //     ),
                                //   ),
                                // ),

                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(0.3.w),
                                    child: Container(
                                      width: 80.w,
                                      height: 58.w,
                                      child: TextFormField(
                                        cursorColor: ColorUtils.black,
                                        style: TextStyle(
                                          color: ColorUtils.black,
                                        ),
                                        maxLines: 8,
                                        decoration: InputDecoration(
                                          hintText: 'Your Message',
                                          hintStyle: TextStyle(
                                            color: Color(0xFFA9A9A9),
                                          ),
                                          contentPadding: EdgeInsets.all(4.w),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                      decoration: kInnerDecoration,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorUtils.linearGradient1,
                                        ColorUtils.linearGradient6,
                                        ColorUtils.linearGradient7,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.0, 0.25, 0.55],
                                    ),
                                  ),
                                ),

                                SizeConfig.sH3,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5.w,
                        right: 5.w,
                        top: 60.w + 55.h,
                        child: Container(
                          width: 40.w,
                          height: 13.w,
                          margin: EdgeInsets.only(bottom: 8.w),
                          child: Image.asset("assets/icons/submit_btn.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const NoInterNetConnected();
          }
        } else {
          return const SizedBox();
        }
      },
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
