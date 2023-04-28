// ignore_for_file: must_be_immutable, use_build_context_synchronously, deprecated_member_use
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/common_drawer.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/view/profile/profile1_screen.dart';
import 'package:socialv/commanWidget/noInternet_screen.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
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

  // List pageRoute = [Home(), SharePost(), Home(), ProfileScreen1()];

  @override
  void initState() {
    pageRoute = [
      Home(scaffoldKey: _scaffold),
      SharePost(),
      CampaignScreen(),
      ProfileScreen1()
    ];
    super.initState();
  }

  String bottomPath = "assets/bottombar/";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectivityViewModel>(
      init: ConnectivityViewModel(),
      builder: (connectivityViewModel) {
        if (connectivityViewModel.isOnline != null) {
          if (connectivityViewModel.isOnline!) {
            return GetBuilder<BottomBarController>(
              init: BottomBarController(),
              initState: (_) {},
              builder: (bottomBarController) {
                return Scaffold(
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
                            bottombarIcon(
                              index: 0,
                              img: bottomBarController.selectedIndex == 0
                                  ? '$bottomPath${PreferenceUtils.getString(key: 'mode')}_home_selected.png'
                                  : '$bottomPath${PreferenceUtils.getString(key: 'mode')}_home.png',
                              context: context,
                              controller: bottomBarController,
                            ),
                            // const Spacer(),
                            bottombarIcon(
                              index: 1,
                              context: context,
                              img:
                                  '$bottomPath${PreferenceUtils.getString(key: 'mode')}_share.png',
                              controller: bottomBarController,
                            ),
                            // const Spacer(),
                            bottombarIcon(
                              index: 2,
                              context: context,
                              controller: bottomBarController,
                              img: bottomBarController.selectedIndex == 2
                                  ? '$bottomPath${PreferenceUtils.getString(key: 'mode')}_campaign_selected.png'
                                  : '$bottomPath${PreferenceUtils.getString(key: 'mode')}_campaign.png',
                            ),
                            // const Spacer(),
                            bottombarIcon(
                              index: 3,
                              context: context,
                              img: bottomBarController.selectedIndex == 3
                                  ? '$bottomPath${PreferenceUtils.getString(key: 'mode')}_profile_selected.png'
                                  : '$bottomPath${PreferenceUtils.getString(key: 'mode')}_profile.png',
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

  Widget bottombarIcon({
    required int index,
    required String img,
    // required double scale,
    required BuildContext context,
    required BottomBarController controller,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (index == 1) {
            Get.to(
              () => SharePost(),
              duration: Duration(milliseconds: 500),
              transition: Transition.leftToRight,
            );
          } else {
            controller.pageChange(index);
          }
        },
        child: Image.asset(img, scale: 5.w),
      ),
    );
  }
}
