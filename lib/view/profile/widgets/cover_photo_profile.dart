import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/model/apiModel/responseModel/user_profile_res_model.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/app_services/common_profile_image.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/viewModel/profile_view_model.dart';

class CoverProfile extends StatelessWidget {
  const CoverProfile({
    super.key,
    required this.con,
    required this.profileData,
  });

  final ProfileViewModel con;
  final UserProfileData profileData;

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    logs('IMAGE ===>${profileData.coverPhoto}');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: Get.width,
                margin: EdgeInsets.only(bottom: 9.w),
                child: con.coverImagePath != "" &&
                        profileData.id ==
                            PreferenceUtils.getInt(key: PreferenceUtils.userid)
                    ? Image.file(
                        File(con.coverImagePath,),
                        // fit: BoxFit.fill,
                        fit: BoxFit.fitWidth,
                        // fit: BoxFit.contain,
                      )
                    :
                CommonCoverImage(image: profileData.coverPhoto ?? ""),
              ),
            ),
            if (profileData.id ==
                PreferenceUtils.getInt(key: PreferenceUtils.userid))
              editCodePhotoBtn(context),
            Positioned(
              bottom: 0,
              left: 37.5.w,
              child: CommonProfileImage(
                  heightWidth: 25.w,
                  image: profileData.id ==
                          PreferenceUtils.getInt(key: PreferenceUtils.userid)
                      ? PreferenceUtils.getString(
                          key: PreferenceUtils.profileImage,
                        )
                      : profileData.image),
            ),
          ],
        ),
        SizeConfig.sH1,
        AdoroText(
          profileData.id == PreferenceUtils.getInt(key: PreferenceUtils.userid)
              ? "${PreferenceUtils.getString(key: PreferenceUtils.username)}"
              : "${profileData.username}",
          textAlign: TextAlign.center,
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: blackWhite,
        ),
      ],
    );
  }

  Positioned editCodePhotoBtn(BuildContext context) {
    return Positioned(
      right: 2.w,
      top: 2.w,
      child: InkWell(
        onTap: () async {
          await con.pickCoverImage(context);
        },
        highlightColor: ColorUtils.transparent,
        splashColor: ColorUtils.transparent,
        child: Container(
          width: 8.w,
          height: 8.w,
          child: Icon(
            Icons.edit,
            size: 4.w,
            color: ColorUtils.white,
          ),
          decoration: DecorationUtils.doneDecoration(context),
        ),
      ),
    );
  }
}
