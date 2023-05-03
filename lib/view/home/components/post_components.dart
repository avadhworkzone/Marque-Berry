// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/model/apiModel/requestModel/delete_follow_request_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/dislike_post_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/like_post_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/report_post_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/send_follow_request_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/test.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/typedef_utils.dart';
import 'package:socialv/view/home/comment_components/like_screen.dart';
import 'package:socialv/view/home/comments.dart';
import 'package:socialv/view/home/components/video_components.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';

import '../../../utils/variable_utils.dart';

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
  int? likeByMePeople = 0;
  List<LikedByPeople>? likeProfile;

  CategoryFeedViewModel categoryFeedViewModel;

  int postId = 0;
  int userId = 0;

  int currentTabIndex;

  HomeController homeController;

  bool followedByMe;
  bool isInView;

  PostComponents({
    Key? key,
    required this.isInView,
    required this.homeController,
    required this.contentType,
    required this.currentTabIndex,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.time,
    required this.title,
    required this.likeByMe,
    required this.likeByMePeople,
    required this.likeProfile,
    required this.profileImage,
    required this.contentImage,
    required this.followedByMe,
    required this.likeCounter,
    required this.commentCounter,
    required this.categoryFeedViewModel,
  }) : super(key: key);

  DisLikePostReqModel disLikePostReqModel = DisLikePostReqModel();

  LikePostReqModel likePostReqModel = LikePostReqModel();

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.05.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.w),
        child: Container(
          decoration: BoxDecoration(
            color: whiteBlack2E,
            boxShadow: [
              BoxShadow(blurRadius: 8, color: Colors.grey),
            ],
          ),
          child: Column(
            children: [
              SizeConfig.sH2,
              ListTile(
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
                trailing: IconButton(
                  onPressed: () {
                    dotDialog(
                      postIdArg: postId,
                      categoryFeedViewModel: categoryFeedViewModel,
                    );
                  },
                  icon: Icon(Icons.more_horiz, color: black92White),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizeConfig.sH1,
                    AdoroText(
                      "$title",
                      maxLines: 2,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      color: black92White,
                    ),
                    SizeConfig.sH1,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2.w),
                      child: Container(
                        height: 75.w,
                        width: Get.width,
                        child: contentType.toLowerCase() == "video"
                            ? VideoComponents(play: isInView, url: contentImage)
                            : OctoImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(contentImage),
                                progressIndicatorBuilder: (context, progress) {
                                  double? value;
                                  var expectedBytes =
                                      progress?.expectedTotalBytes;
                                  if (progress != null &&
                                      expectedBytes != null) {
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
                                    color: ColorUtils.black,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizeConfig.sH3,
                    Row(
                      children: [
                        categoryFeedViewModel.likeUnlink[postId] == true
                            ? LikeWidget(
                                postId: postId,
                                disLikePostReqModel: disLikePostReqModel,
                                categoryFeedViewModel: categoryFeedViewModel,
                              )
                            : UnlikeWidget(
                                postid: postId,
                                likePostReqModel: likePostReqModel,
                                categoryFeedViewModel: categoryFeedViewModel,
                              ),
                        SizeConfig.sW2,
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => Comments(
                                postId: postId,
                                profileImage: profileImage,
                              ),
                            );
                          },
                          child: CommonImageScale(
                            scale: 25.w,
                            color: black92White,
                            img: IconsWidgets.chatImage,
                          ),
                        ),
                        SizeConfig.sW2,
                        CommonImageScale(
                          scale: 25.w,
                          color: black92White,
                          img: IconsWidgets.sendImage,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => Comments(
                                postId: postId,
                                profileImage: profileImage,
                              ),
                            );
                          },
                          child: AdoroText(
                            "$commentCounter Comments",
                            fontSize: 10.sp,
                            color: black92White,
                          ),
                        )
                      ],
                    ),
                    SizeConfig.sH1,
                    DecorationUtils.dividerLine2(),
                    SizeConfig.sH1,
                    if (likeProfile?.length != null)
                      Container(
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
                                                child:
                                                    CircularProgressIndicator(
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
                                      text: "$likeByMe",
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                        color: blackWhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' and ',
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                        color: black92Blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '$likeCounter other',
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                        color: blackWhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    SizeConfig.sH1,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SendFollowReqModel sendFollowReqModel = SendFollowReqModel();

  DeleteFollowReqModel deleteFollowReqModel = DeleteFollowReqModel();

  ReportPostReqModel reportPostReqModel = ReportPostReqModel();

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
          height: 70.w,
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
                  onTap: () {},
                ),
                SizeConfig.sH3,
                bottomComponents(
                  onTap: () {},
                  text: 'Copy link',
                  image: IconsWidgets.linkImages,
                ),
                SizeConfig.sH3,
                bottomComponents(
                  image: IconsWidgets.unfollowImages,
                  text: categoryFeedViewModel.followUnfollow[userId] == true
                      ? "Follow"
                      : "Unfollow",
                  onTap: () async {
                    if (categoryFeedViewModel.followUnfollow[userId] == true) {
                      sendFollowReqModel.userId = userId.toString();
                      await followFollowingViewModel
                          .sendFollowRequest(sendFollowReqModel);

                      if (followFollowingViewModel
                              .sendFollowRequestApiResponse.status ==
                          Status.COMPLETE) {
                        categoryFeedViewModel.setFollowData(userId, false);
                      }
                    } else {
                      deleteFollowReqModel.flag = "feed";
                      deleteFollowReqModel.id = userId.toString();

                      await followFollowingViewModel
                          .deleteFollowRequest(deleteFollowReqModel);

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
                    reportPostReqModel.postId = postIdArg.toString();
                    await categoryFeedViewModel.reportPost(reportPostReqModel);

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

  likeBottom({
    required List<LikedByPeople>? likeProfile,
    required Color? blackWhite,
  }) {
    Get.bottomSheet(
      Container(
        height: 140.w,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(6.w),
            topLeft: Radius.circular(6.w),
          ),
          color: ColorUtils.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdoroText(
                    'Likes',
                    color: ColorUtils.black2E,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: likeProfile?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            likeProfile?[index].username ?? "",
                            style: TextStyle(color: ColorUtils.black2E),
                          ),
                          subtitle: Text(
                            likeProfile?[index].fullName ?? "",
                            style: TextStyle(color: ColorUtils.black92),
                          ),
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
                                image: NetworkImage(
                                  likeProfile?[index].image ?? "",
                                ),
                                progressIndicatorBuilder: (context, progress) {
                                  double? value;
                                  var expectedBytes =
                                      progress?.expectedTotalBytes;
                                  if (progress != null &&
                                      expectedBytes != null) {
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
                                    Container(
                                  width: 24,
                                  height: 24,
                                  color: ColorUtils.greyFA.withOpacity(0.2),
                                  child: Padding(
                                    padding: EdgeInsets.all(1.w),
                                    child: CommonImage(
                                      img: IconsWidgets.userImages,
                                      color: blackWhite,
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
                          contentPadding: const EdgeInsets.all(10),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
  });

  final DisLikePostReqModel disLikePostReqModel;
  final int postId;
  final CategoryFeedViewModel categoryFeedViewModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        disLikePostReqModel.postId = postId.toString();
        await categoryFeedViewModel.dislikePost(disLikePostReqModel);
        await categoryFeedViewModel.setLikeUnlike(postId, false);
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
    required this.postid,
    required this.categoryFeedViewModel,
  });

  final LikePostReqModel likePostReqModel;
  final int postid;
  final CategoryFeedViewModel categoryFeedViewModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        likePostReqModel.postId = postid.toString();
        categoryFeedViewModel.setLikeUnlike(postid, true);
        await categoryFeedViewModel.likePost(likePostReqModel);
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
