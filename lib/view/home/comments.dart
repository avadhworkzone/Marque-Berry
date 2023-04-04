import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/custom_text_field.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/validation_utils.dart';
import 'package:socialv/view/home/comment_components/comment_list_components.dart';

import '../../commanWidget/common_appbar.dart';

class Comments extends StatelessWidget {
  Comments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorUtils.grey[200],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(22.w),
            child: CommonAppBar(title: 'Comments', color: ColorUtils.grey[200]),
          ),
          // SizeConfig.sH2,
          Expanded(
            child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: commentsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CommentList(
                        likecount: commentsList[index]["likecount"],
                        replaycount: commentsList[index]["replaycount"],
                        time: commentsList[index]["time"],
                        name: commentsList[index]["name"],
                        img: commentsList[index]["img"],
                        mentione: commentsList[index]["mentione"],
                        replayData: commentsList[index]["replayData"],
                        message: commentsList[index]["message"],
                      ),
                      for (int i = 0;
                          i < commentsList[index]["replaycount"];
                          i++)
                        Container(
                          width: 75.w,
                          padding: EdgeInsets.only(bottom: 2.5.w, top: 2.5.w),
                          child: CommentList(
                            img: "assets/icons/user3.png",
                            name: 'con Trariweis',
                            time: "2W",
                            message: "Follow us for more update",
                            likecount: "10",
                            replaycount: 2,
                            mentione: '',
                            replayData: true,
                          ),
                        ),
                      SizeConfig.sH1,
                      DecorationUtils.dividerLine2(),
                      SizeConfig.sH1,
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              height: 18.w,
              width: Get.width,
              color: ColorUtils.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 6.w,
                      child: Image.asset(
                        "assets/icons/user4.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizeConfig.sW3,
                    Expanded(
                      child: CommonTextFormField(
                        validator: () {},
                        color: Colors.black,
                        hintText: 'write a comment...',
                        hintStyle: TextStyle(
                          color: ColorUtils.black92,
                          fontSize: 12.sp,
                        ),
                        controller: controller,
                        denyInputFormatters:
                            RegularExpression.onlyFirstSpaceNoAllowPattern,
                        allowInputFormatters:
                            RegularExpression.nameKeyboardPattern,
                      ),
                    ),
                    SizeConfig.sW1,
                    TextButton(
                      onPressed: () {},
                      child: AdoroText('Reply', color: ColorUtils.blueB9),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  var controller = TextEditingController();

  List<Map<String, dynamic>> commentsList = [
    {
      "likecount": "19",
      "replaycount": 0,
      "time": "8 min ago",
      "name": 'Jane_Cooper',
      "img": "assets/icons/user1.png",
      "mentione": "@ira_membrit",
      "replayData": false,
      "message":
          'Loving 😍 your work and profile 👨 Top Marks. Once you are confident enough to develop',
    },
    {
      "img": "assets/icons/user2.png",
      "name": 'con Trariweis',
      "time": "6 min ago",
      "message": 'Nice 👌 Work, love your content ',
      "likecount": "19",
      "replaycount": 1,
      "mentione": '',
      "replayData": false,
    },
  ];
}

/// device show kar
/// done ok
