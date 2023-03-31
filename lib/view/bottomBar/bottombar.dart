// ignore_for_file: must_be_immutable, use_build_context_synchronously, deprecated_member_use
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/view/profile/profile.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/commanWidget/noInternet_screen.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/viewModel/connectivity_view_model.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  List pageRoute = [Home(), Home(), Home(), const Profile()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ConnectivityViewModel>(
        init: ConnectivityViewModel(),
        builder: (connectivityViewModel) {
          if (connectivityViewModel.isOnline != null) {
            if (connectivityViewModel.isOnline!) {
              return GetBuilder<BottomBarController>(
                init: BottomBarController(),
                initState: (_) {},
                builder: (controller) {
                  return Scaffold(
                    body: pageRoute[controller.selectedIndex],
                    bottomNavigationBar: Container(
                      height: 16.w,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: ColorUtils.black2E.withOpacity(0.2),
                            blurRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => controller.pageChange(0),
                                child: IconsWidgets.homeImages,
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => controller.pageChange(1),
                                child: IconsWidgets.plusCircleImages,
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => controller.pageChange(2),
                                child: IconsWidgets.medalLightImages,
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => controller.pageChange(3),
                                child: IconsWidgets.userImages,
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
      ),
    );
  }
}
