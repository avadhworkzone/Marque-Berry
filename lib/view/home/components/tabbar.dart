// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/adoro_text.dart';
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
      height: 17.w,
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: 2 + categoryDataList.length,
        scrollDirection: Axis.horizontal,
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
              padding: EdgeInsets.fromLTRB(
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
              ),
            ),
          );
        },
      ),
    );
  }
}
