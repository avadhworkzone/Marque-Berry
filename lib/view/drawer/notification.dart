import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/get_notification_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/view/profile/follow_request_screen.dart';
import 'package:socialv/viewModel/drawer_viewmodel.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../commanWidget/common_appbar.dart';
import '../../model/apiModel/requestModel/delete_follow_request_req_model.dart';
import '../../utils/adoro_text.dart';
import '../../utils/assets/images_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/font_style_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/variable_utils.dart';
import '../../viewModel/category_view_model.dart';
import '../../viewModel/follow_request_view_model.dart';
import '../../viewModel/profile_view_model.dart';
import '../home/post_detail_screen.dart';
import '../profile/profile.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  final DrawerVideModel viewModel = Get.find<DrawerVideModel>();

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(16.w),
        child: CommonAppBar(
          title: VariableUtils.notificationText,
          color: Theme.of(context).cardColor,
          onTap: () => Get.back(),
        ),
      ),
      body: GetBuilder<DrawerVideModel>(initState: (state) {
        viewModel.getNotificationList();
      }, builder: (cont) {
        if (cont.getNotificationListApiResponse.status == Status.LOADING ||
            cont.getNotificationListApiResponse.status == Status.INITIAL) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (cont.getNotificationListApiResponse.status == Status.ERROR) {
          return Center(child: SomethingWentWrong());
        }
        NotificationListResModel notificationListResModel =
            cont.getNotificationListApiResponse.data;
        if (notificationListResModel.status != 200 ||
            (notificationListResModel.data?.isEmpty ?? true) == true) {
          return Center(
            child: AdoroText(
              VariableUtils.noDataFound,
            ),
          );
        }
        final totalPendingRequest = notificationListResModel.data
                ?.where((element) =>
                    element.title?.replaceAll(" ", "") == 'FollowRequest')
                .toList()
                .length ??
            0;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (totalPendingRequest > 0)
                Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 3.w, right: 3.w),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => FollowRequestScreen());
                    },
                    child: AdoroText(
                      VariableUtils.SeeAllRequests + " ($totalPendingRequest)",
                      fontSize: 13.sp,
                      fontWeight: FontWeightClass.fontWeightBold,
                      color: ColorUtils.blueB9,
                    ),
                  ),
                ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: notificationListResModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final notification = notificationListResModel.data![index];
                  if (notification.title == 'Follow Request') {
                    return UserProfileDasType(
                      userId: notification.dataId!,
                      image: notification.image!,
                      username: notification.username!,
                      fullname: notification.fullName!,
                      tital: notification.title!,
                      createdOn: notification.createdOn!,
                    );
                  }
                  if (notification.title == 'Request Accepted') {
                    return NotificationUserProfile(
                      userId: notification.dataId!,
                      image: notification.image!,
                      username: notification.username!,
                      fullname: notification.fullName!,
                      tital: notification.title!,
                      createdOn: notification.createdOn!,
                    );
                  }

                  return Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
                    margin: EdgeInsets.only(bottom: 5.sp),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => PostDetailScreen(
                              postId: notification.dataId!,
                              isFromBackScreen: true,
                            ));
                      },
                      child: AdoroText(
                        (notification.message ?? 'N/A') +
                            "  " +
                            getTime(notification.createdOn!),
                        fontSize: 11.sp,
                        color: ColorUtils.black92,
                        fontWeight: FontWeightClass.fontWeight600,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
        // return Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 3.w),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       InkWell(
        //         onTap: () {
        //           Get.to(() => FollowRequestScreen());
        //         },
        //         child: AdoroText(
        //           VariableUtils.SeeAllRequests,
        //           fontSize: 13.sp,
        //           fontWeight: FontWeightClass.fontWeightBold,
        //           color: ColorUtils.blueB9,
        //         ),
        //       ),
        //       SizeConfig.sH2,
        //       Ritikraj(),
        //       SizeConfig.sH5,
        //       AdoroText(
        //         VariableUtils.SuggestedForYou,
        //         fontSize: 13.sp,
        //         fontWeight: FontWeightClass.fontWeightBold,
        //         color: blackWhite,
        //       ),
        //       SizeConfig.sH4,
        //       UserNameFollow(),
        //       SizeConfig.sH3,
        //       UserNameFollow(),
        //       SizeConfig.sH3,
        //       UserNameFollow(),
        //       SizeConfig.sH3,
        //     ],
        //   ),
        // );
      }),
    );
  }

  String getTime(String date) {
    return timeago
        .format(
          DateTime.parse(date),
          allowFromNow: true,
        )
        .replaceAll('ago', "");
  }
}

