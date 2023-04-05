import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

import '../../commanWidget/common_appbar.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorUtils.greyFA,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.w),
        child: CommonAppBar(title: '', ontap: () => Get.back()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              color: ColorUtils.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                    child: Image.asset('assets/images/Profile1.png')),
                title: AdoroText(
                  'Brand Name',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: AdoroText(
                  'Time Left : XX:YY',
                  color: ColorUtils.black92,
                  fontSize: 12.sp,
                ),
              ),
              SizeConfig.sH1,
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(1.w),
                          child: AdoroText(
                            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequatduis enim velit mollit...',
                            color: ColorUtils.black92,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.w, left: 5.w, right: 5.w),
                child: Container(
                  height: 6.h,
                  width: size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorUtils.linearGradient1,
                          ColorUtils.linearGradient6,
                          ColorUtils.linearGradient7
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(4.w))),
                  child: Center(
                    child: AdoroText(
                      'APPLY NOW',
                      color: ColorUtils.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
