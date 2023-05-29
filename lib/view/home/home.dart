// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/view/home/components/video_components.dart';
import 'package:socialv/view/message/message_list.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/view/home/components/tabbar.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:socialv/view/home/components/post_components.dart';
import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';

import 'search_user.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.find<HomeController>();
  ScrollController _scrollController = ScrollController();

  void paginationListen(HomeController homeController) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!categoryFeedViewModel.isPageLoading) {
          categoryFeedViewModel.categoryTrending(homeController.tabName);
        }
      }
    });
  }

  CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;

    return Scaffold(
      backgroundColor: greyFABlack32,
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: ColorUtils.transparent,
        leading: Padding(
          padding: EdgeInsets.all(1.2.w),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.w),
            onTap: () => widget.scaffoldKey.currentState!.openDrawer(),
            child: CommonImageScale(
              img: IconsWidgets.menuImage,
              scale: 1.w,
              color: blackWhite,
            ),
          ),
        ),
        title: CommonImageWidth(
          width: 25.w,
          img: IconsWidgets.adoroTextImages,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => SearchUser());
            },
            child: CommonImageHeightWidth(
              img: IconsWidgets.searchImage,
              width: 7.w,
              height: 7.w,
              color: blackWhite,
            ),
          ),
          GestureDetector(
            onTap: () => Get.to(
              () => MessageList(),
              transition: Transition.rightToLeft,
              duration: Duration(milliseconds: 400),
            ),
            child: CommonImageHeightWidth(
              img: IconsWidgets.messageImage,
              width: 8.w,
              height: 8.w,
              color: blackWhite,
            ),
          ),
          SizeConfig.sW3,
        ],
      ),
      body: GetBuilder<HomeController>(
        initState: (_) {
          if (PreferenceUtils.getCategory().isNotEmpty) {
            selectedCategoryDataList =
                (jsonDecode(PreferenceUtils.getCategory()) as List)
                    .map((e) => Category.fromJson(e))
                    .toList();
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) async {
                await categoryFeedViewModel.categoryTrending(
                  homeController.tabName,
                );
              },
            );
          }
        },
        builder: (homeController) {
          return Column(
            children: [
              TabBarComponents(
                categoryDataList: selectedCategoryDataList,
                homeController: homeController,
                categoryFeedViewModel: categoryFeedViewModel,
              ),
              GetBuilder<CategoryFeedViewModel>(
                init: CategoryFeedViewModel(),
                initState: (_) {
                  categoryFeedViewModel.initCall();
                  // categoryFeedViewModel.isPageLoading = false;
                  paginationListen(homeController);
                },
                builder: (categoryFeedViewModel) {
                  if (categoryFeedViewModel.categoryApiResponse.status ==
                          Status.LOADING ||
                      categoryFeedViewModel.categoryApiResponse.status ==
                          Status.INITIAL) {
                    return Expanded(child: Center(child: Loader()));
                  } else if (categoryFeedViewModel.categoryApiResponse.status ==
                          Status.ERROR ||
                      categoryFeedViewModel.categoryApiResponse.data == null) {
                    return Expanded(child: Center(child: SomethingWentWrong()));
                  }

                  List<CategoryData> categoryPostList =
                      categoryFeedViewModel.categoryPostList;

                  return Expanded(
                    child: categoryPostList.isEmpty
                        ? Center(
                            child: AdoroText(VariableUtils.noDataFound),
                          )
                        : Stack(
                            children: [
                              InViewNotifierList(
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                isInViewPortCondition: (double deltaTop,
                                    double deltaBottom,
                                    double viewPortDimension) {
                                  return deltaTop < (0.5 * viewPortDimension) &&
                                      deltaBottom > (0.5 * viewPortDimension);
                                },
                                itemCount: categoryPostList.length,
                                builder: (BuildContext context, int index) {
                                  final categoryIndex = categoryPostList[index];
                                  final postId = (categoryIndex.id ?? 0);
                                  return LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      return InViewNotifierWidget(
                                        id: '$index',
                                        builder: (BuildContext context,
                                            bool isInView, Widget? child) {
                                          if (postId == 0) {
                                            return SizedBox();
                                          }
                                          return homeController.reportList
                                                      .contains(postId) ==
                                                  false
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      top: index == 0 ? 10 : 0),
                                                  child: PostComponents(
                                                    isInView: isInView,
                                                    userId: int.parse(
                                                        categoryIndex.userId
                                                            .toString()),
                                                    contentType: categoryIndex
                                                            .contentType ??
                                                        "image",
                                                    homeController:
                                                        homeController,
                                                    postId:
                                                        categoryIndex.id ?? 0,
                                                    categoryFeedViewModel:
                                                        categoryFeedViewModel,
                                                    likeByMe: categoryIndex
                                                                .likedByMe
                                                                .toString() ==
                                                            'true'
                                                        ? "You"
                                                        : (categoryIndex
                                                                .likedByPeople?[
                                                                    0]
                                                                .username ??
                                                            ""),
                                                    likeProfile: categoryIndex
                                                        .likedByPeople,
                                                    profileImage:
                                                        categoryIndex.image ??
                                                            "",
                                                    userName: categoryIndex
                                                            .username ??
                                                        "",
                                                    time: postTimeCalculate(
                                                      categoryIndex.createdOn,
                                                      'ago',
                                                    ),
                                                    contentImage: categoryIndex
                                                        .contentUrl
                                                        .toString(),
                                                    title: categoryIndex.content
                                                        .toString(),
                                                    // title: (categoryIndex.id ?? 0)
                                                    //     .toString(),
                                                    likeCounter: (categoryIndex
                                                                .likedByPeople
                                                                ?.length ??
                                                            0)
                                                        .toString(),
                                                    commentCounter:
                                                        (categoryIndex
                                                                    .comments ??
                                                                0)
                                                            .toString(),
                                                  ),
                                                )
                                              : SizedBox();
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                              if (categoryFeedViewModel.isPageLoading ||
                                  categoryFeedViewModel
                                          .reportPostApiResponse.status ==
                                      Status.LOADING)
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Loader(),
                                  ),
                                ),
                            ],
                          ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}

// GroupComponents(),
class HomeController extends GetxController {
  ScrollController tabScrollController = ScrollController();
  List tabBarList = [VariableUtils.relevantText, VariableUtils.trendingText];

  void animateTabScroll(double pos) {
    tabScrollController.animateTo(pos,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  String tabName = "relevant";

  void tabNameChange(name) {
    tabName = name;
    update();
  }

  String parentId = "0";

  void parentCommentIdChange(String id) {
    parentId = id;
    update();
  }

  int tabCurrentIndex = 0;

  void tabChange(int index) {
    tabCurrentIndex = index;
    update();
  }

  bool isReportSuccess = false;

  void reportSuccess(val) {
    isReportSuccess = val;
    update();
  }

  List reportList = [];

  void addReport(int postId) {
    logs('POST ID ====>$postId');
    reportList.add(postId);
    update();
  }

  Map<String, bool> followUnfollow = {};

  void setFollowData(String postId, bool followStatus) {
    if (followUnfollow.containsKey(postId)) {
      followUnfollow[postId] = followStatus;
    } else {
      followUnfollow.addAll({postId: followStatus});
    }
    update();
  }

  void clearFollowData() {
    followUnfollow.clear();
    update();
  }
}
