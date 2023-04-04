import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
                child: CommonAppBar(title: VariableUtils.supportText),
              ),
              body: Column(children: [
                Stack(
                  children: [
                    Container(
                      height: size.height / 2.3,
                      width: size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorUtils.linearGradient1,
                            ColorUtils.linearGradient6,
                            ColorUtils.linearGradient7
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        // borderRadius: BorderRadius.vertical(
                        //   bottom: Radius.circular(30),
                        // ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      margin: EdgeInsets.only(bottom: 60.w),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 10.w),
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
                              'Please fill this from,our team will reach out to you soon',
                              fontSize: 13.sp,
                              color: ColorUtils.white,
                              fontWeight: FontWeightClass.fontWeightBold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 7.w,
                      right: 7.w,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.w),
                          border: Border.all(color: ColorUtils.linearGradient5),
                          color: ColorUtils.white,
                        ),
                        height: 45.h,
                        width: 70.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(
                            children: [
                              SizeConfig.sH3,
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: VariableUtils.fullName,
                                  hintStyle:
                                      TextStyle(color: ColorUtils.black92),
                                ),
                              ),
                              SizeConfig.sH1,
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: VariableUtils.Email,
                                  hintStyle:
                                      TextStyle(color: ColorUtils.black92),
                                ),
                              ),
                              SizeConfig.sH4,
                              Container(
                                height: 20.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  color: ColorUtils.white,
                                  border: Border.all(
                                    color: ColorUtils.linearGradient5,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(3.w),
                                  child: AdoroText(
                                    VariableUtils.yourMessage,
                                    color: ColorUtils.black92,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizeConfig.sH4,
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 5.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          ColorUtils.linearGradient1,
                          ColorUtils.linearGradient6,
                          ColorUtils.linearGradient7,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(7.w),
                      color: ColorUtils.linearGradient6,
                    ),
                    child: Center(
                      child: AdoroText(
                        VariableUtils.submit,
                        fontSize: 14.sp,
                        color: ColorUtils.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ]),
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
}
