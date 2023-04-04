import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/tecell_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/view/home/comment_components/like_components.dart';
import 'package:socialv/view/home/comment_components/replay_button.dart';

class CommentList extends StatelessWidget {
  String img;
  String time;
  String name;
  String message;
  String mentione;
  String likecount;
  int replaycount = 0;
  bool replayData = false;

  CommentList({
    Key? key,
    required this.img,
    required this.name,
    required this.time,
    required this.message,
    required this.likecount,
    required this.replaycount,
    required this.replayData,
    required this.mentione,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: replayData == false ? 8.w : 6.w,
                backgroundImage: AssetImage(
                  img,
                ),
              ),
              title: AdoroText(
                "$name",
                maxLines: 1,
                fontSize: 13.sp,
                color: ColorUtils.black,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeightClass.fontWeight700,
              ),
              trailing: AdoroText(
                "$time",
                fontSize: 10.sp,
                color: ColorUtils.black92,
              ),
            ),
            SizeConfig.sH1,
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
                children: [
                  TextSpan(
                    text: "$message",
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: ColorUtils.black92,
                      fontWeight: FontWeightClass.fontWeight600,
                    ),
                  ),
                  if (mentione.isNotEmpty)
                    TextSpan(
                      text: " $mentione",
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: ColorUtils.blueB9,
                        fontWeight: FontWeightClass.fontWeight500,
                      ),
                    ),
                ],
              ),
            ),
            SizeConfig.sH2,
            Row(
              children: [
                SizeConfig.sW2,
                LikeButton(likecounter: likecount),
                SizeConfig.sW2,
                ReplayButton(replaycount: replaycount),
              ],
            ),
          ],
        ),
      ),
    );
  }
}