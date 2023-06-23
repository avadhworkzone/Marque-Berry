import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';

import '../../../utils/assets/images_utils.dart';

class GroupComponents extends StatelessWidget {
  const GroupComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.w),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1.5.w),
          child: Column(
            children: [
              ListTile(
                title: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Paul Molive',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.titleSmall!.color,
                        ),
                      ),
                      TextSpan(
                        text: '\njoined the group group',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.titleMedium!.color,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: AdoroText(
                  '15 min ago',
                  maxLines: 1,
                  fontSize: 9.sp,
                  color: Theme.of(context).textTheme.titleMedium!.color,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: CircleAvatar(
                  radius: 7.w,
                  backgroundImage: AssetImage(IconsWidgets.user1Images),
                ),
                trailing: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.w),
                  child: Container(
                    height: 60.w,
                    width: Get.width,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 30.w,
                              width: Get.width,
                              child: ClipRRect(
                                child: Image.asset(
                                  IconsWidgets.post2Images,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.grey[200], // Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 30.w,
                                    width: Get.width / 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(5.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AdoroText(
                                            "Friends Party!",
                                            fontSize: 13.sp,
                                            fontWeight:
                                                FontWeightClass.fontWeight700,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                IconsWidgets.publicGroupImages,
                                                scale: 1.w,
                                              ),
                                              SizeConfig.sW3,
                                              AdoroText(
                                                "Public Group",
                                                color: ColorUtils.black92,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                IconsWidgets.publicGroupImages,
                                                scale: 1.w,
                                              ),
                                              SizeConfig.sW3,
                                              AdoroText(
                                                "Members.3.5K",
                                                color: ColorUtils.black92,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 22.w,
                          left: 5.w,
                          child: Container(
                            height: 25.w,
                            width: 25.w,
                            child: Image.asset(IconsWidgets.post3Images),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizeConfig.sH3,
            ],
          ),
        ),
      ),
    );
  }
}
