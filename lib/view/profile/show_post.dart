import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/model/apiModel/responseModel/user_profile_res_model.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/view/home/components/post_components.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/viewModel/category_view_model.dart';

class ShowPost extends StatefulWidget {
  final int index;
  final List<Posts> postList;
  final String title;

  ShowPost({
    Key? key,
    required this.postList,
    required this.index,
    required this.title,
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

    return GetBuilder<HomeController>(builder: (homeController) {
      return GetBuilder<CategoryFeedViewModel>(initState: (_) {
        scrollController =
            ScrollController(initialScrollOffset: widget.index * (85.h));
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //   scrollController.animateTo(widget.index * (85.h),
        //       duration: Duration(milliseconds: 500), curve: Curves.ease);
        // });
      }, builder: (categoryFeedViewModel) {
        return Scaffold(
          backgroundColor: whiteBlack2E,
          appBar: PreferredSize(
            preferredSize: Size(100.w, 60),
            child: CommonAppBar(
              color: ColorUtils.transparent,
              title: widget.title, //'Posts',
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
              final post = widget.postList[index];
              return InViewNotifierWidget(
                id: '$index',
                builder: (BuildContext context, bool isInView, Widget? child) {
                  return PostComponents(
                    time: "",
                    tagList: [],
                    postId: post.id!,
                    userId: post.userId!,
                    title: post.content ?? '',
                    likeByMe: "you",
                    likeProfile: [],
                    isInView: isInView,
                    profileImage: "",
                    likeCounter: (post.likesCount ?? 0).toString(),
                    commentCounter: (post.commentsCount ?? 0).toString(),
                    contentType: post.contentType!,
                    userName: post.userUsername ?? "N/A",
                    homeController: homeController,
                    contentImage: post.contentUrl ?? "",
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
