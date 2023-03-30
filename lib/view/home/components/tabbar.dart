import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/view/home/home.dart';

class TabBarComponents extends StatelessWidget {
  HomeController homeController;

  TabBarComponents({Key? key, required this.homeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17.w,
      child: ListView.builder(
        itemCount: homeController.tabBarList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            children: [
              GestureDetector(
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
                        homeController.tabBarList[index],
                        color: homeController.tabCurrentIndex == index
                            ? ColorUtils.white
                            : ColorUtils.black92,
                        fontWeight: FontWeightClass.fontWeight600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
