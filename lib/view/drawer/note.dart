// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

import '../../commanWidget/noInternet_screen.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/variable_utils.dart';
import '../../viewModel/connectivity_view_model.dart';

class Note extends StatelessWidget {
  Note({
    Key? key,
  }) : super(key: key);

  ConnectivityViewModel connectivityViewModel =
      Get.find<ConnectivityViewModel>();

  @override
  Widget build(BuildContext context) {
    return _bulidBody();
  }

  GetBuilder<ConnectivityViewModel> _bulidBody() {
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
                    title: VariableUtils.note, ontap: () => Get.back()),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  children: [
                    SizeConfig.sH1,
                    Container(
                      height: 6.h,
                      width: double.maxFinite,
                      // color: ColorUtils.white,
                      child: Row(
                        children: [
                          AdoroText(
                            "•",
                            fontSize: 20.sp,
                            color: ColorUtils.black92,
                          ),
                          SizeConfig.sW5,
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 2.w),
                              child: AdoroText(
                                'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. ',
                                color: ColorUtils.black92,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizeConfig.sH3,
                    Container(
                      height: 25.h,
                      width: 80.w,
                      color: ColorUtils.note,
                      child: InkWell(
                        onTap: () {},
                        child:
                            // CommonImageScale(
                            //   img: 'assets/images/playmusic.png',
                            //   scale: 1.w,
                            //   color: ColorUtils.transparent,
                            // ),
                            Image.asset(
                          'assets/images/playmusic.png',
                          scale: 0.5.w,
                        ),
                      ),
                    )
                  ],
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
}
