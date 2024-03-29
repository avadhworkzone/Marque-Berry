import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';

/// DECORATION UTILS

class DecorationUtils {
  /// BOTTOM BAR DECORATION
  // static BoxDecoration bottomBarDecoration(BuildContext context) {
  //   return BoxDecoration(
  //     borderRadius: BorderRadius.only(
  //       topRight: Radius.circular(6.w),
  //       topLeft: Radius.circular(6.w),
  //     ),
  //     color: Theme.of(context).cardColor,
  //     boxShadow: const [
  //       BoxShadow(
  //         color: Colors.black38,
  //         spreadRadius: 0,
  //         blurRadius: 10,
  //       ),
  //     ],
  //   );
  // }

  static BoxDecoration buttonDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          ColorUtils.linearGradient7,
          ColorUtils.linearGradient4,
          ColorUtils.linearGradient5,
          ColorUtils.linearGradient8,
          // ColorUtils.linearGradient1,
          // ColorUtils.linearGradient2,
          // ColorUtils.linearGradient3,
          // ColorUtils.linearGradient4,
          // ColorUtils.linearGradient5,
          //  ColorUtils.linearGradient6,
          // ColorUtils.linearGradient7,
          // ColorUtils.linearGradient8,
        ],
        stops: [
          0.0,
          0.3,
          0.6,
          0.9,
        ],
        // stops: [0.0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(2.w),
    );
  }

  /// login Screen
  static BoxDecoration loginDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          ColorUtils.linearGradient7,
          ColorUtils.linearGradient4,
          ColorUtils.linearGradient5,
          ColorUtils.linearGradient8,
          // ColorUtils.linearGradient1,
          // ColorUtils.linearGradient2,
          // ColorUtils.linearGradient3,
          // ColorUtils.linearGradient4,
          // ColorUtils.linearGradient5,
          // ColorUtils.linearGradient6,
          // ColorUtils.linearGradient7,
        ],
        stops: [
          0.0,
          0.2,
          0.6,
          0.9,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(7.w),
        topRight: Radius.circular(7.w),
      ),
    );
  }

  ///  welcome Screen
  static BoxDecoration welcomeDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          ColorUtils.linearGradient7,
          ColorUtils.linearGradient4,
          ColorUtils.linearGradient5,
          ColorUtils.linearGradient8,
          // ColorUtils.linearGradient1,
          // ColorUtils.linearGradient2,
          // ColorUtils.linearGradient3,
          // ColorUtils.linearGradient4,
          // ColorUtils.linearGradient5,
          // ColorUtils.linearGradient6,
          // ColorUtils.linearGradient7,
        ],
        stops: [
          0.0,
          0.3,
          0.6,
          0.9,
        ],
        // stops: [0.0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(8.w),
      ),
    );
  }

  /// done Screen
  static BoxDecoration doneDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          ColorUtils.linearGradient7,
          ColorUtils.linearGradient4,
          ColorUtils.linearGradient5,
          ColorUtils.linearGradient8,
          // ColorUtils.linearGradient1,
          // ColorUtils.linearGradient2,
          // ColorUtils.linearGradient3,
          // ColorUtils.linearGradient4,
          // ColorUtils.linearGradient5,
          // ColorUtils.linearGradient6,
          // ColorUtils.linearGradient7,
        ],
        stops: [
          0.0,
          0.3,
          0.6,
          0.9,
        ],
        // stops: [0.0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shape: BoxShape.circle,
      // borderRadius: BorderRadius.circular(50.w),
    );
  }

  /// DIVIDER
  static Divider dividerLine1() {
    return const Divider(indent: 20, endIndent: 20);
  }

  static Divider dividerLine2({double? thickness}) {
    return Divider(
      thickness: thickness ?? 0.8,
      color: ColorUtils.greyF1,
    );
  }

  static BoxShadow boxShadow = BoxShadow(
    // color: ColorUtils.black26.withOpacity(0.2),
    blurRadius: 4.0,
    spreadRadius: 0.5,
    offset: const Offset(2.0, 2.0),
  );
}
