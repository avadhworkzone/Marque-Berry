import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';
import '../../utils/variable_utils.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/size_config_utils.dart';
import '../auth/components/edit_component.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizeConfig.sH2,
              Padding(
                padding: EdgeInsets.only(right: 35.h),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).textTheme.titleSmall?.color,
                  ),
                ),
              ),
              SizeConfig.sH4,
              Container(
                height: 25.h,
                width: double.maxFinite,
                decoration: DecorationUtils.buttonDecoration(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 5.w),
                          child: Image(
                              image: AssetImage("assets/images/profile.png"),
                              height: 13.h),
                        ),
                        Positioned(
                            left: 27.w,
                            top: 14.w,
                            child: Container(
                              height: 4.h,
                              width: 8.w,
                              decoration:
                                  DecorationUtils.doneDecoration(context),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon:
                                      Icon(Icons.edit, color: ColorUtils.white),
                                ),
                              ),
                            )),
                      ],
                    ),
                    Container(
                      height: 6.h,
                      width: 50.w,
                      decoration: DecorationUtils.welcomeDecoration(context),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(VariableUtils.updateProfile,
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              SizeConfig.sH4,
              EditComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
