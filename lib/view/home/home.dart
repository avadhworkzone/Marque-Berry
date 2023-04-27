import 'dart:convert';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/view/message/message_list.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/view/home/components/tabbar.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/view/home/components/post_components.dart';
import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';

class Home extends StatelessWidget {
  Home({Key? key, required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();
  HomeController homeController = Get.find<HomeController>();

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    Color? black92Blue = Theme.of(context).textTheme.titleLarge?.color;

    return Scaffold(
      backgroundColor: greyFABlack32,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorUtils.transparent,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => scaffoldKey.currentState!.openDrawer(),
          child: CommonImageScale(
            img: IconsWidgets.menuImage,
            scale: 1.w,
            color: blackWhite,
          ),
        ),
        titleSpacing: 0,
        title: CommonImageWidth(
          width: 25.w,
          img: IconsWidgets.adoroTextImages,
        ),
        actions: [
          CommonImageHeightWidth(
            img: IconsWidgets.searchImage,
            width: 7.w,
            height: 7.w,
            color: blackWhite,
          ),
          // SizeConfig.sW2,
          GestureDetector(
            onTap: () => Get.to(
              () => MessageList(),
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
            categoryDataList =
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
                categoryDataList: categoryDataList,
                homeController: homeController,
                categoryFeedViewModel: categoryFeedViewModel,
              ),

              // if (categoryFeedViewModel.categoryApiResponse.status ==
              //         Status.LOADING ||
              //     categoryFeedViewModel.categoryApiResponse.status ==
              //         Status.INITIAL)
              //   Expanded(child: Center(child: Loader())),
              // if (categoryFeedViewModel.categoryApiResponse.status ==
              //         Status.ERROR ||
              //     categoryFeedViewModel.categoryApiResponse.data == null)
              //   Expanded(child: Center(child: SomethingWentWrong())),
              // if (categoryFeedViewModel.categoryApiResponse.status ==
              //     Status.COMPLETE) ...[
              //   Expanded(
              //     child: SingleChildScrollView(
              //       child: Padding(
              //         padding: EdgeInsets.all(4.w),
              //         child: Column(
              //           children: [
              //             ListView.builder(
              //               physics: NeverScrollableScrollPhysics(),
              //               shrinkWrap: true,
              //               itemCount: 2,
              //               itemBuilder: (context, index) {
              //                 return PostComponents();
              //               },
              //             ),
              //             GroupComponents(),
              //           ],
              //         ),
              //       ),
              //     ),
              //   )
              // ]

              GetBuilder<CategoryFeedViewModel>(
                init: CategoryFeedViewModel(),
                initState: (_) {
                  categoryFeedViewModel.pageNumberIndex = 0;
                  categoryFeedViewModel.isPageLoading = false;
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

                  return categoryPostList.isEmpty
                      ? Expanded(
                          child: Center(child: AdoroText("No data available")),
                        )
                      : Expanded(
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                controller: _scrollController,
                                child: Padding(
                                  padding: EdgeInsets.all(4.w),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: categoryPostList.length,
                                    itemBuilder: (context, index) {
                                      final categoryIndex =
                                          categoryPostList[index];
                                      return categoryIndex.id == null
                                          ? SizedBox()
                                          : PostComponents(
                                              contentType:
                                                  categoryIndex.contentType ??
                                                      "Image",
                                              homeController: homeController,
                                              currentTabIndex: homeController
                                                  .tabCurrentIndex,
                                              postid: categoryIndex.id ?? 0,
                                              categoryFeedViewModel:
                                                  categoryFeedViewModel,
                                              likeByMe: categoryIndex.likedByMe
                                                          .toString() ==
                                                      'true'
                                                  ? "You"
                                                  : (categoryIndex
                                                          .likedByPeople?[0]
                                                          .username ??
                                                      ""),
                                              likeProfile:
                                                  categoryIndex.likedByPeople,
                                              likeByMePeople: categoryIndex
                                                      .likedByPeople?.length ??
                                                  0,
                                              profileImage: (categoryIndex
                                                              .author
                                                              ?.isEmpty ??
                                                          true) ==
                                                      true
                                                  ? ""
                                                  : categoryIndex
                                                          .author![0].image ??
                                                      "",
                                              name: (categoryIndex.author
                                                              ?.isEmpty ??
                                                          true) ==
                                                      true
                                                  ? ""
                                                  : categoryIndex
                                                      .author![0].username
                                                      .toString(),
                                              time: postTimeCalculate(
                                                categoryIndex.createdOn,
                                                'ago',
                                              ),
                                              contentImage: categoryIndex
                                                  .contentUrl
                                                  .toString(),
                                              title: categoryIndex.content
                                                  .toString(),
                                              likecounter: (categoryIndex
                                                          .likedByPeople
                                                          ?.length ??
                                                      0)
                                                  .toString(),
                                              commentcounter:
                                                  (categoryIndex.comments ?? 0)
                                                      .toString(),
                                            );
                                    },
                                  ),
                                ),
                              ),
                              if (categoryFeedViewModel.isPageLoading)
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

  void paginationListen(HomeController homeController) {
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!categoryFeedViewModel.isPageLoading) {
          categoryFeedViewModel.categoryTrending(homeController.tabName);
        }

        // if (!homeController.isLoading) {
        //   homeController.changeLoading(!homeController.isLoading);
        // } else {
        //   homeController.changePageNumber(
        //     homeController.pageNumberIndex =
        //         homeController.pageNumberIndex + 1,
        //   );
        //
        //   await categoryFeedViewModel.categoryTrending(
        //     homeController.tabName,
        //     homeController.pageNumberIndex.toString(),
        //   );
        //
        //   if (categoryFeedViewModel.categoryApiResponse.status ==
        //       Status.COMPLETE) {
        //     CategoryResModel categoryResponse =
        //         categoryFeedViewModel.categoryApiResponse.data;
        //
        //     if (categoryResponse.data != null) {
        //       homeController.categoryListUpdate(
        //         categoryResponse.data!,
        //       );
        //     }
        //   }
        // }
      }
    });
  }
}

// GroupComponents(),
class HomeController extends GetxController {
  List tabBarList = [VariableUtils.relevantText, VariableUtils.trendingText];

  String tabName = "relevant";
  void tabNameChange(name) {
    tabName = name;
    update();
  }

  String parentId = "0";
  void parentCommentIdChange(id) {
    parentId = id;
    update();
  }

  int tabCurrentIndex = 0;
  void tabChange(int index) {
    tabCurrentIndex = index;
    update();
  }
}
