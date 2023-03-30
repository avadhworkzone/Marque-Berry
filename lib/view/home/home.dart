import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/common_drawer.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/view/home/components/group_components.dart';
import 'package:socialv/view/home/components/post_components.dart';
import 'package:socialv/view/home/components/tabbar.dart';
import '../../utils/tecell_text.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA).withOpacity(0.5),
      drawer: MyDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorUtils.greyFA,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              child: IconsWidgets.drawerImage,
              onTap: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        title: Image.asset(
          "assets/icons/adoro_text.png",
          width: 25.w,
          // height: 20.w,
        ),
        actions: [
          GestureDetector(child: IconsWidgets.searchImage),
          SizeConfig.sW3,
          GestureDetector(child: IconsWidgets.messageImage),
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
  List tabBarList = ["Relevant", "Trending", "Fresh", "News", "dank"];

  int tabCurrentIndex = 0;
  void tabChange(int index) {
    tabCurrentIndex = index;
    update();
  }
}
