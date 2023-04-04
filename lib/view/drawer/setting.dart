import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';

class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key: key);

  SettingController settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.w),
        child: CommonAppBar(title: VariableUtils.settingsText),
      ),
      body: GetBuilder<SettingController>(builder: (settingController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AdoroText(
                    'Notifications',
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
                  const AdoroText(
                    'App Theme',
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
              const SizedBox(
                height: 10,
              ),
              const AdoroText(
                'Logout',
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        );
      }),
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
