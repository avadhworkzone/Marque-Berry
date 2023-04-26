// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:sizer/sizer.dart';
// import 'package:socialv/commanWidget/common_appbar.dart';
// import 'package:socialv/utils/color_utils.dart';
// import 'package:socialv/utils/size_config_utils.dart';
// import 'package:socialv/utils/tecell_text.dart';
// import 'package:socialv/utils/variable_utils.dart';
//
// import '../../commanWidget/noInternet_screen.dart';
// import '../../viewModel/connectivity_view_model.dart';
//
// class Result extends StatelessWidget {
//   Result({Key? key}) : super(key: key);
//
//   ConnectivityViewModel connectivityViewModel =
//       Get.find<ConnectivityViewModel>();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ConnectivityViewModel>(
//       init: ConnectivityViewModel(),
//       initState: (_) {
//         connectivityViewModel.startMonitoring();
//       },
//       builder: (connectivityViewModel) {
//         if (connectivityViewModel.isOnline != null) {
//           if (connectivityViewModel.isOnline!) {
//             return Scaffold(
//               appBar: PreferredSize(
//                 preferredSize: Size.fromHeight(16.w),
//                 child: CommonAppBar(
//                     title: VariableUtils.resultText, ontap: () => Get.back()),
//               ),
//               body: Padding(
//                 padding: EdgeInsets.all(3.w),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: 11,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: EdgeInsets.only(bottom: 1.w),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 AdoroText(
//                                   "•",
//                                   color: index == 0
//                                       ? ColorUtils.grey
//                                       : ColorUtils.result,
//                                   fontSize: 10.w,
//                                 ),
//                                 SizeConfig.sW5,
//                                 const Expanded(
//                                   child: AdoroText(
//                                     'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.',
//                                     color: ColorUtils.black92,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return const NoInterNetConnected();
//           }
//         } else {
//           return const SizedBox();
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/view/drawer/view_result.dart';

import '../../commanWidget/common_appbar.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';

class Result extends StatelessWidget {
  Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;
    return SafeArea(
        child: Scaffold(
            backgroundColor: whiteBlack2E,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(16.w),
              child: CommonAppBar(
                color: ColorUtils.transparent,
                title: VariableUtils.resultText,
                ontap: () => Get.back(),
              ),
            ),
            body: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      SizeConfig.sH3,
                      Container(
                        height: 8.h,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: whiteBlack2E,
                          boxShadow: [
                            BoxShadow(blurRadius: 2, color: Colors.grey),
                          ],
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: Row(
                          children: [
                            SizeConfig.sW2,
                            CircleAvatar(
                              child: ImagesWidgets.userImage,
                            ),
                            SizeConfig.sW2,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizeConfig.sH1,
                                AdoroText(
                                  VariableUtils.brandName,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeightClass.fontWeightBold,
                                  color: blackWhite,
                                ),
                                AdoroText(
                                  VariableUtils.campaignName,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeightClass.fontWeightBold,
                                  color: ColorUtils.black92,
                                ),
                              ],
                            ),
                            SizeConfig.sW13,
                            InkWell(
                              onTap: () => Get.to(ViewResult()),
                              child: Container(
                                height: 4.h,
                                width: 24.w,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      ColorUtils.linearGradient1,
                                      ColorUtils.linearGradient6,
                                      ColorUtils.linearGradient7
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2.w),
                                  ),
                                ),
                                child: Center(
                                  child: AdoroText(
                                    VariableUtils.viewResult,
                                    color: ColorUtils.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            )));
  }
}
