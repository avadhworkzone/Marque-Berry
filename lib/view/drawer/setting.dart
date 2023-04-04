import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
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
              appBar: customAppbar(VariableUtils.settingsText),
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
                          Switch(
                            value: settingController.isthemetap,
                            onChanged: (value) {
                              settingController.themeTap(value);
                            },
                          )
                        ],
                      ),
                      SizeConfig.sH1,
                      AdoroText(
                        VariableUtils.logout,
                        color: Theme.of(context).textTheme.titleSmall?.color,
                        fontWeight: FontWeight.bold,
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

  themeTap(val) {
    isthemetap = val;
    update();
  }

  notificationTap(val) {
    isnotificationtap = val;
    update();
  }
}
