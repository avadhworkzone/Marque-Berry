// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/requestModel/get_post_like_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/get_post_like_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/viewModel/category_view_model.dart';

import '../../profile/profile.dart';

class LikeScreen extends StatelessWidget {
  int likeProfile;

  LikeScreen({
    Key? key,
    required this.likeProfile,
  }) : super(key: key);

  CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();

  GetPostLikeReqModel getPostLikeReqModel = GetPostLikeReqModel();

  @override
  Widget build(BuildContext context) {
    Color? whiteBlack = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    final size = MediaQuery.of(context).size;
    Color? bgColor = Theme.of(context).colorScheme.background;
    Color? boxBgColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: customAppbar(
        title: 'Likes',
        context: context,
      ),
      body: GetBuilder<CategoryFeedViewModel>(
        initState: (_) {
          getPostLikeReqModel.postId = likeProfile.toString();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await categoryFeedViewModel.getLikeByUser(getPostLikeReqModel);
          });
        },
        builder: (categoryFeedViewModel) {
          if (categoryFeedViewModel.getLikeByUserApiResponse.status ==
                  Status.LOADING ||
              categoryFeedViewModel.getLikeByUserApiResponse.status ==
                  Status.INITIAL) {
            return Center(child: Loader());
          } else if (categoryFeedViewModel.getLikeByUserApiResponse.status ==
                  Status.ERROR ||
              categoryFeedViewModel.getLikeByUserApiResponse.data == null) {
            return Center(child: SomethingWentWrong());
          }

          GetPostLikeResModel likeResponse =
              categoryFeedViewModel.getLikeByUserApiResponse.data;
          if (likeResponse.status == 500) {
            return Center(child: AdoroText(likeResponse.msg ?? ""));
          } else if (likeResponse.data!.isEmpty) {
            return Center(
              child: AdoroText(likeResponse.msg ?? VariableUtils.noDataFound),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                color: boxBgColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    AdoroText(
                      'Likes',
                      color: blackWhite,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: likeResponse.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final likeData = likeResponse.data?[index];
                          return ListTile(
                            onTap: () {
                              Get.to(() => Profile(
                                    userId: likeData!.id!,
                                  ));
                            },
                            title: AdoroText(
                              likeData?.username ?? "",
                              color: blackWhite,
                              // style: TextStyle(color: ColorUtils.black2E),
                            ),
                            subtitle: AdoroText(
                              likeData?.fullName ?? "",
                              color: blackWhite,
                              // style: TextStyle(color: ColorUtils.black92),
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
                                    likeData?.image ?? "",
                                  ),
                                  progressIndicatorBuilder:
                                      (context, progress) {
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
                                        color: ColorUtils.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
          );
        },
      ),
    );
  }
}
