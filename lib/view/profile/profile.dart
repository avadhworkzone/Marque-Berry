import 'dart:io';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/responseModel/user_profile_res_model.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/utils/decoration_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/size_config_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/view/profile/edit_profile.dart';
import 'package:socialv/commanWidget/common_appbar.dart';
import 'package:socialv/view/profile/mentions_post.dart';
import 'package:socialv/view/profile/show_post.dart';
import 'package:socialv/viewModel/profile_view_model.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/controllers/bottomBar_controller.dart';
import 'package:socialv/model/apiModel/responseModel/get_user_res_model.dart';

import 'widgets/cover_photo_profile.dart';
import 'widgets/posts_and_mentions_tab.dart';
import 'widgets/profile_button_section.dart';
import 'widgets/profile_header_section.dart';

class Profile extends StatelessWidget {
  final int userId;
  final bool fromBottomScreen;

  Profile({Key? key, required this.userId, this.fromBottomScreen = false})
      : super(key: key);

  final BottomBarController bottomBarController =
      Get.find<BottomBarController>();
  final ProfileViewModel profileViewModel = Get.find<ProfileViewModel>();

  Widget build(BuildContext context) {
    Color greyFABlack32 = Theme.of(context).cardColor;
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    return WillPopScope(
      onWillPop: () async {
        if(fromBottomScreen){
          bottomBarController.pageChange(0);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: greyFABlack32,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(15.w),
          child: CommonAppBar(
            color: ColorUtils.transparent,
            title: 'Profile',
            onTap: () => fromBottomScreen
                ? bottomBarController.pageChange(0)
                : Get.back(),
          ),
        ),
        body: GetBuilder<ProfileViewModel>(initState: (_) {
          getUserProfile();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            profileViewModel.clearCoverImage();
          });
        }, builder: (con) {
          if (con.getProfileDetailApiResponse.status == Status.LOADING ||
              con.getProfileDetailApiResponse.status == Status.INITIAL) {
            return Center(child: Loader());
          }
          if (con.getProfileDetailApiResponse.status == Status.ERROR) {
            return Center(child: SomethingWentWrong());
          }
          UserProfileResModel profileResModel =
              con.getProfileDetailApiResponse.data;
          if (profileResModel.status != 200) {
            return Center(child: SomethingWentWrong());
          }
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizeConfig.sH1,
                    CoverProfile(
                        con: con, profileData: profileResModel.data!.first),

                    ProfileHeaderSection(
                      profileResModel: profileResModel,
                    ),
                    SizeConfig.sH2,
                    ProfileButtonSection(profileResModel: profileResModel),
                    SizeConfig.sH2,
                    PostsAndMentionsTab(
                      con: con,
                      profileResModel: profileResModel,
                    ),
                  ],
                ),
              ),
              if(con.isLoading)
                Container(
                  height: Get.height,
                  width: Get.width,
                  color: ColorUtils.black26,
                  child: Center(child: Loader(),),
                ),
            ],
          );
        }),
      ),
    );
  }

  getUserProfile() async {
    profileViewModel.isLoading=false;
    await profileViewModel.getProfileDetail(userId.toString());
    await profileViewModel.getUserProfile();
    if (profileViewModel.getUserProfileApiResponse.status == Status.COMPLETE) {
      final GetUserResDetail response =
          profileViewModel.getUserProfileApiResponse.data;

      var profileData = response.data?[0];

      await PreferenceUtils.setString(
        key: PreferenceUtils.username,
        value: profileData?.username ?? "",
      );

      await PreferenceUtils.setString(
        key: PreferenceUtils.fullname,
        value: profileData?.fullName ?? "",
      );

      await PreferenceUtils.setString(
        key: PreferenceUtils.profileImage,
        value: profileData?.image ?? "",
      );

      await PreferenceUtils.setString(
        key: PreferenceUtils.coverImage,
        value: profileData?.coverPhoto ?? "",
      );
    }
  }
}
