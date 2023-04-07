import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:socialv/commanWidget/common_image.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/commanWidget/loader.dart';
import 'package:socialv/model/apiModel/requestModel/update_user_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/get_user_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/update_user_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/utils/assets/images_utils.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/custom_text_field.dart';
import 'package:socialv/utils/font_style_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/validation_utils.dart';

import '../../utils/color_utils.dart';
import '../../utils/variable_utils.dart';
import '../../utils/decoration_utils.dart';
import '../../utils/size_config_utils.dart';
import '../../viewModel/profile_view_model.dart';
import '../auth/components/edit_component.dart';

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
  EditProfileController editProfileController =
      Get.find<EditProfileController>();

  String coverPhoto = '';
  getUserProfile() async {
    await profileViewModel.getUserProfile();
    if (profileViewModel.getUserProfileApiResponse.status == Status.COMPLETE) {
      final GetUserResDetail response =
          profileViewModel.getUserProfileApiResponse.data;
      var profileData = response.data?[0];
      coverPhoto = profileData?.coverPhoto ?? "";
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

                final GetUserResDetail response =
                    profileViewModel.getUserProfileApiResponse.data;

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
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 25.h,
                        width: double.maxFinite,
                        decoration: DecorationUtils.buttonDecoration(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4.w),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.w),
                                    child: CircleAvatar(
                                      backgroundColor: ColorUtils.white,
                                      radius: 16.w,
                                      child: editProfileController.sourcePath !=
                                              ""
                                          ? Image.file(
                                              File(
                                                editProfileController
                                                    .sourcePath,
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : OctoImage(
                                              image: NetworkImage(
                                                  coverPhoto ?? ""),
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
                                                    BorderRadius.circular(20.w),
                                                child: Image.asset(
                                                  IconsWidgets.userImages,
                                                  color: ColorUtils.black,
                                                  scale: 0.28.w,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0.w,
                                  bottom: 10.w,
                                  child: Container(
                                    width: 8.w,
                                    height: 8.w,
                                    child: IconButton(
                                      splashRadius: 5.w,
                                      onPressed: () {
                                        editProfileController.pickFile();
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 4.w,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    decoration:
                                        DecorationUtils.doneDecoration(context),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 6.h,
                              width: 50.w,
                              decoration:
                                  DecorationUtils.welcomeDecoration(context),
                              child: TextButton(
                                onPressed: () async {
                                  updateUserReqDetail.userId =
                                      PreferenceUtils.getInt(
                                              key: PreferenceUtils.userid)
                                          .toString();

                                  updateUserReqDetail.userName = username.text;
                                  updateUserReqDetail.mobileNumber =
                                      mobilenumber.text;

                                  updateUserReqDetail.fullName = fullName.text;
                                  updateUserReqDetail.bankName = bankName.text;
                                  updateUserReqDetail.beneficiaryName =
                                      beneficiaryName.text;

                                  updateUserReqDetail.ifscCode = ifscCode.text;
                                  updateUserReqDetail.accountNumber =
                                      accountNumber.text;

                                  await profileViewModel
                                      .updateUserProfile(updateUserReqDetail);

                                  if (profileViewModel
                                          .updateUserProfileApiResponse
                                          .status ==
                                      Status.COMPLETE) {
                                    final UpdateUserResDetail
                                        updateProfileResponse = profileViewModel
                                            .updateUserProfileApiResponse.data;
                                    if (updateProfileResponse.status
                                            .toString() ==
                                        VariableUtils.status200) {
                                      showSnackBar(
                                        message: response.msg ??
                                            VariableUtils.somethingWentWrong,
                                        snackbarSuccess: true,
                                      );
                                    } else {
                                      showSnackBar(
                                        message: response.msg ??
                                            VariableUtils.somethingWentWrong,
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  VariableUtils.updateProfile,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                      SizeConfig.sH4,
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

  uploadImage() {}
}

class EditProfileController extends GetxController {
  String sourcePath = "";

  pickFile() async {
    sourcePath = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      sourcePath = file.path!;
    } else {
      sourcePath = "";
    }
    update();
  }
}
