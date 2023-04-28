// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:socialv/controllers/bottomBar_controller.dart';
//
// import '../../commanWidget/custom_btn.dart';
// import '../../utils/assets/images_utils.dart';
// import '../../utils/decoration_utils.dart';
// import '../../utils/size_config_utils.dart';
// import '../bottomBar/bottombar.dart';
//
// class CampaignDoneScreen extends StatelessWidget {
//   CampaignDoneScreen({super.key});
//
//   final BottomBarController bottomBarController =
//       Get.find<BottomBarController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 25.h,
//             width: 50.w,
//             decoration: DecorationUtils.doneDecoration(context),
//             child: ImagesWidgets.verifiedImage,
//           ),
//           SizeConfig.sH10,
//           CustomBtn(
//             onTap: () {
//               Get.offAll(() => BottomBar());
//               bottomBarController.pageChange(0);
//             },
//             text: 'DONE',
//           ),
//         ],
//       ),
//     );
//   }
// }
