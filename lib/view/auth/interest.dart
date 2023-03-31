import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:sizer/sizer.dart';
import 'package:socialv/utils/const_utils.dart';

import '../../commanWidget/custom_btn.dart';
import '../../utils/color_utils.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';

class InterestScreen extends StatelessWidget {
  InterestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GetBuilder<IntrestController>(builder: (intrestController) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeConfig.sH10,
              AdoroText(
                VariableUtils.welcomeToAdoro,
                fontSize: 15.sp,
                color: Theme.of(context).textTheme.subtitle1?.color,
                fontWeight: FontWeight.bold,
              ),
              AdoroText(VariableUtils.chooseOrMoreMemeCategories,
                  color: Theme.of(context).textTheme.subtitle2?.color),
              SizeConfig.sH2,
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: 18,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        logs("INDEX:====> $index");
                        intrestController.addIndex(index);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.w),
                        child: Stack(
                          children: [
                            Container(
                              height: 15.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/Group.png",
                                      ),
                                      colorFilter: ColorFilter.mode(
                                          Colors.white.withOpacity(0.9),
                                          BlendMode.dstATop),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                padding: EdgeInsets.only(top: 21.w, left: 8.w),
                                child: Text("Savage",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            intrestController.selectedIndex.contains(index) ==
                                    false
                                ? SizedBox()
                                : Container(
                                    height: 2.5.h,
                                    width: 5.w,
                                    decoration:
                                        DecorationUtils.welcomeDecoration(
                                            context),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/design.png"),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizeConfig.sH2,
              Center(
                child: intrestController.selectedIndex.length < 6
                    ? CustomBtn(
                        onTap: null,
                        text: 'DONE',
                        decoration: BoxDecoration(color: ColorUtils.black92),
                      )
                    : CustomBtn(
                        onTap: () {
                          // Get.to(InterestScreen());
                        },
                        text: 'DONE',
                      ),
              ),
              SizeConfig.sH2,
            ],
          ),
        );
      }),
    );
  }

  IntrestController intrestController = Get.put(IntrestController());
}

class IntrestController extends GetxController {
  List selectedIndex = [];

  addIndex(index) {
    if (selectedIndex.contains(index) == false) {
      selectedIndex.add(index);
    } else if (selectedIndex.contains(index) == true) {
      selectedIndex.remove(index);
    }
    update();
  }
}
