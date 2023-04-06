import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/color_utils.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';

class TagAPeople extends StatelessWidget {
  TagAPeople({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).textTheme.titleSmall?.color,
                  ),
                  SizeConfig.sW18,
                  AdoroText(VariableUtils.tagfriends,
                      color: Theme.of(context).textTheme.titleSmall?.color,
                      fontSize: 15.sp,
                      fontWeight: FontWeightClass.fontWeight600),
                ],
              ),
              SizeConfig.sH5,
              CommonTextFieldContainer(
                controller: search,
                textAlignVertical: TextAlignVertical.center,
                hintText: "Search ...",
                hintStyle:
                    TextStyle(color: ColorUtils.black92, fontSize: 15.sp),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20.sp,
                  color: ColorUtils.black92,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var search = TextEditingController();
}
