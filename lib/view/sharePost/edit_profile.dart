import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/color_utils.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/validation_utils.dart';
import '../../utils/variable_utils.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            SizeConfig.sH2,
            Padding(
              padding: EdgeInsets.only(right: 35.h),
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).textTheme.titleSmall?.color,
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
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, bottom: 5.w),
                    child: Image(
                        image: AssetImage("assets/images/profile.png"),
                        height: 13.h),
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
            Container(
              height: 50.h,
              width: 90.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.w),
                color: ColorUtils.greyFA,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    children: [
                      SizeConfig.sH2,
                      EditTextFormField(
                        hintText: "Full Name",
                        hintStyle: TextStyle(
                            color: ColorUtils.black92,
                            fontWeight: FontWeight.bold),
                      ),
                      SizeConfig.sH2,
                      EditTextFormField(
                        hintText: "Username",
                        hintStyle: TextStyle(
                            color: ColorUtils.black92,
                            fontWeight: FontWeight.bold),
                      ),
                      SizeConfig.sH2,
                      EditTextFormField(
                        hintText: "Mail id",
                        hintStyle: TextStyle(
                            color: ColorUtils.black92,
                            fontWeight: FontWeight.bold),
                      ),
                      SizeConfig.sH2,
                      EditTextFormField(
                        hintText: "Bank Name",
                        hintStyle: TextStyle(
                            color: ColorUtils.black92,
                            fontWeight: FontWeight.bold),
                      ),
                      SizeConfig.sH2,
                      EditTextFormField(
                        hintText: "Beneficiary Name",
                        hintStyle: TextStyle(
                            color: ColorUtils.black92,
                            fontWeight: FontWeight.bold),
                      ),
                      SizeConfig.sH2,
                      EditTextFormField(
                        hintText: "Account Number",
                        hintStyle: TextStyle(
                            color: ColorUtils.black92,
                            fontWeight: FontWeight.bold),
                      ),
                      SizeConfig.sH2,
                      EditTextFormField(
                        hintText: "IFSC Code",
                        hintStyle: TextStyle(
                            color: ColorUtils.black92,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
