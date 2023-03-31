import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/typedef_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/view/drawer/note.dart';
import 'package:socialv/view/drawer/notification.dart';
import 'package:socialv/view/drawer/referAndEarn.dart';
import 'package:socialv/view/drawer/result.dart';
import 'package:socialv/view/drawer/setting.dart';
import 'package:socialv/view/drawer/support.dart';
import 'package:socialv/view/drawer/template.dart';
import 'package:socialv/view/drawer/wallet.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () => Get.back(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).textTheme.titleSmall?.color,
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 10.w,
                  backgroundColor: Colors.grey[400],
                  backgroundImage: AssetImage("assets/icons/user1.png"),
                ),
                title: AdoroText(
                  "Deepanshu Sarmandal",
                  color: Theme.of(context).textTheme.titleSmall?.color,
                  fontWeight: FontWeightClass.fontWeight600,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: AdoroText(
                    "@deepanshu",
                    fontWeight: FontWeightClass.fontWeight500,
                  ),
                ),
              ),
              drawerData(
                onTap: () {
                  Get.to(() => NotificationScreen());
                },
                title: VariableUtils.notificationText,
                image: IconsWidgets.notificationImage,
              ),
              drawerData(
                onTap: () {
                  Get.to(() => Result());
                },
                title: VariableUtils.resultText,
                image: IconsWidgets.resultImage,
              ),
              drawerData(
                onTap: () {
                  Get.to(() => Note());
                },
                title: VariableUtils.noteFromAdoroText,
                image: IconsWidgets.noteImage,
              ),
              drawerData(
                onTap: () {
                  Get.to(() => Wallet());
                },
                title: VariableUtils.walletText,
                image: IconsWidgets.walletImage,
              ),
              drawerData(
                onTap: () {
                  Get.to(() => Template());
                },
                title: VariableUtils.templateText,
                image: IconsWidgets.templateImage,
              ),
              drawerData(
                onTap: () {
                  Get.to(() => ReferAndEarn());
                },
                title: VariableUtils.referEarnText,
                image: IconsWidgets.referImage,
              ),
              drawerData(
                onTap: () {
                  Get.to(() => Support());
                },
                title: VariableUtils.supportText,
                image: IconsWidgets.supportImage,
              ),
              drawerData(
                onTap: () {
                  // Get.to(() => Setting());
                },
                title: VariableUtils.settingsText,
                image: IconsWidgets.settingImage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerData({
    required OnTab onTap,
    required String image,
    required String title,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(3.w, 0.5.w, 3.w, 0),
      child: ListTile(
        leading: CommonImageWidth(
          img: image,
          width: 5.5.w,
          color: Theme.of(context).textTheme.titleMedium?.color,
        ),
        minLeadingWidth: 5.w,
        title: AdoroText(
          title,
          color: Theme.of(context).textTheme.titleSmall?.color,
          fontWeight: FontWeightClass.fontWeight600,
        ),
        onTap: onTap,
      ),
    );
  }
}
