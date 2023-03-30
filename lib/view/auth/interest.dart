import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:sizer/sizer.dart';

import '../../utils/size_config_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';

class InterestScreen extends StatelessWidget {
  const InterestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
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
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(2.w),
                    child: Container(
                      // height: 10.h,
                      // width: 20.w,
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
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
