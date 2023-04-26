// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:sizer/sizer.dart';
// import 'package:socialv/utils/color_utils.dart';
// import 'package:socialv/utils/tecell_text.dart';
// import 'package:socialv/commanWidget/common_appbar.dart';
// import 'package:socialv/utils/variable_utils.dart';
//
// import '../../commanWidget/noInternet_screen.dart';
// import '../../utils/size_config_utils.dart';
// import '../../viewModel/connectivity_view_model.dart';
//
// class NotificationScreen extends StatelessWidget {
//   NotificationScreen({Key? key}) : super(key: key);
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
//             return SafeArea(
//               child: Scaffold(
//                 appBar: PreferredSize(
//                   preferredSize: Size.fromHeight(16.w),
//                   child: CommonAppBar(
//                     title: VariableUtils.notificationText,
//                     ontap: () => Get.back(),
//                   ),
//                 ),
//                 body: Padding(
//                   padding: EdgeInsets.all(4.w),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: 11,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: EdgeInsets.only(bottom: 3.w),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   AdoroText(
//                                     "•",
//                                     color: index == 0
//                                         ? ColorUtils.grey
//                                         : ColorUtils.result,
//                                     fontSize: 20.sp,
//                                   ),
//                                   SizeConfig.sW5,
//                                   const Expanded(
//                                     child: AdoroText(
//                                       'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.',
//                                       color: ColorUtils.black92,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     ],
//                   ),
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

import '../../commanWidget/common_appbar.dart';
import '../../commanWidget/common_image.dart';
import '../../commanWidget/custom_btn.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(16.w),
        child: CommonAppBar(
          title: VariableUtils.notificationText,
          ontap: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdoroText(
              VariableUtils.SeeAllRequests,
              fontSize: 13.sp,
              fontWeight: FontWeightClass.fontWeightBold,
              color: ColorUtils.blueB9,
            ),
            SizeConfig.sH2,
            Ritikraj(),
            SizeConfig.sH5,
            AdoroText(
              VariableUtils.SuggestedForYou,
              fontSize: 13.sp,
              fontWeight: FontWeightClass.fontWeightBold,
              color: blackWhite,
            ),
            SizeConfig.sH4,
            UserNameFollow(),
            SizeConfig.sH3, UserNameFollow(),
            SizeConfig.sH3, UserNameFollow(),
            SizeConfig.sH3,
            // UserNameCircleAvatar(),
            // SizeConfig.sH3,
            // UserNameContainer(),
          ],
        ),
      ),
    ));
  }
}

class Ritikraj extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 5.w,
          child: ImagesWidgets.userImage,
        ),
        SizeConfig.sW3,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdoroText(
              VariableUtils.ritiKraj,
              fontSize: 12.sp,
              fontWeight: FontWeightClass.fontWeightBold,
              color: blackWhite,
            ),
            AdoroText(
              VariableUtils.requestedTo,
              fontSize: 11.sp,
              color: ColorUtils.black92,
              fontWeight: FontWeightClass.fontWeightBold,
            ),
            AdoroText(
              VariableUtils.followYou,
              fontSize: 11.sp,
              color: ColorUtils.black92,
              fontWeight: FontWeightClass.fontWeightBold,
            ),
          ],
        ),
        SizeConfig.sW1,
        Padding(
          padding: EdgeInsets.only(top: 3.w),
          child: Container(
            height: 4.h,
            width: 23.w,
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
              borderRadius: BorderRadius.all(
                Radius.circular(2.w),
              ),
            ),
            child: Center(
              child: AdoroText(
                VariableUtils.Confirm,
                color: ColorUtils.white,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp,
              ),
            ),
          ),
        ),
        SizeConfig.sW1,
        Padding(
          padding: EdgeInsets.only(top: 3.w),
          child: Container(
            height: 4.h,
            width: 23.w,
            decoration: BoxDecoration(
              color: ColorUtils.black92,
              borderRadius: BorderRadius.all(
                Radius.circular(2.w),
              ),
            ),
            child: Center(
              child: AdoroText(
                VariableUtils.Delete,
                color: ColorUtils.white,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UserNameFollow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 6.w,
          child: ImagesWidgets.userImage,
        ),
        SizeConfig.sW3,
        AdoroText(
          VariableUtils.Username,
          fontSize: 12.sp,
          fontWeight: FontWeightClass.fontWeightBold,
          color: blackWhite,
        ),
        Spacer(),
        Container(
          height: 4.h,
          width: 23.w,
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
            borderRadius: BorderRadius.all(
              Radius.circular(2.w),
            ),
          ),
          child: Center(
            child: AdoroText(
              VariableUtils.Follow,
              color: ColorUtils.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class UserNameCircleAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 6.w,
          child: ImagesWidgets.userImage,
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: AdoroText(
            VariableUtils.Username,
            fontSize: 12.sp,
            fontWeight: FontWeightClass.fontWeightBold,
            color: blackWhite,
          ),
        ),
        Container(
          height: 4.h,
          width: 23.w,
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
            borderRadius: BorderRadius.all(
              Radius.circular(2.w),
            ),
          ),
          child: Center(
            child: AdoroText(
              VariableUtils.Follow,
              color: ColorUtils.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class UserNameContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 6.w,
          child: ImagesWidgets.userImage,
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: AdoroText(
            VariableUtils.Username,
            fontSize: 12.sp,
            fontWeight: FontWeightClass.fontWeightBold,
            color: blackWhite,
          ),
        ),
        Container(
          height: 4.h,
          width: 23.w,
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
            borderRadius: BorderRadius.all(
              Radius.circular(2.w),
            ),
          ),
          child: Center(
            child: AdoroText(
              VariableUtils.Follow,
              color: ColorUtils.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
            ),
          ),
        ),
      ],
    );
  }
}
