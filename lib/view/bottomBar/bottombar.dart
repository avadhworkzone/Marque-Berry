// ignore_for_file: must_be_immutable, use_build_context_synchronously, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/appService/dynamic_link.dart';
import 'package:socialv/appService/notification_service.dart';
import 'package:socialv/commanWidget/common_drawer.dart';
import 'package:socialv/commanWidget/noInternet_screen.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/home/components/video_components.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/view/profile/profile.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import 'package:socialv/viewModel/connectivity_view_model.dart';

import '../drawer/campaign_screen.dart';
import '../sharePost/share_post.dart';

class BottomBar extends StatefulWidget {
  BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  late List pageRoute;
  AuthViewModel authViewModel = Get.find<AuthViewModel>();
  HomeController homeController = Get.find<HomeController>();

  // List pageRoute = [Home(), SharePost(), Home(), ProfileScreen1()];

  @override
  void initState() {
    getCategories();
    pageRoute = [
      Home(scaffoldKey: _scaffold),
      SharePost(),
      CampaignScreen(),
      Profile(
        userId: PreferenceUtils.getInt(key: PreferenceUtils.userid),
        fromBottomScreen: true,
      )
    ];
    super.initState();
  }

  void getCategories() {
    authViewModel.memeCategory();
  }

  String bottomPath = "assets/bottombar/";

  /// --------------------------- NOTIFICATION INITIALISE -------------------------- ///
  void notificationInitialization() {
    NotificationService.notificationPermission();
    NotificationService.inItNotification();
    NotificationService.onNotification();
  }

  @override
  Widget build(BuildContext context) {
    String themeType = PreferenceUtils.getString(key: PreferenceUtils.mode);
    print('themeType:=>$themeType');
    if (themeType.isEmpty) {
      themeType = 'light';
    }
    print('AFTER themeType:=>$themeType');
    DynamicLink.listenDynamicLinks();
    return GetBuilder<ConnectivityViewModel>(
      init: ConnectivityViewModel(),
      builder: (connectivityViewModel) {
        if (connectivityViewModel.isOnline != null) {
          if (connectivityViewModel.isOnline!) {
            return GetBuilder<BottomBarController>(
              init: BottomBarController(),
              initState: (_) {
                notificationInitialization();
              },
              builder: (bottomBarController) {
                return Scaffold(
                  backgroundColor: Theme.of(context).cardColor,
                  key: _scaffold,
                  body: pageRoute[bottomBarController.selectedIndex],
                  drawer: bottomBarController.selectedIndex == 0
                      ? MyDrawer()
                      : null,
                  bottomNavigationBar: Container(
                    height: 16.w,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtils.black.withOpacity(0.5),
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Row(
                          children: [
                            bottomBarIcon(
                              index: 0,
                              img: bottomBarController.selectedIndex == 0
                                  ? '$bottomPath${themeType}_home_selected.png'
                                  : '$bottomPath${themeType}_home.png',
                              context: context,
                              controller: bottomBarController,
                            ),
                            // const Spacer(),
                            bottomBarIcon(
                              index: 1,
                              context: context,
                              img: '$bottomPath${themeType}_share.png',
                              controller: bottomBarController,
                            ),
                            // const Spacer(),
                            bottomBarIcon(
                              index: 2,
                              context: context,
                              controller: bottomBarController,
                              img: bottomBarController.selectedIndex == 2
                                  ? '$bottomPath${themeType}_campaign_selected.png'
                                  : '$bottomPath${themeType}_campaign.png',
                            ),
                            // const Spacer(),
                            bottomBarIcon(
                              index: 3,
                              context: context,
                              img: bottomBarController.selectedIndex == 3
                                  ? '$bottomPath${themeType}_profile_selected.png'
                                  : '$bottomPath${themeType}_profile.png',
                              controller: bottomBarController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
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

  Widget bottomBarIcon({
    required int index,
    required String img,
    // required double scale,
    required BuildContext context,
    required BottomBarController controller,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          if (index == 0) {
            int playedIndex = -1;
            playedIndex = ConstUtils.videoControllerList.values
                .toList()
                .indexWhere((element) => element.value.isPlaying);
            if (playedIndex > -1) {
              ConstUtils.videoControllerList.values
                  .toList()[playedIndex]
                  .pause();
            }
            ConstUtils.videoControllerList.clear();
            controller.pageChange(index);
            homeController.animateFeedScroll(0);
          } else if (index == 1) {
            int playedIndex = -1;
            playedIndex = ConstUtils.videoControllerList.values
                .toList()
                .indexWhere((element) => element.value.isPlaying);
            if (playedIndex > -1) {
              ConstUtils.videoControllerList.values
                  .toList()[playedIndex]
                  .pause();
            }
            await Get.to(
              () => SharePost(),
            );
            if (playedIndex > -1) {
              ConstUtils.videoControllerList.values
                  .toList()[playedIndex]
                  .play();
            }
          } else {
            int playedIndex = -1;
            playedIndex = ConstUtils.videoControllerList.values
                .toList()
                .indexWhere((element) => element.value.isPlaying);
            if (playedIndex > -1) {
              ConstUtils.videoControllerList.values
                  .toList()[playedIndex]
                  .pause();
            }
            ConstUtils.videoControllerList.values.toList().forEach((element) {
              element.dispose();
            });
            controller.pageChange(index);
          }
        },
        child: Image.asset(img, scale: index == 0 ? 5.5.w : 5.w),
      ),
    );
  }
}
