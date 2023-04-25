import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/view/drawer/withdrawn_amount.dart';

import '../../commanWidget/noInternet_screen.dart';
import '../../utils/assets/images_utils.dart';
import '../../viewModel/connectivity_view_model.dart';

class Wallet extends StatelessWidget {
  Wallet({Key? key}) : super(key: key);
  ConnectivityViewModel connectivityViewModel =
      Get.find<ConnectivityViewModel>();

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? whiteBlack = Theme.of(context).scaffoldBackgroundColor;

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
                  title: VariableUtils.walletText,
                  ontap: () => Get.back(),
                ),
              ),
              body: Center(
                child: Column(
                  children: [
                    SizeConfig.sH3,
                    AdoroText(
                      VariableUtils.deepanshuSarmandal,
                      fontSize: 14.sp,
                    ),
                    SizeConfig.sH2,
                    CircleAvatar(
                      radius: 15.w,
                      child: Stack(
                        children: [
                          Image(
                              image: AssetImage(
                            ImagesWidgets.circleImage,
                          )),
                          // ImagesWidgets.circleImage,
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Image.asset(
                              ImagesWidgets.profile2Image,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizeConfig.sH2,
                    AdoroText(
                      VariableUtils.youHaveEarned,
                      color: blackWhite,
                      fontWeight: FontWeight.bold,
                      // color: blackWhite,
                      fontSize: 12.sp,
                    ),
                    SizeConfig.sH1,
                    AdoroText(
                      VariableUtils.wallet75,
                      color: blackWhite,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizeConfig.sH2,

                    InkWell(
                      splashColor: ColorUtils.transparent,
                      highlightColor: ColorUtils.transparent,
                      onTap: () => Get.to(WithdrawlAmount()),
                      child: Container(
                        height: 5.h,
                        width: 53.w,
                        decoration: BoxDecoration(

                            image: DecorationImage(
                          image: AssetImage(
                            ImagesWidgets.RectangleImage,

                          ),),
                        ),
                        child: Center(
                          child: AdoroText(
                            VariableUtils.withdrawMoney,
                            fontSize: 12.sp,
                            color: ColorUtils.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Container(
                    //   height: 5.h,
                    //   width: 60.w,
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         ColorUtils.linearGradient1,
                    //         ColorUtils.linearGradient6,
                    //         ColorUtils.linearGradient7
                    //       ],
                    //       begin: Alignment.topLeft,
                    //       end: Alignment.bottomRight,
                    //     ),
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(8.w),
                    //     ),
                    //   ),
                    //   child: Center(
                    //     child: AdoroText(
                    //       VariableUtils.withdrawMoney,
                    //       color: ColorUtils.white,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 12.sp,
                    //     ),
                    //   ),
                    // ),
                    SizeConfig.sH3,
                    AdoroText(
                      VariableUtils.withdrawMinimumLimit,
                      color: blackWhite,
                    ),
                    SizeConfig.sH1,
                    AdoroText(
                      VariableUtils.cashCoin,
                      color: blackWhite,
                    ),
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
