import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/model/apiModel/responseModel/user_profile_res_model.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/view/profile/following_screen.dart';
import 'package:socialv/view/profile/show_post.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({
    super.key,
    required this.profileResModel,
  });

  final UserProfileResModel profileResModel;

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    final profile = profileResModel.data!.first;
    return Container(
      height: 22.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          richTextColumn(
            black92White,
            blackWhite,
            title: "Posts",
            value: profile.postsCount.toString(),
            onTap: (){}
          ),
          richTextColumn(black92White, blackWhite,
              title: "Followers",
              value: profile.followersCount.toString(), onTap: () {
            Get.to(
              () => FollowerFollowing(
                followingCounter: 1,
                title: 'Followers',
                userId: profile.id.toString(),
              ),
            );
          }),
          richTextColumn(black92White, blackWhite,
              title: "Following",
              value: profile.followingCount.toString(), onTap: () {
            Get.to(
              () => FollowerFollowing(
                followingCounter: 0,
                title: 'Following',
                userId: profile.id.toString(),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget richTextColumn(Color? black92White, Color? blackWhite,
      {required String title,
      required String value,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 28.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizeConfig.sH05,
            AdoroText(title, color: black92White),
            SizeConfig.sH05,
            AdoroText(
              value,
              color: blackWhite,
              fontSize: 15.sp,
              fontWeight: FontWeightClass.fontWeightBold,
            ),
            SizeConfig.sH05,
          ],
        ),
      ),
    );
  }
}
