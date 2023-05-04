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

class ShowMentions extends StatefulWidget {
  final List<ImagesModel> mentionsList;
  ShowMentions({Key? key, required this.mentionsList}) : super(key: key);

  @override
  State<ShowMentions> createState() => _ShowMentionsState();
}

class _ShowMentionsState extends State<ShowMentions> {
  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;

    return GetBuilder<HomeController>(builder: (homeController) {
      return GetBuilder<CategoryFeedViewModel>(
          builder: (categoryFeedViewModel) {
        return Scaffold(
          backgroundColor: greyFABlack32,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(15.w),
            child: CommonAppBar(
              color: ColorUtils.transparent,
              title: 'Mentions',
              onTap: () => Get.back(),
            ),
          ),
          body: InViewNotifierList(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            isInViewPortCondition: (double deltaTop, double deltaBottom,
                double viewPortDimension) {
              return deltaTop < (0.5 * viewPortDimension) &&
                  deltaBottom > (0.5 * viewPortDimension);
            },
            itemCount: widget.mentionsList.length,
            builder: (BuildContext context, int index) {
              final categoryIndex = widget.mentionsList[index];
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