class UserProfileDasType extends StatelessWidget {
  UserProfileDasType(
      {Key? key,
      required this.userId,
      required this.image,
      required this.username,
      required this.fullname,
      required this.tital,
      required this.createdOn})
      : super(key: key);
  final String userId;
  final String image;
  final String username;
  final String fullname;
  final String tital;
  final String createdOn;

  final ProfileViewModel profileViewModel = Get.find<ProfileViewModel>();
  final viewModel = Get.find<FollowFollowingViewModel>();
  final CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();
  final DrawerVideModel drawerVideModel = Get.find<DrawerVideModel>();

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 6.h,
            width: 12.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                image: DecorationImage(image: NetworkImage(image))),
          ),
          // CircleAvatar(
          //     radius: 5.w,
          //     child: Image(
          //       image: NetworkImage(image),
          //     )),
          SizeConfig.sW1,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdoroText(
                username,
                // VariableUtils.ritiKraj,
                fontSize: 12.sp,
                fontWeight: FontWeightClass.fontWeightBold,
                color: blackWhite,
              ),
              // AdoroText(
              //   fullname,
              //   // VariableUtils.requestedTo,
              //   fontSize: 11.sp,
              //   color: ColorUtils.black92,
              //   fontWeight: FontWeightClass.fontWeightBold,
              // ),
              AdoroText(
                tital,
                // VariableUtils.followYou,
                fontSize: 11.sp,
                color: ColorUtils.black92,
                fontWeight: FontWeightClass.fontWeightBold,
              ),
              AdoroText(
                getTime(createdOn),
                // VariableUtils.followYou,
                fontSize: 11.sp,
                color: ColorUtils.black92,
                fontWeight: FontWeightClass.fontWeightBold,
              ),
              SizeConfig.sH3,
            ],
          ),
          SizeConfig.sW1,
          Padding(
            padding: EdgeInsets.only(top: 3.w),
            child: InkWell(
              onTap: () async {
                profileViewModel.isLoading = true;
                await viewModel.acceptFollowRequest(userId.toString());
                if (viewModel.acceptFollowRequestApiResponse.status ==
                    Status.COMPLETE) {
                  drawerVideModel.getNotificationList();
                  // await profileViewModel.getProfileDetail(userId.toString());
                }
                profileViewModel.isLoading = false;
              },
              child: Container(
                height: 4.h,
                width: 20.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorUtils.linearGradient7,
                      ColorUtils.linearGradient4,
                      ColorUtils.linearGradient5,
                      ColorUtils.linearGradient8,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.w),
                  ),
                ),
                child: Center(
                  child: AdoroText(
                    VariableUtils.Confirm,
                    color: ColorUtils.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
          ),
          SizeConfig.sW1,
          Padding(
            padding: EdgeInsets.only(top: 3.w),
            child: InkWell(
              onTap: () async {
                profileViewModel.isLoading = true;
                await viewModel.deleteFollowRequest(DeleteFollowReqModel(
                    id: userId.toString(), flag: 'delete'));
                if (viewModel.deleteFollowRequestApiResponse.status ==
                    Status.COMPLETE) {
                  categoryFeedViewModel.setFollowData(int.parse(userId), false);

                  drawerVideModel.getNotificationList();
                }
                profileViewModel.isLoading = false;
              },
              child: Container(
                height: 4.h,
                width: 20.w,
                decoration: BoxDecoration(
                  color: ColorUtils.black92,
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.w),
                  ),
                ),
                child: Center(
                  child: AdoroText(
                    VariableUtils.Delete,
                    color: ColorUtils.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getTime(String date) {
    return timeago
        .format(
          DateTime.parse(date),
          allowFromNow: true,
        )
        .replaceAll('ago', "");
  }
}

class NotificationUserProfile extends StatelessWidget {
  NotificationUserProfile(
      {Key? key,
      required this.userId,
      required this.image,
      required this.username,
      required this.fullname,
      required this.tital,
      required this.createdOn})
      : super(key: key);
  final String userId;
  final String image;
  final String username;
  final String fullname;
  final String tital;
  final String createdOn;

  final ProfileViewModel profileViewModel = Get.find<ProfileViewModel>();
  final viewModel = Get.find<FollowFollowingViewModel>();
  final CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();
  final DrawerVideModel drawerVideModel = Get.find<DrawerVideModel>();

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: InkWell(
        onTap: () {
          Get.to(() => Profile(userId: int.parse(userId)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 6.h,
              width: 12.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  image: DecorationImage(image: NetworkImage(image))),
            ),
            // CircleAvatar(
            //     radius: 5.w,
            //     child: Image(
            //       image: NetworkImage(image),
            //     )),
            SizeConfig.sW3,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdoroText(
                  username,
                  // VariableUtils.ritiKraj,
                  fontSize: 12.sp,
                  fontWeight: FontWeightClass.fontWeightBold,
                  color: blackWhite,
                ),
                // AdoroText(
                //   fullname,
                //   // VariableUtils.requestedTo,
                //   fontSize: 11.sp,
                //   color: ColorUtils.black92,
                //   fontWeight: FontWeightClass.fontWeightBold,
                // ),
                AdoroText(
                  tital,
                  // VariableUtils.followYou,
                  fontSize: 11.sp,
                  color: ColorUtils.black92,
                  fontWeight: FontWeightClass.fontWeightBold,
                ),
                AdoroText(
                  getTime(createdOn),
                  // VariableUtils.followYou,
                  fontSize: 11.sp,
                  color: ColorUtils.black92,
                  fontWeight: FontWeightClass.fontWeightBold,
                ),
                SizeConfig.sH3,
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getTime(String date) {
    return timeago
        .format(
          DateTime.parse(date),
          allowFromNow: true,
        )
        .replaceAll('ago', "");
  }
}

class UserNameFollow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 6.w,
          child: ImagesWidgets.userImage,
        ),
        SizeConfig.sW3,
        AdoroText(
          VariableUtils.Username,
          fontSize: 12.sp,
          fontWeight: FontWeightClass.fontWeightBold,
          color: blackWhite,
        ),
        Spacer(),
        Container(
          height: 4.h,
          width: 23.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorUtils.linearGradient7,
                ColorUtils.linearGradient4,
                ColorUtils.linearGradient5,
                ColorUtils.linearGradient8,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(2.w),
            ),
          ),
          child: Center(
            child: AdoroText(
              VariableUtils.Follow,
              color: ColorUtils.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
            ),
          ),
        ),
      ],
    );
  }
}

