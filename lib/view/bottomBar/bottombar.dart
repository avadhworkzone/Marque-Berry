// ignore_for_file: must_be_immutable, use_build_context_synchronously, deprecated_member_use
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/common_drawer.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
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
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Row(
                          children: [
                            bottombarIcon(
                              index: 0,
                              img: bottomBarController.selectedIndex == 0
                                  ? IconsWidgets.selectHomeImage
                                  : IconsWidgets.homeImages,
                              scale: bottomBarController.selectedIndex == 0
                                  ? 5.2.w
                                  : 1.w,
                              context: context,
                              controller: bottomBarController,
                            ),
                            const Spacer(),
                            bottombarIcon(
                              index: 1,
                              scale: 1.w,
                              context: context,
                              img: IconsWidgets.plusCircleImages,
                              controller: bottomBarController,
                            ),
                            const Spacer(),
                            bottombarIcon(
                              index: 2,
                              // scale: 1.w,
                              context: context,
                              controller: bottomBarController,
                              img: bottomBarController.selectedIndex == 2
                                  ? IconsWidgets.selectMedalLightImage
                                  : IconsWidgets.medalLightImages,
                              scale: bottomBarController.selectedIndex == 2
                                  ? 4.5.w
                                  : 1.w,
                            ),
                            const Spacer(),
                            bottombarIcon(
                              index: 3,
                              // scale: 1.w,
                              context: context,
                              img: bottomBarController.selectedIndex == 3
                                  ? IconsWidgets.selectUserImage
                                  : IconsWidgets.userImages,
                              scale: bottomBarController.selectedIndex == 3
                                  ? 5.5.w
                                  : 1.w,

                              controller: bottomBarController,
                            ),
                            // InkWell(
                            //   onTap: () => bottomBarController.pageChange(1),
                            //   child: CommonImageScale(
                            //     img: IconsWidgets.plusCircleImages,
                            //     scale: 1.w,
                            //     color: Theme.of(context)
                            //         .textTheme
                            //         .titleSmall!
                            //         .color,
                            //   ),
                            // ),
                            // const Spacer(),
                            // InkWell(
                            //   onTap: () => bottomBarController.pageChange(2),
                            //   child: CommonImageScale(
                            //     img: IconsWidgets.medalLightImages,
                            //     scale: 1.w,
                            //     color: Theme.of(context)
                            //         .textTheme
                            //         .titleSmall!
                            //         .color,
                            //   ),
                            // ),
                            // const Spacer(),
                            // InkWell(
                            //   onTap: () => bottomBarController.pageChange(3),
                            //   child: CommonImageScale(
                            //     img: IconsWidgets.userImages,
                            //     scale: 1.w,
                            //     color: Theme.of(context)
                            //         .textTheme
                            //         .titleSmall!
                            //         .color,
                            //   ),
                            // ),
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
    required double scale,
    required BuildContext context,
    required BottomBarController controller,
  }) {
    return InkWell(
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
      child: CommonImageScale(
        img: img,
        scale: scale,
        // color: controller.selectedIndex == index
        //     ? Theme.of(context).buttonColor
        //     : Colors.grey,
      ),
    );
  }
}
