import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/utils/font_style_utils.dart';

import '../../utils/color_utils.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../utils/tecell_text.dart';
import '../../utils/variable_utils.dart';

class SharePost extends StatefulWidget {
  SharePost({Key? key}) : super(key: key);

  @override
  State<SharePost> createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  String dropdownvalue = '';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  final bottomBarController = Get.find<BottomBarController>();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizeConfig.sH2,
                Row(
                  children: [
                    SizeConfig.sH2,
                    IconButton(
                      onPressed: () {
                        bottomBarController.pageChange(0);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).textTheme.titleSmall?.color,
                        size: 4.h,
                      ),
                    ),
                    AdoroText(VariableUtils.sharePost,
                        color: Theme.of(context).textTheme.titleSmall?.color,
                        fontSize: 15.sp,
                        fontWeight: FontWeightClass.fontWeightBold),
                    SizeConfig.sW18,
                    Container(
                      height: 5.h,
                      width: 30.w,
                      decoration: DecorationUtils.welcomeDecoration(context),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(VariableUtils.Post,
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
                SizeConfig.sH3,
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10.w,
                      child:
                          Image(image: AssetImage("assets/images/profile.png")),
                    ),
                    SizeConfig.sW4,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdoroText(VariableUtils.ritikRaj,
                            color:
                                Theme.of(context).textTheme.titleSmall?.color,
                            fontSize: 15.sp,
                            fontWeight: FontWeightClass.fontWeightBold),
                        SizeConfig.sH1,
                        Container(
                          height: 4.h,
                          width: 35.w,
                          decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.w))),
                          child: Row(
                            children: [
                              SizeConfig.sW2,
                              Icon(Icons.add_box_outlined),
                              SizeConfig.sW5,
                              DropdownButton(
                                hint: Text(
                                    dropdownvalue == ""
                                        ? "select"
                                        : dropdownvalue,
                                    style: TextStyle(
                                        color: ColorUtils.black,
                                        fontWeight: FontWeight.bold)),
                                // value: dropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items,
                                        style: TextStyle(
                                            color: ColorUtils.black,
                                            fontWeight: FontWeight.bold)),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizeConfig.sH5,
                AdoroText(VariableUtils.whatYouWantToTalkAbout,
                    // color: ColorUtils.black92,
                    color: Theme.of(context).textTheme.titleSmall?.color,
                    fontSize: 13.sp,
                    fontWeight: FontWeightClass.fontWeight600),
                SizeConfig.sH2,
                CommonTextFieldContainer(
                  minLines: 6,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  color: ColorUtils.note,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(
                      bottom: 35.w,
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.close,
                          // color: Theme.of(context).appBarTheme.iconTheme?.color,
                          //iconTheme
                          size: 3.h,
                        )),
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 40.w, right: 5.w),
                    child: Icon(
                      Icons.person_add_alt_sharp,
                      color: ColorUtils.black92,
                    ),
                  ),
                ),
                SizeConfig.sH10,
                UploadPhoto()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UploadPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
            color: Theme.of(context).textTheme.titleSmall?.color, thickness: 1),
        Row(
          children: [
            Icon(
              Icons.photo_outlined,
              color: Theme.of(context).textTheme.titleSmall?.color,
            ),
            AdoroText(VariableUtils.uploadAPhoto,
                color: Theme.of(context).textTheme.titleSmall?.color,
                fontSize: 11.sp,
                fontWeight: FontWeightClass.fontWeight600),
          ],
        ),
        Divider(
            color: Theme.of(context).textTheme.titleSmall?.color, thickness: 1),
        Row(
          children: [
            Icon(
              Icons.ondemand_video_sharp,
              color: Theme.of(context).textTheme.titleSmall?.color,
            ),
            AdoroText(VariableUtils.uploadAVideo,
                color: Theme.of(context).textTheme.titleSmall?.color,
                fontSize: 11.sp,
                fontWeight: FontWeightClass.fontWeight600),
          ],
        ),
        Divider(
            color: Theme.of(context).textTheme.titleSmall?.color, thickness: 1),
        Row(
          children: [
            Icon(
              Icons.gif_box,
              color: Theme.of(context).textTheme.titleSmall?.color,
            ),
            AdoroText(VariableUtils.uploadAGIF,
                color: Theme.of(context).textTheme.titleSmall?.color,
                fontSize: 11.sp,
                fontWeight: FontWeightClass.fontWeight600),
          ],
        ),
        Divider(
            color: Theme.of(context).textTheme.titleSmall?.color, thickness: 1),
        Row(
          children: [
            Icon(
              Icons.tag_faces,
              color: Theme.of(context).textTheme.titleSmall?.color,
            ),
            AdoroText(VariableUtils.chooseATemplate,
                color: Theme.of(context).textTheme.titleSmall?.color,
                fontSize: 11.sp,
                fontWeight: FontWeightClass.fontWeight600),
          ],
        ),
        Divider(
            color: Theme.of(context).textTheme.titleSmall?.color, thickness: 1),
        Row(
          children: [
            Icon(
              Icons.person_add_alt_sharp,
              color: Theme.of(context).textTheme.titleSmall?.color,
            ),
            AdoroText(VariableUtils.tagAFriend,
                color: Theme.of(context).textTheme.titleSmall?.color,
                fontSize: 11.sp,
                fontWeight: FontWeightClass.fontWeight600),
          ],
        ),
      ],
    );
  }
}
