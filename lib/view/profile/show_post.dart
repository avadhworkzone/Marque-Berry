import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/view/profile/profile.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:socialv/view/home/components/post_components.dart';

class ShowPost extends StatefulWidget {
  final int index;
  final List<ImagesModel> postList;

  ShowPost({
    Key? key,
    required this.postList,
    required this.index,
  }) : super(key: key);

  @override
  State<ShowPost> createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    return GetBuilder<HomeController>(builder: (homeController) {
      return GetBuilder<CategoryFeedViewModel>(initState: (_) {
        scrollController = ScrollController(
          initialScrollOffset: widget.index * (60.h),
        );
      }, builder: (categoryFeedViewModel) {
        return Scaffold(
          backgroundColor: whiteBlack2E,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(15.w),
            child: CommonAppBar(
              color: ColorUtils.transparent,
              title: 'Posts',
              onTap: () => Get.back(),
            ),
          ),
          body: InViewNotifierList(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            isInViewPortCondition: (double deltaTop, double deltaBottom,
                double viewPortDimension) {
              return deltaTop < (0.5 * viewPortDimension) &&
                  deltaBottom > (0.5 * viewPortDimension);
            },
            itemCount: widget.postList.length,
            builder: (BuildContext context, int index) {
              final categoryIndex = widget.postList[index];
              // final postId = (categoryIndex.id ?? 0);
              return InViewNotifierWidget(
                id: '$index',
                builder: (BuildContext context, bool isInView, Widget? child) {
                  return PostComponents(
                    time: "",
                    postId: 0,
                    userId: 0,
                    title: "Title",
                    likeByMe: "you",
                    likeProfile: [],
                    isInView: isInView,
                    profileImage: "",
                    likeCounter: "1",
                    commentCounter: "0",
                    contentType: "image",
                    userName: "User name",
                    homeController: homeController,
                    contentImage: categoryIndex.image,
                    categoryFeedViewModel: categoryFeedViewModel,
                  );
                },
              );
            },
          ),
        );
      });
    });
  }
}
