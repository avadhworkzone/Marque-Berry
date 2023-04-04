import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/view/home/comments.dart';

class PostComponents extends StatelessWidget {
  const PostComponents({Key? key}) : super(key: key);

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
                title: AdoroText(
                  'Ira Membrit',
                  maxLines: 1,
                  fontSize: 12.sp,
                  color: Theme.of(context).textTheme.titleSmall!.color,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeightClass.fontWeight600,
                ),
                subtitle: AdoroText(
                  '2 min ago',
                  maxLines: 1,
                  fontSize: 9.sp,
                  color: Theme.of(context).textTheme.titleMedium!.color,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: CircleAvatar(
                  radius: 7.w,
                  backgroundImage: AssetImage("assets/icons/user1.png"),
                ),
                trailing: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).textTheme.titleMedium?.color,
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
                      color: Theme.of(context).textTheme.titleMedium?.color,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizeConfig.sH2,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2.w),
                      child: Container(
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
                        CommonImageScale(
                          img: IconsWidgets.heartImage,
                          scale: 1.w,
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        ),
                        SizeConfig.sW2,
                        InkWell(
                          onTap: () {
                            Get.to(() => Comments());
                          },
                          child: CommonImageScale(
                            img: IconsWidgets.chatImage,
                            scale: 0.8.w,
                            color:
                                Theme.of(context).textTheme.titleMedium?.color,
                          ),
                        ),
                        SizeConfig.sW2,
                        CommonImageScale(
                          img: IconsWidgets.sendImage,
                          scale: 1.w,
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        ),
                        Spacer(),
                        AdoroText(
                          "0 Comments",
                          fontSize: 10.sp,
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        )
                      ],
                    ),
                    SizeConfig.sH1,
                    DecorationUtils.dividerLine2(),
                    SizeConfig.sH1,
                    Container(
                      width: Get.width,
                      child: Row(
                        children: [
                          Container(
                            width: 24 * 3,
                            height: 24,
                            child: Stack(
                              children: List.generate(
                                3,
                                (index) => Positioned(
                                  left: (2 - index) * 18,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    // margin: EdgeInsets.only(left: 18 * 2),
                                    child: Image.asset(
                                      "assets/icons/user2.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(fontSize: 9.sp),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'Liked by ',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Ms.mountain',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' And ',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '110 other',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizeConfig.sH1,
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
