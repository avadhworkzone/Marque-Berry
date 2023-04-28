// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/custom_btn.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/requestModel/update_cover_pic_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/update_profile_pic_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/update_user_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/get_user_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/update_user_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/app_services/common_profile_image.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/custom_text_field.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/validation_utils.dart';

import '../../model/apiModel/responseModel/update_profile_pic_res_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/variable_utils.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../viewModel/profile_view_model.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  var fullName = TextEditingController();
  var username = TextEditingController();
  var mailId = TextEditingController();
  var bankName = TextEditingController();
  var beneficiaryName = TextEditingController();
  var accountNumber = TextEditingController();
  var ifscCode = TextEditingController();
  var mobilenumber = TextEditingController();

  UpdateUserReqDetail updateUserReqDetail = UpdateUserReqDetail();
  ProfileViewModel profileViewModel = Get.find<ProfileViewModel>();

  UpdateProfilePicReqModel updateProfilePicReqModel =
      UpdateProfilePicReqModel();

  UpdateCoverPicReqModel updateCoverPicReqModel = UpdateCoverPicReqModel();

  EditProfileController editProfileController =
      Get.find<EditProfileController>();

  getUserProfile() async {
    await profileViewModel.getUserProfile();
    if (profileViewModel.getUserProfileApiResponse.status == Status.COMPLETE) {
      final GetUserResDetail response =
          profileViewModel.getUserProfileApiResponse.data;

      var profileData = response.data?[0];

      PreferenceUtils.setString(
          key: PreferenceUtils.username, value: profileData?.username ?? "");

      PreferenceUtils.setString(
          key: PreferenceUtils.fullname, value: profileData?.fullName ?? "");

      PreferenceUtils.setString(
        key: PreferenceUtils.profileImage,
        value: profileData?.image ?? "",
      );

      PreferenceUtils.setString(
        key: PreferenceUtils.coverImage,
        value: profileData?.coverPhoto ?? "",
      );

      fullName = TextEditingController(text: profileData?.fullName ?? "");
      username = TextEditingController(text: profileData?.username ?? "");
      mailId = TextEditingController(text: profileData?.email ?? "");
      bankName = TextEditingController(text: profileData?.bankName ?? "");
      mobilenumber = TextEditingController(text: profileData?.mobileNo ?? "");
      beneficiaryName =
          TextEditingController(text: profileData?.beneficiaryName ?? "");
      accountNumber =
          TextEditingController(text: profileData?.accountNumber ?? "");
      ifscCode = TextEditingController(text: profileData?.ifscCode ?? "");
    }
  }

  updateProfileData() async {
    updateUserReqDetail.userId =
        PreferenceUtils.getInt(key: PreferenceUtils.userid).toString();

    updateUserReqDetail.userName = username.text;
    updateUserReqDetail.mobileNumber = mobilenumber.text;

    updateUserReqDetail.fullName = fullName.text;
    updateUserReqDetail.bankName = bankName.text;
    updateUserReqDetail.beneficiaryName = beneficiaryName.text;

    updateUserReqDetail.ifscCode = ifscCode.text;
    updateUserReqDetail.accountNumber = accountNumber.text;

    await profileViewModel.updateUserProfile(updateUserReqDetail);

    if (profileViewModel.updateUserProfileApiResponse.status ==
        Status.COMPLETE) {
      final UpdateUserResDetail updateProfileResponse =
          profileViewModel.updateUserProfileApiResponse.data;
      if (updateProfileResponse.status.toString() == VariableUtils.status200) {
        showSnackBar(
          message:
              updateProfileResponse.msg ?? VariableUtils.somethingWentWrong,
          snackbarSuccess: true,
        );
      } else {
        showSnackBar(
          message:
              updateProfileResponse.msg ?? VariableUtils.somethingWentWrong,
        );
      }
    }
  }

  updateProfileImage() async {
    updateProfilePicReqModel.profilePic =
        editProfileController.profileImagePath;

    await profileViewModel.updateUserProfilePic(updateProfilePicReqModel);

    if (profileViewModel.updateUserProfilePicApiResponse.status ==
        Status.COMPLETE) {
      final UpdateProfilePicResModel updateProfilePicResModel =
          profileViewModel.updateUserProfilePicApiResponse.data;
      if (updateProfilePicResModel.status.toString() == '200') {
        showSnackBar(
          message: updateProfilePicResModel.message ??
              VariableUtils.somethingWentWrong,
          snackbarSuccess: true,
        );
      } else {
        showSnackBar(
          message: updateProfilePicResModel.message ??
              VariableUtils.somethingWentWrong,
        );
      }
    }
  }

  // updateCoverImage() async {
  //   updateCoverPicReqModel.coverPhoto = editProfileController.coverImagePath;
  //
  //   await profileViewModel.updateUserCoverPic(updateCoverPicReqModel);
  //
  //   if (profileViewModel.updateUserProfilePicApiResponse.status ==
  //       Status.COMPLETE) {
  //     final UpdateCoverPicResModel updateCoverPicResModel =
  //         profileViewModel.updateUserCoverPicApiResponse.data;
  //
  //     if (updateCoverPicResModel.status.toString() == VariableUtils.status200) {
  //       showSnackBar(
  //         message: updateCoverPicResModel.message ??
  //             VariableUtils.somethingWentWrong,
  //         snackbarSuccess: true,
  //       );
  //     } else {
  //       showSnackBar(
  //         message: updateCoverPicResModel.message ??
  //             VariableUtils.somethingWentWrong,
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Color? blackWhite = Theme.of(context).textTheme.titleSmall?.color;
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: GetBuilder<EditProfileController>(
          init: EditProfileController(),
          builder: (editProfileController) {
            return GetBuilder<ProfileViewModel>(
              initState: (_) {
                editProfileController.clearData();
                getUserProfile();
              },
              init: ProfileViewModel(),
              builder: (profileViewModel) {
                if (profileViewModel.getUserProfileApiResponse.status ==
                        Status.LOADING ||
                    profileViewModel.getUserProfileApiResponse.status ==
                        Status.INITIAL) return Center(child: Loader());
                if (profileViewModel.getUserProfileApiResponse.status ==
                    Status.ERROR) return Center(child: SomethingWentWrong());

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 4.w,
                              horizontal: 4.w,
                            ),
                            child: InkWell(
                              onTap: () => Get.back(),
                              child: Icon(
                                Icons.arrow_back,
                                color: blackWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 25.h,
                            width: double.maxFinite,
                            child: CommonCoverImage(),
                          ),
                          Container(
                            height: 25.h,
                            padding: EdgeInsets.only(right: 5.w, left: 8.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 38.w,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.w),
                                        child: Container(
                                          height: 30.w,
                                          width: 30.w,
                                          color: ColorUtils.white,
                                          child: editProfileController
                                                      .profileImagePath !=
                                                  ""
                                              ? Image.file(
                                                  File(
                                                    editProfileController
                                                        .profileImagePath,
                                                  ),
                                                  fit: BoxFit.cover,
                                                )
                                              : OctoImage(
                                                  image: NetworkImage(
                                                    PreferenceUtils.getString(
                                                      key: PreferenceUtils
                                                          .profileImage,
                                                    ),
                                                  ),
                                                  progressIndicatorBuilder:
                                                      (context, progress) {
                                                    double? value;
                                                    var expectedBytes = progress
                                                        ?.expectedTotalBytes;
                                                    if (progress != null &&
                                                        expectedBytes != null) {
                                                      value = progress
                                                              .cumulativeBytesLoaded /
                                                          expectedBytes;
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: value,
                                                        color: blackWhite,
                                                      ),
                                                    );
                                                  },
                                                  errorBuilder: (context, error,
                                                          stacktrace) =>
                                                      ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.w),
                                                    child: Image.asset(
                                                      IconsWidgets.userImages,
                                                      color: ColorUtils.black,
                                                      scale: 0.28.w,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 6.w,
                                        bottom: 3.w,
                                        child: Container(
                                          width: 8.w,
                                          height: 8.w,
                                          child: IconButton(
                                            splashRadius: 5.w,
                                            onPressed: () {
                                              editProfileController
                                                  .pickProfileImage();
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 4.w,
                                              color: ColorUtils.white,
                                            ),
                                          ),
                                          decoration:
                                              DecorationUtils.doneDecoration(
                                                  context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (editProfileController
                                            .profileImagePath !=
                                        "") {
                                      await updateProfileImage();
                                    }
                                  },
                                  child: Container(
                                    height: 5.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/rectangleedit.png",
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        VariableUtils.updateProfile,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: ColorUtils.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizeConfig.sH4,
                      Container(
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w),
                          color: ColorUtils.greyFA,
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizeConfig.sH2,
                                CommonTextFormField(
                                  color: ColorUtils.black,
                                  controller: fullName,
                                  hintText: "Full Name",
                                  hintStyle: FontTextStyle.profileText,
                                  textstyle: FontTextStyle.profileText
                                      .copyWith(color: ColorUtils.black92),
                                  keyboardType: TextInputType.name,
                                  validator: (v) => userValidation(v),
                                  denyInputFormatters:
                                      RegularExpression.noSpaceAllowPattern,
                                  allowInputFormatters:
                                      RegularExpression.nameKeyboardPattern,
                                ),
                                SizeConfig.sH2,
                                CommonTextFormField(
                                  color: ColorUtils.black,
                                  controller: username,
                                  hintText: "UserName",
                                  hintStyle: FontTextStyle.profileText,
                                  textstyle: FontTextStyle.profileText
                                      .copyWith(color: ColorUtils.black92),
                                  keyboardType: TextInputType.name,
                                  validator: (v) => userValidation(v),
                                  denyInputFormatters:
                                      RegularExpression.noSpaceAllowPattern,
                                  allowInputFormatters:
                                      RegularExpression.nameKeyboardPattern,
                                ),
                                SizeConfig.sH2,
                                CommonTextFormField(
                                  color: ColorUtils.black,
                                  controller: mailId,
                                  hintText: "Mail Id",
                                  hintStyle: FontTextStyle.profileText,
                                  textstyle: FontTextStyle.profileText
                                      .copyWith(color: ColorUtils.black92),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (v) => userValidation(v),
                                  denyInputFormatters:
                                      RegularExpression.noSpaceAllowPattern,
                                  allowInputFormatters:
                                      RegularExpression.emailKeyboardPattern,
                                ),
                                SizeConfig.sH2,
                                CommonTextFormField(
                                  color: ColorUtils.black,
                                  controller: bankName,
                                  hintText: "Bank Name",
                                  hintStyle: FontTextStyle.profileText,
                                  textstyle: FontTextStyle.profileText
                                      .copyWith(color: ColorUtils.black92),
                                  keyboardType: TextInputType.name,
                                  validator: (v) => userValidation(v),
                                  denyInputFormatters:
                                      RegularExpression.noSpaceAllowPattern,
                                  allowInputFormatters:
                                      RegularExpression.nameKeyboardPattern,
                                ),
                                SizeConfig.sH2,
                                CommonTextFormField(
                                  color: ColorUtils.black,
                                  controller: beneficiaryName,
                                  hintText: "Beneficiary Name",
                                  hintStyle: FontTextStyle.profileText,
                                  textstyle: FontTextStyle.profileText
                                      .copyWith(color: ColorUtils.black92),
                                  keyboardType: TextInputType.name,
                                  validator: (v) => userValidation(v),
                                  denyInputFormatters:
                                      RegularExpression.noSpaceAllowPattern,
                                  allowInputFormatters:
                                      RegularExpression.nameKeyboardPattern,
                                ),
                                SizeConfig.sH2,
                                CommonTextFormField(
                                  color: ColorUtils.black,
                                  controller: accountNumber,
                                  hintText: "Account Number",
                                  hintStyle: FontTextStyle.profileText,
                                  textstyle: FontTextStyle.profileText
                                      .copyWith(color: ColorUtils.black92),
                                  keyboardType: TextInputType.number,
                                  validator: (v) => userValidation(v),
                                  denyInputFormatters:
                                      RegularExpression.noSpaceAllowPattern,
                                  allowInputFormatters:
                                      RegularExpression.contactKeyboardPattern,
                                ),
                                SizeConfig.sH2,
                                CommonTextFormField(
                                  color: ColorUtils.black,
                                  controller: ifscCode,
                                  hintText: "IFSC Code",
                                  hintStyle: FontTextStyle.profileText,
                                  textstyle: FontTextStyle.profileText
                                      .copyWith(color: ColorUtils.black92),
                                  keyboardType: TextInputType.number,
                                  validator: (v) => userValidation(v),
                                  denyInputFormatters:
                                      RegularExpression.noSpaceAllowPattern,
                                  allowInputFormatters:
                                      RegularExpression.contactKeyboardPattern,
                                ),
                                SizeConfig.sH2,
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizeConfig.sH2,
                      CustomBtn(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (username.text.isEmpty ||
                              mailId.text.isEmpty ||
                              bankName.text.isEmpty ||
                              ifscCode.text.isEmpty ||
                              accountNumber.text.isEmpty ||
                              fullName.text.isEmpty ||
                              beneficiaryName.text.isEmpty) {
                            showSnackBar(message: "Fields is required");
                          } else {
                            await updateProfileData();
                          }
                        },
                        text: 'Update account',
                      ),
                      SizeConfig.sH2,
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class EditProfileController extends GetxController {
  String profileImagePath = "";
  // String coverImagePath = "";
  // String sourcePath = "";

  pickProfileImage() async {
    profileImagePath = "";

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        profileImagePath = file.path!;
      } else {
        profileImagePath = "";
      }
    } catch (e) {
      showSnackBar(
        message: "Profile image not selected.",
      );
    }
    update();
  }

  clearData() {
    profileImagePath = "";
    // coverImagePath = "";
  }
}
