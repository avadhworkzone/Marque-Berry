// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/utils/const_utils.dart' as categoryList;

import '../../../viewModel/category_view_model.dart';

class TabBarComponents extends StatelessWidget {
  HomeController homeController;

  List<categoryList.Category> categoryDataList;

  CategoryFeedViewModel categoryFeedViewModel;

  TabBarComponents({
    Key? key,
    required this.homeController,
    required this.categoryDataList,
    required this.categoryFeedViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.sp,
      // color: Colors.green,
      alignment: Alignment.center,
      child: ListView.builder(
        controller: homeController.tabScrollController,
        itemCount: 2 + categoryDataList.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                if (index == 0) {
                  homeController.tabNameChange("relevant");
                  categoryFeedViewModel.pageNumberIndex = 0;
                  categoryFeedViewModel.isPageLoading = false;
                  await categoryFeedViewModel.categoryTrending("relevant");
                  // if (categoryFeedViewModel.categoryApiResponse.status ==
                  //     Status.COMPLETE) {
                  //   CategoryResModel categoryResponse =
                  //       categoryFeedViewModel.categoryApiResponse.data;
                  //   if (categoryResponse.data != null) {
                  //     homeController.categoryListUpdate(
                  //       categoryResponse.data!,
                  //     );
                  //   }
                  // }
                } else if (index == 1) {
                  homeController.tabNameChange("trending");
                  categoryFeedViewModel.pageNumberIndex = 0;
                  categoryFeedViewModel.isPageLoading = false;
                  await categoryFeedViewModel.categoryTrending("trending");
                  // if (categoryFeedViewModel.categoryApiResponse.status ==
                  //     Status.COMPLETE) {
                  //   CategoryResModel categoryResponse =
                  //       categoryFeedViewModel.categoryApiResponse.data;
                  //   if (categoryResponse.data != null) {
                  //     homeController.categoryListUpdate(
                  //       categoryResponse.data!,
                  //     );
                  //   }
                  // }
                } else {
                  homeController.tabNameChange(
                    categoryDataList[index - 2].name,
                  );
                  categoryFeedViewModel.pageNumberIndex = 0;
                  categoryFeedViewModel.isPageLoading = false;
                  await categoryFeedViewModel.categoryTrending(
                    categoryDataList[index - 2].name.toString(),
                  );
                  // if (categoryFeedViewModel.categoryApiResponse.status ==
                  //     Status.COMPLETE) {
                  //   CategoryResModel categoryResponse =
                  //       categoryFeedViewModel.categoryApiResponse.data;
                  //   if (categoryResponse.data != null) {
                  //     homeController.categoryListUpdate(
                  //       categoryResponse.data!,
                  //     );
                  //   }
                  // }
                }
              });
              homeController.tabChange(index);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: index == 0 ? 2.w : 0),
              /* padding: EdgeInsets.fromLTRB(
                index == 0 ? 2.w : 0.5.w,
                2.5.w,
                index == 4 ? 2.w : 0.5.w,
                2.5.w,
              ),
              child: Container(
                height: 14.w,
                width: 28.w,
                decoration: homeController.tabCurrentIndex == index
                    ? DecorationUtils.buttonDecoration(context)
                    : BoxDecoration(),
                child: Center(
                  child: AdoroText(
                    index == 0 || index == 1
                        ? homeController.tabBarList[index]
                        : categoryDataList[index - 2].name,
                    color: homeController.tabCurrentIndex == index
                        ? ColorUtils.white
                        : ColorUtils.black92,
                    fontWeight: FontWeightClass.fontWeight600,
                  ),
                ),
              ),*/
              child: homeController.tabCurrentIndex != index
                  ? AdoroText(
                      index == 0 || index == 1
                          ? homeController.tabBarList[index]
                          : categoryDataList[index - 2].name,
                      color: homeController.tabCurrentIndex == index
                          ? ColorUtils.white
                          : ColorUtils.black92,
                      fontSize: 14.sp,
                      fontWeight: FontWeightClass.fontWeight500,
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GradientText(
                          index == 0 || index == 1
                              ? homeController.tabBarList[index]
                              : categoryDataList[index - 2].name,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeightClass.fontWeight700),
                          colors: [
                            ColorUtils.linearGradient7,
                            ColorUtils.linearGradient4,
                            ColorUtils.linearGradient5,
                            ColorUtils.linearGradient8,
                          ],
                        ),
                        SizeConfig.sH05,
                        Container(
                          width: (index == 0 || index == 1
                              ? homeController.tabBarList[index]
                              : categoryDataList[index - 2].name)
                              .toString()
                              .length *
                              8.5.sp,
                          height: 2,
                          decoration: DecorationUtils.welcomeDecoration(context),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