// class UserNameCircleAvatar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         CircleAvatar(
//           radius: 6.w,
//           child: ImagesWidgets.userImage,
//         ),
//         Padding(
//           padding: EdgeInsets.only(right: 20.w),
//           child: AdoroText(
//             VariableUtils.Username,
//             fontSize: 12.sp,
//             fontWeight: FontWeightClass.fontWeightBold,
//             color: blackWhite,
//           ),
//         ),
//         Container(
//           height: 4.h,
//           width: 23.w,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 ColorUtils.linearGradient1,
//                 ColorUtils.linearGradient6,
//                 ColorUtils.linearGradient7
//               ],
//               begin: Alignment.bottomLeft,
//               end: Alignment.topRight,
//             ),
//             borderRadius: BorderRadius.all(
//              VariableUtils.Follow,
//               color: ColorUtils.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 11.sp,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class UserNameContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         CircleAvatar(
//           radius: 6.w,
//           child: ImagesWidgets.userImage,
//         ),
//         Padding(
//           padding: EdgeInsets.only(right: 20.w),
//           child: AdoroText(
//             VariableUtils.Username,
//             fontSize: 12.sp,
//             fontWeight: FontWeightClass.fontWeightBold,
//             color: blackWhite,
//           ),
//         ),
//         Container(
//           height: 4.h,
//           width: 23.w,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 ColorUtils.linearGradient1,
//                 ColorUtils.linearGradient6,
//                 ColorUtils.linearGradient7
//               ],
//               begin: Alignment.bottomLeft,
//               end: Alignment.topRight,
//             ),
//             borderRadius: BorderRadius.all(
//               Radius.circular(2.w),
//             ),
//           ),
//           child: Center(
//             child: AdoroText(
//               VariableUtils.Follow,
//               color: ColorUtils.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 11.sp,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
