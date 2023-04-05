import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/view/home/comment_components/like_screen.dart';
import 'package:socialv/view/home/comments.dart';

class PostComponents extends StatelessWidget {
  String likecounter;

  String name;
  String time;
  String title;
  String contentImage;
  String commentcounter;
  String profileImage;

  String likeByMe;
  int? likeByMePeople = 0;
  List<LikedByPeople>? likeProfile;

  PostComponents({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return Padding(
      padding: EdgeInsets.only(bottom: 2.w),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1.5.w),
          child: Column(
            children: [
              ListTile(
                title: AdoroText(
                  name ?? "",
                  maxLines: 1,
                  fontSize: 12.sp,
                  color: Theme.of(context).textTheme.titleSmall!.color,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeightClass.fontWeight600,
                ),
                subtitle: AdoroText(
                  time ?? "",
                  maxLines: 1,
                  fontSize: 9.sp,
                  color: Theme.of(context).textTheme.titleMedium!.color,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(15.w),
                  child: Container(
                    color: ColorUtils.greyFA.withOpacity(0.2),
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
                          color: blackWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                trailing: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizeConfig.sH1,
                    AdoroText(
                      title ?? "",
                      maxLines: 2,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      color: Theme.of(context).textTheme.titleMedium?.color,
                    ),
                    SizeConfig.sH2,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2.w),
                      child: Container(
                        height: 60.w,
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
                              color: blackWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizeConfig.sH2,
                    Row(
                      children: [
                        likeByMe == "You"
                            ? CommonImageScale(
                                img: IconsWidgets.heartFilledImage,
                                scale: 1.w,
                                color: ColorUtils.red29,
                              )
                            : CommonImageScale(
                                img: IconsWidgets.heartImage,
                                scale: 1.w,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.color,
                              ),
                        SizeConfig.sW2,
                        InkWell(
                          onTap: () {
                            Get.to(() => Comments());
                          },
                          child: CommonImageScale(
                            img: IconsWidgets.chatImage,
                            scale: 0.8.w,
                            color:
                                Theme.of(context).textTheme.titleMedium?.color,
                          ),
                        ),
                        SizeConfig.sW2,
                        CommonImageScale(
                          img: IconsWidgets.sendImage,
                          scale: 1.w,
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        ),
                        Spacer(),
                        AdoroText(
                          "$commentcounter Comments",
                          fontSize: 10.sp,
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        )
                      ],
                    ),
                    SizeConfig.sH1,
                    DecorationUtils.dividerLine2(),
                    SizeConfig.sH1,
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
                                            value =
                                                progress.cumulativeBytesLoaded /
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
                                          color: ColorUtils.greyFA
                                              .withOpacity(0.2),
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
                                ),
                              ),
                            ),
                          if (likeProfile!.length == 1) SizeConfig.sW2,
                          InkWell(
                            onTap: () => Get.to(
                              () => LikeScreen(likeProfile: likeProfile),
                            ),
                            //     LikeBottom(
                            //   likeProfile: likeProfile,
                            //   blackWhite: blackWhite,
                            // ),
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(fontSize: 9.sp),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Liked by ',
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "$likeByMe",
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' And ',
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '$likecounter other',
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .color,
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

  LikeBottom(
      {required List<LikedByPeople>? likeProfile, required Color? blackWhite}) {
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
