// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/auth/login_screen.dart';

import '../../commanWidget/noInternet_screen.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';
import '../../viewModel/connectivity_view_model.dart';

class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key: key);

  SettingController settingController = Get.find<SettingController>();
  ConnectivityViewModel connectivityViewModel =
      Get.find<ConnectivityViewModel>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectivityViewModel>(
      init: ConnectivityViewModel(),
      initState: (_) {
        connectivityViewModel.startMonitoring();
      },
      builder: (connectivityViewModel) {
        if (connectivityViewModel.isOnline != null) {
          if (connectivityViewModel.isOnline!) {
            return Scaffold(
              appBar: customAppbar(
                context: context,
                title: VariableUtils.settingsText,
              ),
              body: GetBuilder<SettingController>(builder: (settingController) {
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
                              color:
                                  Theme.of(context).textTheme.titleSmall?.color,
                              fontWeight: FontWeight.bold,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25.w),
                              child: InkWell(
                                splashColor: ColorUtils.transparent,
                                highlightColor: ColorUtils.transparent,
                                onTap: () {
                                  settingController.notificationTap();
                                },
                                child: Container(
                                  height: 7.3.w,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorUtils.linearGradient1,
                                        ColorUtils.linearGradient6,
                                        ColorUtils.linearGradient7
                                      ],
                                      begin: Alignment(-1.0, -0.4),
                                      end: Alignment(0.8, 1.0),
                                      // stops: [0.1, 0.6, 0.7],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        settingController.isNotificationTap ==
                                                true
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.5.w),
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
                              color:
                                  Theme.of(context).textTheme.titleSmall?.color,
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
                                      ColorUtils.linearGradient1,
                                      ColorUtils.linearGradient6,
                                      ColorUtils.linearGradient7
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
                      SizeConfig.sH2,
                      InkWell(
                        onTap: () async {
                          await PreferenceUtils.setInt(
                            key: PreferenceUtils.login,
                            value: 0,
                          );

                          await PreferenceUtils.setCategory([]);
                          // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTMsImlhdCI6MTY4MjY2MTM0OCwiZXhwIjoxNjgzNTI1MzQ4fQ.3-t01FgVF4oat6okVX4LbqlLUkKQYLVq6Xmv2ZMn73U
                          await PreferenceUtils.setWelcome(0);
                          Get.offAll(() => LoginScreen());
                        },
                        child: AdoroText(
                          VariableUtils.logout,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.titleSmall?.color,
                        ),
                      )
                    ],
                  ),
                );
              }),
            );
          } else {
            return const NoInterNetConnected();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class SettingController extends GetxController {
  bool isNotificationTap = PreferenceUtils.getBool(
            key: PreferenceUtils.notification,
          ) ==
          false
      ? false
      : true;

  String isThemeTap = PreferenceUtils.getString(
            key: PreferenceUtils.mode,
          ) ==
          ""
      ? "light"
      : PreferenceUtils.getString(
          key: PreferenceUtils.mode,
        );

  void themeTap() async {
    isThemeTap = isThemeTap == "dark" ? "light" : "dark";

    await PreferenceUtils.setInt(
      key: PreferenceUtils.system,
      value: 1,
    );
    await PreferenceUtils.setString(
      key: PreferenceUtils.mode,
      value: isThemeTap == "light" ? "dark" : "light",
    );

    isLightTheme.add(isThemeTap == "light" ? true : false);
    // if (isThemeTap == "light") {
    //   isLightTheme.add(true);
    // } else {
    //   isLightTheme.add(false);
    // }

    update();
  }

  notificationTap() {
    isNotificationTap = !isNotificationTap;
    PreferenceUtils.setBool(
      key: PreferenceUtils.notification,
      value: isNotificationTap,
    );
    update();
  }
}
