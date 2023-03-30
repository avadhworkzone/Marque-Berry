import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';

class PostComponents extends StatelessWidget {
  const PostComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.w),
      child: Container(
        decoration: BoxDecoration(
          color: ColorUtils.white,
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
                title: AdoroText(
                  'Ira Membrit',
                  maxLines: 1,
                  fontSize: 12.sp,
                  color: ColorUtils.black2E,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeightClass.fontWeight600,
                ),
                subtitle: AdoroText(
                  '2 min ago',
                  maxLines: 1,
                  fontSize: 9.sp,
                  color: ColorUtils.black92,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: CircleAvatar(
                  radius: 7.w,
                  // backgroundColor: ColorUtils.linearGradient1,
                  backgroundImage: AssetImage("assets/icons/user1.png"),
                ),

                // Icon(
                //   Icons.more_horiz,
                //   color: Color(0xff6F7F92),
                // ),
                trailing: Icon(
                  Icons.more_horiz,
                  color: Color(0xff6F7F92),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                child: Column(
                  children: [
                    SizeConfig.sH1,
                    AdoroText(
                      "The great thing about reaching the top of the mountain is realising that there’s space space",
                      maxLines: 2,
                      color: ColorUtils.black92,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizeConfig.sH2,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2.w),
                      child: Container(
                        color: Colors.red,
                        height: 60.w,
                        width: Get.width,
                        child: Image.asset(
                          "assets/icons/post1.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizeConfig.sH2,
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/heart.png",
                          scale: 1.w,
                        ),
                        SizeConfig.sW2,
                        Image.asset(
                          "assets/icons/chat.png",
                          scale: 0.8.w,
                        ),
                        SizeConfig.sW2,
                        Image.asset(
                          "assets/icons/send.png",
                          scale: 1.w,
                        ),
                        Spacer(),
                        AdoroText(
                          "0 Comments",
                          fontSize: 10.sp,
                          color: ColorUtils.black92,
                        )
                      ],
                    ),
                    SizeConfig.sH1,
                    DecorationUtils.dividerLine2(),
                    Row(
                      children: [
                        Stack(
                          children: [
                            "assets/icon/user2.png",
                            "assets/icon/user3.png",
                            "assets/icon/user4.png"
                          ].map(
                            (e) {
                              return Container(
                                  width: 24,
                                  height: 24,
                                  margin: EdgeInsets.only(left: 18 * 2),
                                  child: AdoroText(e.removeAllWhitespace)
                                  // Image.asset(
                                  //   "assets/icons/user2.png",
                                  //   fit: BoxFit.cover,
                                  // ),
                                  );
                            },
                          ).toList(),
                        ),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(fontSize: 9.sp),
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Liked by ',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Ms.mountain',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: ColorUtils.black92,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' And ',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '110 other',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: ColorUtils.black92,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                        // "Liked by ms.mountain and 1,10 others",
                        // fontSize: 9.sp,
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
