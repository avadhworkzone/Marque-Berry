import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';

import '../../commanWidget/noInternet_screen.dart';
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AdoroText(
                            VariableUtils.notifications,
                            color:
                                Theme.of(context).textTheme.titleSmall?.color,
                            fontWeight: FontWeight.bold,
                          ),
                          Switch(
                            value: settingController.isnotificationtap,
                            onChanged: (value) {
                              settingController.notificationTap(value);
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AdoroText(
                            VariableUtils.appTheme,
                            color:
                                Theme.of(context).textTheme.titleSmall?.color,
                            fontWeight: FontWeight.bold,
                          ),
                          // Container(
                          //   height: 6.w,
                          //   width: 14.w,
                          //   child: AnimatedToggleSwitch<bool>.rolling(
                          //     onTap: () {
                          //       settingController.themeTap();
                          //     },
                          //     current: settingController.isthemetap,
                          //     borderWidth: 0.2,
                          //     values: const [false, true],
                          //     onChanged: (i) {},
                          //     iconRadius: 5.0,
                          //     indicatorSize: Size(7.w, 7.w),
                          //     indicatorBorderRadius:
                          //         BorderRadius.circular(10.w),
                          //     // indicatorColor: Colors.red,
                          //     innerColor: settingController.isthemetap == true
                          //         ? Colors.orange
                          //         : ColorUtils.green4E,
                          //     borderColor: Colors.transparent,
                          //   ),
                          // ),
                          Switch(
                            value: settingController.isthemetap,
                            onChanged: (value) {
                              isLightTheme.add(value);
                              settingController.themeTap();
                            },
                          )
                        ],
                      ),
                      SizeConfig.sH1,
                      AdoroText(
                        VariableUtils.logout,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleSmall?.color,
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
  bool isnotificationtap = false;
  bool isthemetap = false;

  themeTap() async {
    isLightTheme.add(isthemetap);
    isthemetap = !isthemetap;

    await PreferenceUtils.setInt(
      key: PreferenceUtils.system,
      value: 1,
    );
    await PreferenceUtils.setString(
      key: PreferenceUtils.mode,
      value: isthemetap == true ? "dark" : "light",
    );
    update();
  }

  notificationTap(val) {
    isnotificationtap = val;
    update();
  }
}
