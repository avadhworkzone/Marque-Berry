import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/get_follower_list_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';

import '../../commanWidget/common_image.dart';
import '../../utils/assets/images_utils.dart';

class FollowerFollowing extends StatelessWidget {
  int followingCounter;

  String title;

  FollowerFollowing({
    Key? key,
    required this.followingCounter,
    required this.title,
  }) : super(key: key);

  FollowerFollowingController followerFollowingController =
      Get.find<FollowerFollowingController>();

  FollowRequestViewModel followRequestViewModel =
      Get.find<FollowRequestViewModel>();

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    return Scaffold(
      appBar: customAppbar(
        context: context,
        title: title,
        icon: Icon(
          Icons.search_rounded,
          color: blackWhite,
        ),
      ),
      body: GetBuilder<FollowRequestViewModel>(
        builder: (followRequestViewModel) {
          return GetBuilder<FollowerFollowingController>(
            initState: (_) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                followerFollowingController.changeTabIndex(followingCounter);
                await followRequestViewModel.getFollowerList();

                await followRequestViewModel.getFollowingList();
              });
            },
            builder: (followerFollowingController) {
              return SizedBox(
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    FollowTabBar(
                      followerFollowingController: followerFollowingController,
                    ),
                    Positioned(
                      // top: 15.w,
                      bottom: 0,
                      child: Container(
                        height: Get.height - 22.w - 80,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.w),
                                topLeft: Radius.circular(8.w)),
                            color: whiteBlack2E),
                        child: followerFollowingController.currentTabIndex == 0
                            ? FollowingList(
                                followRequestViewModel: followRequestViewModel,
                              )
                            : FollowerList(
                                followRequestViewModel: followRequestViewModel,
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FollowTabBar extends StatelessWidget {
  FollowerFollowingController followerFollowingController;

  FollowTabBar({super.key, required this.followerFollowingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 22.w,
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorUtils.linearGradient1,
            ColorUtils.linearGradient6,
            ColorUtils.linearGradient7
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.w),
          topRight: Radius.circular(5.w),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: Get.width / 2,
            child: Center(
              child: InkWell(
                onTap: () {
                  followerFollowingController.changeTabIndex(0);
                },
                child: AdoroText(
                  "FOLLOWINNG",
                  fontSize: 11.sp,
                  color: followerFollowingController.currentTabIndex == 0
                      ? ColorUtils.white
                      : Color(0xFF8BAFE7),
                  fontWeight: FontWeightClass.fontWeight600,
                ),
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: Get.width / 2,
            child: Center(
              child: InkWell(
                onTap: () {
                  followerFollowingController.changeTabIndex(1);
                },
                child: AdoroText(
                  "FOLLOWERS",
                  fontSize: 11.sp,
                  color: followerFollowingController.currentTabIndex == 0
                      ? Color(0xFF8BAFE7)
                      : ColorUtils.white,
                  fontWeight: FontWeightClass.fontWeight600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FollowerList extends StatelessWidget {
  FollowRequestViewModel followRequestViewModel;

  FollowerList({super.key, required this.followRequestViewModel});

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    if (followRequestViewModel.getFollowerListApiResponse.status ==
            Status.LOADING ||
        followRequestViewModel.getFollowerListApiResponse.status ==
            Status.INITIAL) {
      return Center(child: Loader());
    } else if (followRequestViewModel.getFollowerListApiResponse.status ==
        Status.ERROR) {
      return Center(child: SomethingWentWrong());
    } else {
      GetFollowerListResModel getFollowerListResModel =
          followRequestViewModel.getFollowerListApiResponse.data;

      if (getFollowerListResModel.status.toString() ==
          VariableUtils.status500) {
        return Center(
          child: AdoroText(
            getFollowerListResModel.msg ?? VariableUtils.somethingWentWrong,
          ),
        );
      }

      if (getFollowerListResModel.data!.isEmpty) {
        return Center(
          child: AdoroText("No follower", color: blackWhite),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.only(bottom: 40.w),
        itemCount: getFollowerListResModel.data?.length,
        itemBuilder: (context, index) {
          final followingData = getFollowerListResModel.data?[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    followingData?.username ?? "",
                    style: TextStyle(color: blackWhite),
                  ),
                  // subtitle: Text(
                  //   followingData?.status ?? "",
                  //   style: TextStyle(color: blackWhite),
                  // ),
                  subtitle: AdoroText(followingData?.fullName ?? "",
                      color: blackWhite),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10.w),
                    child: Container(
                      height: 10.w,
                      width: 10.w,
                      color: ColorUtils.greyFA,
                      child: OctoImage(
                        fit: BoxFit.cover,
                        width: 24,
                        height: 24,
                        image: NetworkImage(followingData?.image ?? ""),
                        progressIndicatorBuilder: (context, progress) {
                          double? value;
                          var expectedBytes = progress?.expectedTotalBytes;
                          if (progress != null && expectedBytes != null) {
                            value =
                                progress.cumulativeBytesLoaded / expectedBytes;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: value,
                              color: blackWhite,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stacktrace) => Container(
                          width: 24,
                          height: 24,
                          color: ColorUtils.grey[200],
                          child: Padding(
                            padding: EdgeInsets.all(1.w),
                            child: CommonImage(
                              img: IconsWidgets.userImages,
                              color: ColorUtils.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.more_vert,
                    color: ColorUtils.black92,
                  ),
                  contentPadding: EdgeInsets.all(0.w),
                ),
                DecorationUtils.dividerLine2(),
              ],
            ),
          );
        },
      );
    }
  }
}

//

class FollowingList extends StatelessWidget {
  FollowRequestViewModel followRequestViewModel;

  FollowingList({super.key, required this.followRequestViewModel});

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;
    if (followRequestViewModel.getFollowerListApiResponse.status ==
            Status.LOADING ||
        followRequestViewModel.getFollowerListApiResponse.status ==
            Status.INITIAL) {
      return Center(child: Loader());
    } else if (followRequestViewModel.getFollowerListApiResponse.status ==
        Status.ERROR) {
      return Center(child: SomethingWentWrong());
    } else {
      GetFollowerListResModel getFollowerListResModel =
          followRequestViewModel.getFollowerListApiResponse.data;

      if (getFollowerListResModel.status.toString() ==
          VariableUtils.status500) {
        return Center(
          child: AdoroText(
            getFollowerListResModel.msg ?? VariableUtils.somethingWentWrong,
          ),
        );
      }

      if (getFollowerListResModel.data!.isEmpty) {
        return Center(
          child: AdoroText(
            "No following",
            color: blackWhite,
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.only(bottom: 40.w),
        itemCount: getFollowerListResModel.data?.length,
        itemBuilder: (context, index) {
          final followingData = getFollowerListResModel.data?[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    followingData?.username ?? "",
                    style: TextStyle(color: blackWhite),
                  ),
                  subtitle: AdoroText(followingData?.fullName ?? "",
                      color: blackWhite),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10.w),
                    child: Container(
                      height: 10.w,
                      width: 10.w,
                      color: ColorUtils.greyFA,
                      child: OctoImage(
                        fit: BoxFit.cover,
                        width: 24,
                        height: 24,
                        image: NetworkImage(followingData?.image ?? ""),
                        progressIndicatorBuilder: (context, progress) {
                          double? value;
                          var expectedBytes = progress?.expectedTotalBytes;
                          if (progress != null && expectedBytes != null) {
                            value =
                                progress.cumulativeBytesLoaded / expectedBytes;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: value,
                              color:
                                  Theme.of(context).textTheme.titleSmall?.color,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stacktrace) => Container(
                          width: 24,
                          height: 24,
                          color: ColorUtils.grey[200],
                          child: Padding(
                            padding: EdgeInsets.all(1.w),
                            child: CommonImage(
                              img: IconsWidgets.userImages,
                              color: ColorUtils.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.more_vert,
                    color: ColorUtils.black92,
                  ),
                  contentPadding: EdgeInsets.all(0.w),
                ),
                DecorationUtils.dividerLine2(),
              ],
            ),
          );
        },
      );
    }
  }
}

class FollowerFollowingController extends GetxController {
  int currentTabIndex = 0;

  void changeTabIndex(index) {
    currentTabIndex = index;
    update();
  }
}
