import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/model/apiModel/requestModel/dislike_post_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/like_post_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/view/home/comment_components/like_screen.dart';
import 'package:socialv/view/home/comments.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/viewModel/category_view_model.dart';

class PostComponents extends StatelessWidget {
  String likecounter;

  String name;
  String time;
  String title;
  String contentImage;
  String contentType;
  String commentcounter = '0';
  String profileImage;

  String likeByMe;
  int? likeByMePeople = 0;
  List<LikedByPeople>? likeProfile;

  CategoryFeedViewModel categoryFeedViewModel;

  int? postid = 0;

  int currentTabIndex;

  HomeController homeController;

  PostComponents({
    Key? key,
    required this.homeController,
    required this.contentType,
    required this.currentTabIndex,
    required this.postid,
    required this.name,
    required this.time,
    required this.title,
    required this.likeByMe,
    required this.likeByMePeople,
    required this.likeProfile,
    required this.profileImage,
    required this.contentImage,
    required this.likecounter,
    required this.commentcounter,
    required this.categoryFeedViewModel,
  }) : super(key: key);

  DisLikePostReqModel disLikePostReqModel = DisLikePostReqModel();
  LikePostReqModel likePostReqModel = LikePostReqModel();

  @override
  Widget build(BuildContext context) {
    Color greyBlack2E = Theme.of(context).cardColor;
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
                title: (name) != ""
                    ? AdoroText(
                        name,
                        maxLines: 1,
                        fontSize: 12.sp,
                        color: Theme.of(context).textTheme.titleSmall!.color,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeightClass.fontWeight600,
                      )
                    : SizedBox(),
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
                    Get.bottomSheet(
                      Container(
                        decoration: BoxDecoration(
                          color: ColorUtils.white,
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        height: 70.w,
                        width: 100.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 5.w),
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
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/share.png",
                                    scale: 1.5.w,
                                    color: ColorUtils.black,
                                  ),
                                  SizeConfig.sW3,
                                  AdoroText(
                                    "Share via",
                                    color: ColorUtils.black92,
                                    fontSize: 14.sp,
                                  ),
                                ],
                              ),
                              SizeConfig.sH3,
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/link.png",
                                    scale: 1.2.w,
                                    color: ColorUtils.black,
                                  ),
                                  SizeConfig.sW3,
                                  AdoroText(
                                    "Copy link",
                                    color: ColorUtils.black92,
                                    fontSize: 13.sp,
                                  ),
                                ],
                              ),
                              SizeConfig.sH3,
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/unfollow.png",
                                    scale: 1.2.w,
                                    color: ColorUtils.black,
                                  ),
                                  SizeConfig.sW3,
                                  AdoroText(
                                    "Unfollow",
                                    color: ColorUtils.black92,
                                    fontSize: 13.sp,
                                  ),
                                ],
                              ),
                              SizeConfig.sH3,
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/report.png",
                                    scale: 1.3.w,
                                    color: ColorUtils.black,
                                  ),
                                  SizeConfig.sW3,
                                  AdoroText(
                                    "Report post",
                                    color: ColorUtils.black92,
                                    fontSize: 13.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
                    (title) == ""
                        ? SizedBox()
                        : AdoroText(
                            "$title",
                            maxLines: 2,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                            color: black92White,
                          ),
                    SizeConfig.sH1,
                    // Text("contentType-----> $contentType"),
                    // contentType.toLowerCase() == "video" ||
                    //         contentType.toLowerCase() == "gif"
                    //     ? Text('Video')
                    //     :
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2.w),
                      child: Container(
                        height: 75.w,
                        width: Get.width,
                        child: OctoImage(
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
                          errorBuilder: (context, error, stacktrace) => Padding(
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
                        // categoryFeedViewModel.likeUnlink.containsKey(postid)
                        //     ?
                        categoryFeedViewModel.likeUnlink[postid] == true
                            ? LikeWidget(
                                disLikePostReqModel: disLikePostReqModel,
                                postid: postid ?? 0,
                                categoryFeedViewModel: categoryFeedViewModel)
                            : UnlikeWidget(
                                likePostReqModel: likePostReqModel,
                                postid: postid ?? 0,
                                categoryFeedViewModel: categoryFeedViewModel,
                              ),
                        SizeConfig.sW2,
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => Comments(
                                postId: postid,
                                profileImage: profileImage,
                              ),
                            );
                          },
                          child: CommonImageScale(
                            img: IconsWidgets.chatImage,
                            scale: 0.8.w,
                            color: black92White,
                          ),
                        ),
                        SizeConfig.sW2,
                        CommonImageScale(
                          img: IconsWidgets.sendImage,
                          scale: 1.w,
                          color: black92White,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => Comments(
                                postId: postid,
                                profileImage: profileImage,
                              ),
                            );
                          },
                          child: AdoroText(
                            "$commentcounter Comments",
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
                                () => LikeScreen(likeProfile: likeProfile),
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
                                        color: black92White,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' And ',
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                        color: black92Blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '$likecounter other',
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                        color: black92White,
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

  LikeBottom({
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
                  // AdoroText(likeProfile..toString()),
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
}

class LikeWidget extends StatelessWidget {
  const LikeWidget({
    super.key,
    required this.disLikePostReqModel,
    required this.postid,
    required this.categoryFeedViewModel,
  });

  final DisLikePostReqModel disLikePostReqModel;
  final int postid;
  final CategoryFeedViewModel categoryFeedViewModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        disLikePostReqModel.postId = postid.toString();
        await categoryFeedViewModel.dislikePost(disLikePostReqModel);
        await categoryFeedViewModel.changeLikeUnlike(postid, false);
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
        categoryFeedViewModel.changeLikeUnlike(postid, true);
        logs(" =======------ LIKE WIDGET ${categoryFeedViewModel.likeUnlink}");
        await categoryFeedViewModel.likePost(likePostReqModel);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 1.w),
        child: CommonImageScale(
          img: IconsWidgets.heartImage,
          scale: 1.w,
          color: Theme.of(context).textTheme.titleMedium?.color,
        ),
      ),
    );
  }
}
