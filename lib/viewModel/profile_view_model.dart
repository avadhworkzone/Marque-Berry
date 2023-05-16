import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/model/apiModel/requestModel/update_profile_pic_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/update_user_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/get_user_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/update_cover_pic_res_model.dart';
import 'package:socialv/model/repo/update_user_cover_pic_repo.dart';
import 'package:socialv/model/repo/update_user_profile_pic_repo.dart';
import 'package:socialv/model/repo/update_user_profile_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/get_user_profile_repo.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/variable_utils.dart';

class ProfileViewModel extends GetxController {
  bool _isLoading=false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  int tabIndex = 0;

  changeTab(value) {
    tabIndex = value;
    update();
  }

  String coverImagePath = "";

  clearCoverImage() {
    coverImagePath = "";
    getProfileDetailApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  CropImage cropImageClass = CropImage();

  Future<String> pickCoverImage(context) async {
    coverImagePath = "";
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        PlatformFile file = result.files.first;

        final cropPath = await cropImageClass.cropImage(
          context: context,
          image: File(file.path!),
          isBackGround: true,
        );
        coverImagePath = cropPath?.path ?? "";

        if (coverImagePath != "") {
          await updateUserCoverPic(coverImagePath);
        }
      }
    } catch (e) {
      logs("NORMAL IMAGE CATCH $e");
    }
    update();
    return coverImagePath;
  }

  /// ==================== USER DETAIL STORE IN PREF ==================== ///
  void getUserDetailStoreInPref(GetUserResDetail response) async {
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

  ApiResponse getUserProfileApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getProfileDetailApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateUserProfileApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateUserProfilePicApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateUserCoverPicApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== GET USER PROFILE DETAIL ================================

  Future<void> getProfileDetail(String userId) async {
    // getProfileDetailApiResponse = ApiResponse.loading('LOADING');
    // update();
    try {
      final response = await GetProfileDetailRepo().getProfileDetail(userId);
      getProfileDetailApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getProfileDetailApiResponse ERROR :=> $e');
      getProfileDetailApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET USER VIEW MODEL ================================

  Future<void> getUserProfile(int userId) async {
    // logs('loading..');
    // getUserProfileApiResponse = ApiResponse.loading('LOADING');
    // update();
    try {
      final response = await GetUserProfileRepo().getUserProfile(userId);
      getUserProfileApiResponse = ApiResponse.complete(response);
      getUserDetailStoreInPref(response);
    } catch (e) {
      logs('getUserProfileApiResponse ERROR :=> $e');
      getUserProfileApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== PROFILE DATA VIEW MODEL ================================

  Future<void> updateUserProfile(UpdateUserReqDetail reqModel) async {
    logs('loading..');
    updateUserProfileApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await UpdateUserProfileRepo().updateUserProfile(reqModel);
      updateUserProfileApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('updateUserProfileApiResponse ERROR :=> $e');
      updateUserProfileApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== PROFILE PIC VIEW MODEL ================================

  Future<void> updateUserProfilePic(UpdateProfilePicReqModel reqModel) async {
    logs('loading..');
    updateUserProfilePicApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await UpdateUserProfilePicRepo().updateUserProfilePic(reqModel);
      updateUserProfilePicApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('updateUserProfilePicApiResponse ERROR :=> $e');
      updateUserProfilePicApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== COVER PIC VIEW MODEL ================================

  Future<void> updateUserCoverPic(String coverPhoto) async {
    logs('loading..');
    updateUserCoverPicApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await UpdateUserCoverPicRepo().updateUserCoverPic(coverPhoto);
      updateUserCoverPicApiResponse = ApiResponse.complete(response);

    } catch (e) {
      logs('updateUserCoverPicApiResponse ERROR :=> $e');
      updateUserCoverPicApiResponse = ApiResponse.error('ERROR');
      showSnackBar(
        message: VariableUtils.somethingWentWrong,
      );
    }
    update();
  }
}
