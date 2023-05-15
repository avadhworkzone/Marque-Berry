import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:socialv/commanWidget/custom_btn.dart';
import 'package:socialv/model/apiModel/responseModel/user_profile_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/adoro_text.dart';
import 'package:socialv/utils/color_utils.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/view/profile/edit_profile.dart';
import 'package:socialv/viewModel/category_view_model.dart';
import 'package:socialv/viewModel/follow_request_view_model.dart';
import 'package:socialv/viewModel/profile_view_model.dart';

import '../../../utils/shared_preference_utils.dart';
import '../../message/chatting.dart';
import '../profile.dart';

class ProfileButtonSection extends StatelessWidget {
  const ProfileButtonSection({
    super.key,
    required this.profileResModel,
  });

  final UserProfileResModel profileResModel;

  @override
  Widget build(BuildContext context) {
    final btnStatus =
        profileResModel.data!.first.tag!.replaceAll(' ', "").toLowerCase();
    final profile = profileResModel.data!.first;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: btnStatus == ProfileBtnStatus.EditProfile.name.toLowerCase()
          ? EditProfileBtn()
          : btnStatus == ProfileBtnStatus.Following.name.toLowerCase()
              ? FollowingBtn(
                  profileUser: profile,
                )
              : btnStatus == ProfileBtnStatus.FollowBack.name.toLowerCase()
                  ? FollowBackBtn()
                  : btnStatus == ProfileBtnStatus.Confirm.name.toLowerCase()
                      ? ConfirmBtn()
                      : btnStatus ==
                              ProfileBtnStatus.Requested.name.toLowerCase()
                          ? RequestedBtn(userId: profile.id ?? 0)
                          : FollowBtn(userId: profile.id ?? 0),
    );
  }
}

/// ========================== CONFIRM BTN ========================== ///
class ConfirmBtn extends StatelessWidget {
  const ConfirmBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: CustomBtn(
          onTap: () {},
          text: 'Confirm',
        )),
        SizedBox(width: 10.sp),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
                height: 6.2.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorUtils.white),
                child: const Center(
                  child: AdoroText('Delete',
                      // fontSize: 17,
                      color: ColorUtils.black92,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ),
      ],
    );
  }
}

/// ========================== FOLLOWING BTN ========================== ///
class FollowingBtn extends StatelessWidget {
  FollowingBtn({Key? key, required this.profileUser}) : super(key: key);
  final UserProfileData profileUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
                height: 6.2.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorUtils.white),
                child: const Center(
                  child: AdoroText('Following',
                      // fontSize: 17,
                      color: ColorUtils.black92,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ),
        SizedBox(width: 10.sp),
        Expanded(
          child: InkWell(
            onTap: () {
              Get.to(() => ChattingScreen(
                    senderName: PreferenceUtils.getString(key: 'username'),
                    senderId:
                        (PreferenceUtils.getInt(key: 'userid')).toString(),
                    senderImage: PreferenceUtils.getString(key: 'profile'),
                    receiverId: profileUser.id!.toString(),
                    receiverName: profileUser.username!,
                    receiverImage: profileUser.image!,
                  ));
            },
            child: Container(
                height: 6.2.h,
                decoration: BoxDecoration(
                    color: ColorUtils.black92,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: AdoroText('Message ',
                      // fontSize: 17,
                      color: ColorUtils.white,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ),
      ],
    );
  }
}

/// ========================== FOLLOW BTN ========================== ///
class FollowBtn extends StatelessWidget {
  FollowBtn({Key? key, required this.userId}) : super(key: key);
  final int userId;
  final FollowFollowingViewModel viewModel =
      Get.find<FollowFollowingViewModel>();
  final ProfileViewModel profileViewModel = Get.find<ProfileViewModel>();
  final CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomBtn(
      onTap: () async {
        profileViewModel.isLoading = true;
        await viewModel.sendFollowRequest(userId.toString());
        if (viewModel.sendFollowRequestApiResponse.status == Status.COMPLETE) {
          categoryFeedViewModel.setFollowData(userId, true);
          await profileViewModel.getProfileDetail(userId.toString());
        }
        profileViewModel.isLoading = false;
      },
      text: 'Follow',
    );
  }
}

/// ========================== FOLLOW BTN ========================== ///
class RequestedBtn extends StatelessWidget {
  RequestedBtn({Key? key, required this.userId}) : super(key: key);
  final int userId;
  final FollowFollowingViewModel viewModel =
      Get.find<FollowFollowingViewModel>();
  final ProfileViewModel profileViewModel = Get.find<ProfileViewModel>();
  final CategoryFeedViewModel categoryFeedViewModel =
      Get.find<CategoryFeedViewModel>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          height: 6.2.h,
          decoration: BoxDecoration(
              color: ColorUtils.black92,
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: AdoroText('Requested',
                // fontSize: 17,
                color: ColorUtils.white,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}

/// ========================== FOLLOW BACK BTN ========================== ///
class FollowBackBtn extends StatelessWidget {
  const FollowBackBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBtn(
      onTap: () {},
      text: 'Follow Back',
    );
  }
}

/// ========================== EDIT PROFILE BTN ========================== ///

class EditProfileBtn extends StatelessWidget {
  const EditProfileBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color whiteBlack2E = Theme.of(context).scaffoldBackgroundColor;
    Color? black92White = Theme.of(context).textTheme.titleMedium?.color;
    return InkWell(
      onTap: () => Get.to(() => EditProfile()),
      child: Container(
        height: 15.w,
        width: Get.width,
        color: whiteBlack2E,
        child: Center(
          child: AdoroText(
            'Edit Profile',
            color: black92White,
            fontWeight: FontWeightClass.fontWeight600,
          ),
        ),
      ),
    );
  }
}
