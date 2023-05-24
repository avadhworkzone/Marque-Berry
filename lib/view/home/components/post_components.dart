// ignore_for_file: must_be_immutable

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:socialv/appService/dynamic_link.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';
import 'package:socialv/model/apiModel/requestModel/like_post_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/dislike_post_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';
import 'package:socialv/model/apiModel/requestModel/delete_follow_request_req_model.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/typedef_utils.dart';
import 'package:socialv/view/home/comment_components/like_screen.dart';
import 'package:socialv/view/home/comments.dart';
import 'package:socialv/view/home/components/video_components.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/view/profile/profile.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';

import '../../../utils/variable_utils.dart';
import 'widgets/share_post_bottom_sheet.dart';

class PostComponents extends StatelessWidget {
  String likeCounter;
  String userName;
  String time;
  String title;
  String contentImage;
  String contentType;
  String commentCounter = '0';
  String profileImage;
  String likeByMe;

  bool isInView;

  int postId = 0;
  int userId = 0;

  List<LikedByPeople>? likeProfile;
  HomeController homeController;
  CategoryFeedViewModel categoryFeedViewModel;
  bool isPostDetailFromLink;

  PostComponents(
      {Key? key,
      required this.isInView,
      required this.homeController,
      required this.contentType,
      required this.postId,
      required this.userId,
      required this.userName,
      required this.time,
      required this.title,
      required this.likeByMe,
      required this.likeProfile,
      required this.profileImage,
      required this.contentImage,
      required this.likeCounter,
      required this.commentCounter,
      required this.categoryFeedViewModel,
      this.isPostDetailFromLink = false})
      : super(key: key);

  LikePostReqModel likePostReqModel = LikePostReqModel();
  DisLikePostReqModel disLikePostReqModel = DisLikePostReqModel();

