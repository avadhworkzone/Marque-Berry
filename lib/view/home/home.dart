import 'dart:convert';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/commanWidget/common_drawer.dart';
import 'package:socialv/view/home/components/tabbar.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/view/home/components/post_components.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: MyDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              child: CommonImageWidth(
                img: IconsWidgets.drawerImage,
                width: 25.w,
                color: Theme.of(context).textTheme.titleSmall!.color,
              ),
              onTap: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        title: Image.asset(
          "assets/icons/adoro_text.png",
          width: 25.w,
        ),
        actions: [
          // GestureDetector(child: IconsWidgets.searchImage),
          GestureDetector(
            child: CommonImageHeightWidth(
              img: IconsWidgets.searchImage,
              width: 7.w,
              height: 7.w,
              color: Theme.of(context).textTheme.titleSmall!.color,
            ),
            // IconsWidgets.messageImage,
          ),
          SizeConfig.sW3,
          GestureDetector(
            child: CommonImageHeightWidth(
              img: IconsWidgets.messageImage,
              width: 7.w,
              height: 7.w,
              color: Theme.of(context).textTheme.titleSmall!.color,
            ),
          ),
          SizeConfig.sW6,
        ],
      ),
      body: GetBuilder<HomeController>(initState: (_) {
        if (PreferenceUtils.getCategory().isNotEmpty) {
          categoryDataList = (jsonDecode(PreferenceUtils.getCategory()) as List)
              .map((e) => Category.fromJson(e))
              .toList();
        }
      }, builder: (homeController) {
        return Column(
          children: [
            TabBarComponents(
              categoryDataList: categoryDataList,
              homeController: homeController,
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
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                  await categoryFeedViewModel.categoryTrending("trending");
                });
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
                List<CategoryResModel> categoryResponse =
                    categoryFeedViewModel.categoryApiResponse.data;

                return Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categoryResponse.length,
                        itemBuilder: (context, index) {
                          final postdata = categoryResponse[index];
                          return postdata.id == null
                              ? SizedBox()
                              : PostComponents(
                                  postid: postdata.postId.toString(),
                                  categoryFeedViewModel: categoryFeedViewModel,
                                  likeByMe: postdata.likedByMe.toString() ==
                                          'true'
                                      ? "You"
                                      : (postdata.likedByPeople?[0].username ??
                                          ""),
                                  likeProfile: postdata.likedByPeople,
                                  likeByMePeople: postdata.noOfLikes,
                                  profileImage:
                                      postdata.author![0].image.toString(),
                                  name: postdata.author![0].username.toString(),
                                  time: postTimeCalculate(postdata.createdOn),
                                  contentImage: postdata.contentUrl.toString(),
                                  title: postdata.content.toString(),
                                  likecounter: postdata.noOfLikes.toString(),
                                  commentcounter: postdata.noOfLikes.toString(),
                                );
                        },
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        );
      }),
    );
  }
}

// GroupComponents(),
class HomeController extends GetxController {
  List tabBarList = [VariableUtils.relevantText, VariableUtils.trendingText];

  int tabCurrentIndex = 0;
  void tabChange(int index) {
    tabCurrentIndex = index;
    update();
  }

  // setPreference() async {
  //   for (int i = 0; i < PreferenceUtils.getCategory().length; i++) {
  //     logs(PreferenceUtils.getCategory()[i].name.toString());
  //   }
  // }
}
