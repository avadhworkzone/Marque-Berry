import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

// class CommonAppBar extends StatelessWidget {
//   var title;
//   CommonAppBar({Key? key, this.title}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
//
//     return AppBar(
//       centerTitle: true,
//       elevation: 0,
//       backgroundColor: ColorUtils.greyFA,
//       leading: IconButton(
//         onPressed: () => Get.back(),
//         icon: Icon(Icons.arrow_back, color: blackWhite),
//       ),
//       title: AdoroText(
//         title,
//         fontSize: 12.sp,
//         color: blackWhite,
//       ),
//     );
//   }
// }

AppBar customAppbar(final String title) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: ColorUtils.greyFA,
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.arrow_back, color: ColorUtils.black2E),
    ),
    title: AdoroText(title, fontSize: 13.sp, color: ColorUtils.black2E),
  );
}
