import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class ReplayButton extends StatelessWidget {
  int replaycount = 0;
  ReplayButton({Key? key, required this.replaycount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.5.w,
          vertical: 2.7.w,
        ),
        child: replaycount == 0
            ? AdoroText("REPLY", color: ColorUtils.black92)
            : AdoroText("$replaycount REPLY", color: ColorUtils.black92),
      ),
    );
  }
}
