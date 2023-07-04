// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/auth/login_screen.dart';
import 'package:socialv/viewModel/setting_viewmodel.dart';

import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';

class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key: key);

  SettingViewModel settingController = Get.find<SettingViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: customAppbar(
        context: context,
        title: VariableUtils.settingsText,
      ),
      body: GetBuilder<SettingViewModel>(builder: (settingController) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AdoroText(
                      VariableUtils.notifications,
                      color: Theme.of(context).textTheme.titleSmall?.color,
                      fontWeight: FontWeight.bold,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.w),
                      child: InkWell(
                        splashColor: ColorUtils.transparent,
                        highlightColor: ColorUtils.transparent,
                        onTap: () {
                          settingController.isNotification =
                              !settingController.isNotification;
                          settingController.changeNotificationStatus();
                        },
                        child: Container(
                          height: 7.3.w,
                          width: 15.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorUtils.linearGradient7,
                                ColorUtils.linearGradient4,
                                ColorUtils.linearGradient5,
                                ColorUtils.linearGradient8,
                              ],
                              begin: Alignment(-1.0, -0.4),
                              end: Alignment(0.8, 1.0),
                              // stops: [0.1, 0.6, 0.7],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                settingController.isNotification == true
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.5.w),
                                child: Container(
                                  width: 5.5.w,
                                  height: 7.5.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AdoroText(
                      VariableUtils.appTheme,
                      color: Theme.of(context).textTheme.titleSmall?.color,
                      fontWeight: FontWeight.bold,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.w),
                      child: Container(
                        height: 7.3.w,
                        width: 15.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorUtils.linearGradient7,
                              ColorUtils.linearGradient4,
                              ColorUtils.linearGradient5,
                              ColorUtils.linearGradient8,
                            ],
                            begin: Alignment(-1.0, -0.4),
                            end: Alignment(0.8, 1.0),
                            // stops: [0.1, 0.6, 0.7],
                          ),
                        ),
                        child: InkWell(
                          splashColor: ColorUtils.transparent,
                          highlightColor: ColorUtils.transparent,
                          onTap: () {
                            settingController.themeTap();
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 1.5.w),
                                child: Container(
                                  width: 5.w,
                                  height: 7.w,
                                  decoration: BoxDecoration(
                                    color: PreferenceUtils.getString(
                                                key: 'mode') ==
                                            "light"
                                        ? Colors.white
                                        : ColorUtils.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(0.8.w),
                                    child: Image.asset(
                                      IconsWidgets.lightImages,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 1.5.w),
                                child: Container(
                                  width: 5.w,
                                  height: 7.w,
                                  decoration: BoxDecoration(
                                    color: PreferenceUtils.getString(
                                                key: 'mode') ==
                                            "dark"
                                        ? ColorUtils.white
                                        : ColorUtils.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(0.8.w),
                                    child: Image.asset(
                                      IconsWidgets.darkImages,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizeConfig.sH2,
              InkWell(
                onTap: () async {
                  await PreferenceUtils.setInt(
                    key: PreferenceUtils.login,
                    value: 0,
                  );

                  await PreferenceUtils.setCategory([]);
                  // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTMsImlhdCI6MTY4MjY2MTM0OCwiZXhwIjoxNjgzNTI1MzQ4fQ.3-t01FgVF4oat6okVX4LbqlLUkKQYLVq6Xmv2ZMn73U
                  await PreferenceUtils.setWelcome(0);
                  showSnackBar(
                      message: VariableUtils.youHaveSuccessfullyLogout);
                  Get.offAll(() => LoginScreen());
                },
                child: SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: AdoroText(
                      VariableUtils.logout,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleSmall?.color,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
