import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/variable_utils.dart';

import '../../commanWidget/noInternet_screen.dart';
import '../../utils/size_config_utils.dart';
import '../../viewModel/connectivity_view_model.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

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
            return SafeArea(
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(16.w),
                  child: CommonAppBar(
                    title: VariableUtils.notificationText,
                    ontap: () => Get.back(),
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 11,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 3.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AdoroText(
                                    "•",
                                    color: index == 0
                                        ? ColorUtils.grey
                                        : ColorUtils.result,
                                    fontSize: 20.sp,
                                  ),
                                  SizeConfig.sW5,
                                  const Expanded(
                                    child: AdoroText(
                                      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.',
                                      color: ColorUtils.black92,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