  DeleteFollowReqModel deleteFollowReqModel = DeleteFollowReqModel();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    return Padding(
      padding: EdgeInsets.fromLTRB(2.w, 0, 2.w, 2.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.5.w),
          color: whiteBlack2E,
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.grey.shade300),
          ],
        ),
        child: Column(
          children: [
            SizeConfig.sH1,
            ListTile(
              onTap: () {
                Get.to(() => Profile(
                      userId: userId,
                    ));
              },
              title: AdoroText(
                userName,
                maxLines: 1,
                fontSize: 12.sp,
                color: Theme.of(context).textTheme.titleSmall!.color,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeightClass.fontWeight600,
              ),
              subtitle: AdoroText(
                time,
                maxLines: 1,
                fontSize: 9.sp,
                color: black92White,
                overflow: TextOverflow.ellipsis,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15.w),
                child: Container(
                  color: Colors.grey[200],
                  child: OctoImage(
                    fit: BoxFit.cover,
                    width: 15.w,
                    height: 15.w,
                    image: NetworkImage(profileImage),
                    progressIndicatorBuilder: (context, progress) {
                      double? value;
                      var expectedBytes = progress?.expectedTotalBytes;
                      if (progress != null && expectedBytes != null) {
                        value = progress.cumulativeBytesLoaded / expectedBytes;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: value,
                          color: blackWhite,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stacktrace) => Padding(
                      padding: EdgeInsets.all(2.w),
                      child: CommonImage(
                        img: IconsWidgets.userImages,
                        color: ColorUtils.black,
                      ),
                    ),
                  ),
                ),
              ),
              trailing: isPostDetailFromLink
                  ? SizedBox()
                  : IconButton(
                      onPressed: () {
                        dotDialog(
                          postIdArg: postId,
                          categoryFeedViewModel: categoryFeedViewModel,
                        );
                      },
                      icon: Icon(Icons.more_horiz, color: black92White),
                    ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizeConfig.sH1,
                Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                  child: AdoroText(
                    "$title",
                    maxLines: 2,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    color: black92White,
                  ),
                ),
                SizeConfig.sH1,
                ClipRRect(
                  borderRadius: BorderRadius.circular(2.w),
                  child: Container(
                    // height: 75.w,
                    width: Get.width,
                    child: contentType.toLowerCase() == "video"
                        ? InViewVideoComponents(
                            play: isInView,
                            url: contentImage,
                          )
                        : OctoImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(contentImage),
                            progressIndicatorBuilder: (context, progress) {
                              double? value;
                              var expectedBytes = progress?.expectedTotalBytes;
                              if (progress != null && expectedBytes != null) {
                                value = progress.cumulativeBytesLoaded /
                                    expectedBytes;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: value,
                                  color: blackWhite,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stacktrace) =>
                                Padding(
                              padding: EdgeInsets.all(7.w),
                              child: CommonImage(
                                img: IconsWidgets.userImages,
                                color: blackWhite,
                              ),
                            ),
                          ),
                  ),
                ),
                SizeConfig.sH3,
                Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                  child: Row(
                    children: [
                      categoryFeedViewModel.likeUnlink[postId] == true
                          ? LikeWidget(
                              postId: postId,
                              disLikePostReqModel: disLikePostReqModel,
                              categoryFeedViewModel: categoryFeedViewModel,
                              tabName: homeController.tabName,
                            )
                          : UnlikeWidget(
                              postId: postId,
                              likePostReqModel: likePostReqModel,
                              categoryFeedViewModel: categoryFeedViewModel,
                              tabName: homeController.tabName,
                            ),
                      SizeConfig.sW1AndHalf,
                      InkWell(
                        onTap: () async {
                          await Get.to(
                            () => Comments(
                              postId: postId,
                              profileImage: profileImage,
                            ),
                          );
                          categoryFeedViewModel.pageNumberIndex = 0;
                          categoryFeedViewModel.categoryTrending(
                              homeController.tabName,
                              isReload: false);
                        },
                        child: CommonImageScale(
                          scale: 25.w,
                          color: black92White,
                          img: IconsWidgets.chatImage,
                        ),
                      ),
                      SizeConfig.sW1AndHalf,
                      InkWell(
                        onTap: () {
                          sharePostBottomSheet(  postIdArg: postId,
                            categoryFeedViewModel: categoryFeedViewModel,);
                        },
                        child: CommonImageScale(
                          scale: 25.w,
                          color: black92White,
                          img: IconsWidgets.sendImage,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          await Get.to(
                            () => Comments(
                              postId: postId,
                              profileImage: profileImage,
                            ),
                          );
                          categoryFeedViewModel.pageNumberIndex = 0;
                          categoryFeedViewModel.categoryTrending(
                              homeController.tabName,
                              isReload: false);
                        },
                        child: AdoroText(
                          "$commentCounter Comments",
                          fontSize: 10.sp,
                          color: black92White,
                        ),
                      )
                    ],
                  ),
                ),
                SizeConfig.sH1,
                Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                  child: DecorationUtils.dividerLine2(),
                ),
                SizeConfig.sH1,
                if (likeProfile?.length != null)
                  Padding(
                    padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 0.w),
                    child: Container(
                      width: Get.width,
                      child: Row(
                        children: [
                          if ((likeProfile?.length ?? 0) > 0)
                            Container(
                              width: (24 *
                                  (likeProfile!.length > 3
                                          ? 3
                                          : likeProfile!.length)
                                      .toDouble()),
                              height: 24,
                              child: Stack(
                                children: List.generate(
                                  (likeProfile!.length > 3
                                      ? 3
                                      : likeProfile!.length),
                                  (index) => Positioned(
                                    left: (((likeProfile!.length > 3
                                                ? 2
                                                : likeProfile!.length - 1)) -
                                            index) *
                                        18,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        color: Colors.grey[200],
                                        child: OctoImage(
                                          fit: BoxFit.cover,
                                          width: 24,
                                          height: 24,
                                          image: NetworkImage(
                                            likeProfile?[index].image ?? "",
                                          ),
                                          progressIndicatorBuilder:
                                              (context, progress) {
                                            double? value;
                                            var expectedBytes =
                                                progress?.expectedTotalBytes;
                                            if (progress != null &&
                                                expectedBytes != null) {
                                              value = progress
                                                      .cumulativeBytesLoaded /
                                                  expectedBytes;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: value,
                                                color: blackWhite,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stacktrace) =>
                                                  Container(
                                            width: 24,
                                            height: 24,
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
                                  ),
                                ),
                              ),
                            ),
                          if (likeProfile!.length == 1) SizeConfig.sW2,
                          InkWell(
                            onTap: () => Get.to(
                              () => LikeScreen(likeProfile: postId),
                            ),
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(fontSize: 9.sp),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Liked by ',
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: black92Blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "$likeByMe ",
                                    style: TextStyle(
                                      fontSize: 9.5.sp,
                                      color: blackWhite,
                                      fontFamily: 'Poppins_Bold',
                                      fontWeight: FontWeightClass.fontWeight700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'and ',
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: black92Blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '$likeCounter other',
                                    style: TextStyle(
                                      fontSize: 9.5.sp,
                                      fontFamily: 'Poppins_Bold',
                                      color: blackWhite,
                                      fontWeight: FontWeightClass.fontWeight800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                SizeConfig.sH1,
              ],
            ),
          ],
        ),
      ),
    );
  }

  dotDialog({
    required int postIdArg,
    required CategoryFeedViewModel categoryFeedViewModel,
  }) {
    Get.bottomSheet(
      GetBuilder<FollowFollowingViewModel>(builder: (followFollowingViewModel) {
        return Container(
          decoration: BoxDecoration(
            color: ColorUtils.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.w),
              topRight: Radius.circular(5.w),
            ),
          ),
          height: userId.toString() !=
                  PreferenceUtils.getInt(key: PreferenceUtils.userid).toString()
              ? 70.w
              : 50.w,
          width: 100.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.5.w,
                      width: 40.w,
                      color: ColorUtils.black92,
                    ),
                  ],
                ),
                SizeConfig.sH3,
                bottomComponents(
                  image: IconsWidgets.shareImages,
                  text: 'Share via',
                  onTap: () async {
                    final postLink = await DynamicLink.createDynamicLinkForUser(
                        postId: postId.toString());
                    Share.share(postLink);
                  },
                ),
                SizeConfig.sH3,
                bottomComponents(
                  onTap: () async {
                    final postLink = await DynamicLink.createDynamicLinkForUser(
                        postId: postId.toString());
                    Clipboard.setData(new ClipboardData(text: postLink))
                        .then((_) {
                      showSnackBar(message: "Copied to your clipboard !");
                    });
                  },
                  text: 'Copy link',
                  image: IconsWidgets.linkImages,
                ),
                if (userId.toString() !=
                    PreferenceUtils.getInt(key: PreferenceUtils.userid)
                        .toString())
                  SizeConfig.sH3,
                if (userId.toString() !=
                    PreferenceUtils.getInt(key: PreferenceUtils.userid)
                        .toString())
                  bottomComponents(
                    image: IconsWidgets.unfollowImages,
                    text: categoryFeedViewModel.followUnfollow[userId] == true
                        ? "Unfollow"
                        : "Follow",
                    onTap: () async {
                      if (categoryFeedViewModel.followUnfollow[userId] ==
                          true) {
                        deleteFollowReqModel.flag = "feed";
                        deleteFollowReqModel.id = userId.toString();

                        await followFollowingViewModel
                            .deleteFollowRequest(deleteFollowReqModel);

                        if (followFollowingViewModel
                                .deleteFollowRequestApiResponse.status ==
                            Status.COMPLETE) {
                          Get.back();
                          categoryFeedViewModel.setFollowData(userId, false);
                          categoryFeedViewModel.pageNumberIndex = 0;
                          categoryFeedViewModel.categoryTrending(
                            homeController.tabName,
                          );
                        }
                      } else {
                        await followFollowingViewModel
                            .sendFollowRequest(userId.toString());

                        if (followFollowingViewModel
                                .sendFollowRequestApiResponse.status ==
                            Status.COMPLETE) {
                          categoryFeedViewModel.setFollowData(userId, true);
                        }
                      }
                    },
                  ),
                SizeConfig.sH3,
                bottomComponents(
                  text: 'Report post',
                  image: IconsWidgets.reportImages,
                  onTap: () async {
                    await categoryFeedViewModel
                        .reportPost(postIdArg.toString());

                    if (categoryFeedViewModel.reportPostApiResponse.status ==
                        Status.COMPLETE) {
                      CommonStatusMsgResModel response =
                          categoryFeedViewModel.reportPostApiResponse.data;

                      if (response.status.toString() ==
                          VariableUtils.status200) {
                        homeController.reportSuccess(true);
                        homeController.addReport(postIdArg);
                      } else {
                        showSnackBar(
                          message:
                              response.msg ?? VariableUtils.somethingWentWrong,
                        );
                      }
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget bottomComponents({
    required String text,
    required String image,
    required OnTab onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            image,
            scale: 1.5.w,
            color: ColorUtils.black,
          ),
          SizeConfig.sW3,
          AdoroText(text, color: ColorUtils.black92, fontSize: 14.sp),
        ],
      ),
    );
  }
}



class LikeWidget extends StatelessWidget {
  const LikeWidget({
    super.key,
    required this.disLikePostReqModel,
    required this.postId,
    required this.categoryFeedViewModel,
    required this.tabName,
  });

  final DisLikePostReqModel disLikePostReqModel;
  final int postId;
  final CategoryFeedViewModel categoryFeedViewModel;
  final String tabName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: postId == 0
          ? null
          : () async {
              disLikePostReqModel.postId = postId.toString();
              await categoryFeedViewModel.dislikePost(disLikePostReqModel);
              await categoryFeedViewModel.setLikeUnlike(postId, false);
              categoryFeedViewModel.pageNumberIndex = 0;
              categoryFeedViewModel.categoryTrending(tabName, isReload: false);
            },
      child: Padding(
        padding: EdgeInsets.only(left: 1.w),
        child: Image.asset(
          IconsWidgets.heartFilledImage,
          scale: 1.w,
          color: Colors.red,
        ),
      ),
    );
  }
}

class UnlikeWidget extends StatelessWidget {
  const UnlikeWidget({
    super.key,
    required this.likePostReqModel,
    required this.postId,
    required this.categoryFeedViewModel,
    required this.tabName,
  });

  final LikePostReqModel likePostReqModel;
  final int postId;
  final CategoryFeedViewModel categoryFeedViewModel;
  final String tabName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: postId == 0
          ? null
          : () async {
              likePostReqModel.postId = postId.toString();
              categoryFeedViewModel.setLikeUnlike(postId, true);
              await categoryFeedViewModel.likePost(likePostReqModel);
              categoryFeedViewModel.pageNumberIndex = 0;
              categoryFeedViewModel.categoryTrending(tabName, isReload: false);
            },
      child: Padding(
        padding: EdgeInsets.only(left: 1.w),
        child: CommonImageScale(
          img: IconsWidgets.heartImage,
          scale: 25.w,
          color: Theme.of(context).textTheme.titleMedium?.color,
        ),
      ),
    );
  }
}
