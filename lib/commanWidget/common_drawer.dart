import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/typedef_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/view/drawer/note.dart';
import 'package:socialv/view/drawer/notification.dart';
import 'package:socialv/view/drawer/referAndEarn.dart';
import 'package:socialv/view/drawer/result.dart';
import 'package:socialv/view/drawer/setting.dart';
import 'package:socialv/view/drawer/support.dart';
import 'package:socialv/view/drawer/template.dart';
import 'package:socialv/view/drawer/wallet.dart';

import '../utils/app_services/common_profile_image.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  final BottomBarController bottomBar = Get.find<BottomBarController>();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? subTitleColor = Theme.of(context).textTheme.titleMedium?.color;

    return SafeArea(
      child: Drawer(
        backgroundColor: whiteBlack2E,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                splashRadius: 7.w,
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: blackWhite,
                ),
              ),
              ListTile(
                splashColor: ColorUtils.transparent,
                onTap: () {
                  int playedIndex = -1;
                  playedIndex = ConstUtils.videoControllerList.values
                      .toList()
                      .indexWhere((element) => element.value.isPlaying);
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .pause();
                  }
                  Get.back();
                  bottomBar.pageChange(3);
                },
                leading: CommonProfileImage(
                  heightWidth: 16.w,
                  bgColor: Colors.grey[200],
                  image: PreferenceUtils.getString(
                    key: PreferenceUtils.profileImage,
                  ),
                ),
                title: AdoroText(
                  PreferenceUtils.getString(key: PreferenceUtils.fullname),
                  color: blackWhite,
                  fontWeight: FontWeightClass.fontWeight600,
                  fontSize: 16.sp,
                ),
                subtitle:
                    PreferenceUtils.getString(key: PreferenceUtils.username) !=
                            ""
                        ? Padding(
                            padding: EdgeInsets.only(top: 1.w),
                            child: AdoroText(
                              '@${PreferenceUtils.getString(key: PreferenceUtils.username)}',
                              fontWeight: FontWeightClass.fontWeight500,
                              color: subTitleColor,
                            ),
                          )
                        : SizedBox(),
              ),
              SizeConfig.sH2,
              drawerListTile(
                onTap: () async {
                  int playedIndex = -1;
                  playedIndex = ConstUtils.videoControllerList.values
                      .toList()
                      .indexWhere((element) => element.value.isPlaying);
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .pause();
                  }
                  Get.back();
                  await Get.to(() => NotificationScreen());
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .play();
                  }
                },
                context: context,
                title: VariableUtils.notificationText,
                image: IconsWidgets.notificationImage,
              ),
              drawerListTile(
                onTap: () async {
                  int playedIndex = -1;
                  playedIndex = ConstUtils.videoControllerList.values
                      .toList()
                      .indexWhere((element) => element.value.isPlaying);
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .pause();
                  }
                  Get.back();
                  await Get.to(() => Result());
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .play();
                  }
                },
                context: context,
                title: VariableUtils.resultText,
                image: IconsWidgets.resultImage,
              ),
              drawerListTile(
                onTap: () async {
                  int playedIndex = -1;
                  playedIndex = ConstUtils.videoControllerList.values
                      .toList()
                      .indexWhere((element) => element.value.isPlaying);
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .pause();
                  }
                  Get.back();
                  await Get.to(() => Note());
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .play();
                  }
                },
                context: context,
                title: VariableUtils.noteFromAdoroText,
                image: IconsWidgets.noteImage,
              ),
              drawerListTile(
                onTap: () async {
                  int playedIndex = -1;
                  playedIndex = ConstUtils.videoControllerList.values
                      .toList()
                      .indexWhere((element) => element.value.isPlaying);
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .pause();
                  }
                  Get.back();
                  await Get.to(() => Wallet());
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .play();
                  }
                },
                context: context,
                title: VariableUtils.walletText,
                image: IconsWidgets.walletImage,
              ),
              drawerListTile(
                onTap: () async {
                  int playedIndex = -1;
                  playedIndex = ConstUtils.videoControllerList.values
                      .toList()
                      .indexWhere((element) => element.value.isPlaying);
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .pause();
                  }
                  Get.back();
                  await Get.to(() => Template());
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .play();
                  }
                },
                context: context,
                title: VariableUtils.templateText,
                image: IconsWidgets.templateImage,
              ),
              drawerListTile(
                onTap: () async {
                  int playedIndex = -1;
                  playedIndex = ConstUtils.videoControllerList.values
                      .toList()
                      .indexWhere((element) => element.value.isPlaying);
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .pause();
                  }
                  Get.back();
                  await Get.to(() => ReferAndEarn());
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .play();
                  }
                },
                context: context,
                title: VariableUtils.referEarnText,
                image: IconsWidgets.referImage,
              ),
              drawerListTile(
                onTap: () async {
                  int playedIndex = -1;
                  playedIndex = ConstUtils.videoControllerList.values
                      .toList()
                      .indexWhere((element) => element.value.isPlaying);
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .pause();
                  }
                  Get.back();
                  await Get.to(() => Support());
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .play();
                  }
                },
                context: context,
                title: VariableUtils.supportText,
                image: IconsWidgets.supportImage,
              ),
              drawerListTile(
                onTap: () async {
                  int playedIndex = -1;
                  playedIndex = ConstUtils.videoControllerList.values
                      .toList()
                      .indexWhere((element) => element.value.isPlaying);
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .pause();
                  }
                  Get.back();
                  await Get.to(() => Setting());
                  if (playedIndex > -1) {
                    ConstUtils.videoControllerList.values
                        .toList()[playedIndex]
                        .play();
                  }
                },
                context: context,
                title: VariableUtils.settingsText,
                image: IconsWidgets.settingImage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerListTile({
    required BuildContext context,
    required OnTab onTap,
    required String image,
    required String title,
  }) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? iconColor = Theme.of(context).textTheme.titleMedium?.color;
    return Padding(
      padding: EdgeInsets.fromLTRB(3.w, 0.5.w, 3.w, 0),
      child: ListTile(
        leading: CommonImageWidth(
          img: image,
          width: 5.5.w,
          color: iconColor,
        ),
        minLeadingWidth: 5.w,
        title: AdoroText(
          title,
          color: blackWhite,
          fontWeight: FontWeightClass.fontWeight600,
        ),
        onTap: onTap,
      ),
    );
  }
}
