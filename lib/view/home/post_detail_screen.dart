import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/get_post_detail_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/view/bottomBar/bottombar.dart';
import 'package:socialv/view/home/components/post_components.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/viewModel/create_post_view_model.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final String postId;

  final CreatePostViewModel viewModel = Get.find<CreatePostViewModel>();
  final HomeController homeController = Get.find<HomeController>();
  final CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    return WillPopScope(
      onWillPop: () {
        Get.offAll(() => BottomBar());
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: greyFABlack32,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(15.w),
          child: CommonAppBar(
            color: ColorUtils.transparent,
            title: 'Post',
            onTap: () => Get.offAll(() => BottomBar()),
          ),
        ),
        body: GetBuilder<CreatePostViewModel>(
          initState: (state) async {
            await viewModel.getPostDetail(postId);
            if (viewModel.getPostDetailApiResponse.status == Status.COMPLETE) {
              final GetPostDetailResModel postDetailResModel =
                  viewModel.getPostDetailApiResponse.data;

              if (postDetailResModel.status != 200) {
                return;
              }
              final postDetail = postDetailResModel.data!;

              bool isLiked = false;
              if ((postDetail.likedByPeople?.isNotEmpty ?? false) == true) {
                final containIndex = postDetail.likedByPeople!.indexWhere(
                    (element) =>
                        element.id ==
                        PreferenceUtils.getInt(key: PreferenceUtils.userid));
                if (containIndex > -1) {
                  isLiked = true;
                }
              }
              categoryFeedViewModel.setLikeUnlike(postId, isLiked);
            }
          },
          builder: (controller) {
            if (controller.getPostDetailApiResponse.status == Status.LOADING ||
                controller.getPostDetailApiResponse.status == Status.INITIAL) {
              return Center(child: Loader());
            } else if (controller.getPostDetailApiResponse.status ==
                    Status.ERROR ||
                controller.getPostDetailApiResponse.data == null) {
              return Center(child: SomethingWentWrong());
            }

            final GetPostDetailResModel postDetailResModel =
                controller.getPostDetailApiResponse.data;

            if (postDetailResModel.status != 200) {
              return Center(child: NoDataFound());
            }
            final postDetail = postDetailResModel.data!;
            return PostComponents(
              isInView: true,
              userId: int.parse(postDetail.userId!),
              contentType: postDetail.contentType ?? "image",
              homeController: homeController,
              postId: postDetail.id ?? 0,
              categoryFeedViewModel: categoryFeedViewModel,
              likeByMe: (postDetail.likedByPeople?.isNotEmpty ?? false) == true
                  ? postDetail.likedByPeople!.indexWhere((element) =>
                              element.id ==
                              PreferenceUtils.getInt(
                                  key: PreferenceUtils.userid)) >
                          -1
                      ? "You"
                      : (postDetail.likedByPeople?[0].username ?? "")
                  : (postDetail.likedByPeople?[0].username ?? ""),
              likeProfile: postDetail.likedByPeople,
              profileImage: postDetail.image ?? "",
              userName: postDetail.username ?? "",
              time: postTimeCalculate(
                postDetail.createdOn,
                'ago',
              ),
              contentImage: postDetail.contentUrl.toString(),
              title: postDetail.content.toString(),
              // title: (categoryIndex.id ?? 0)
              //     .toString(),
              likeCounter: (postDetail.likedByPeople?.length ?? 0).toString(),
              commentCounter: (postDetail.comments ?? 0).toString(),
            );
          },
        ),
      ),
    );
  }
}
