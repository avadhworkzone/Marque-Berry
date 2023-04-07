import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/view/home/home.dart';
import 'package:socialv/utils/const_utils.dart' as categoryList;

class TabBarComponents extends StatelessWidget {
  HomeController homeController;

  List<categoryList.Category> categoryDataList;

  TabBarComponents(
      {Key? key, required this.homeController, required this.categoryDataList})
      : super(key: key);

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
            onTap: () => homeController.tabChange(index),
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
