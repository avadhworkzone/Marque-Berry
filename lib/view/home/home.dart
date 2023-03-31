import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/commanWidget/common_drawer.dart';
import 'package:socialv/view/home/components/tabbar.dart';
import 'package:socialv/view/home/components/group_components.dart';
import 'package:socialv/view/home/components/post_components.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

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
      body: GetBuilder<HomeController>(
        builder: (homeController) {
          return Column(
            children: [
              TabBarComponents(homeController: homeController),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      children: [
                        PostComponents(),
                        GroupComponents(),
                      ],
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

class HomeController extends GetxController {
  List tabBarList = [
    VariableUtils.relevantText,
    VariableUtils.trendingText,
    VariableUtils.freshText,
    VariableUtils.newsText,
    VariableUtils.dankText
  ];

  int tabCurrentIndex = 0;
  void tabChange(int index) {
    tabCurrentIndex = index;
    update();
  }
}
