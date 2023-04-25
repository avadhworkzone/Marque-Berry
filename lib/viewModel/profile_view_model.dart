import 'package:get/get.dart';
import 'package:socialv/model/apiModel/requestModel/update_cover_pic_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/update_profile_pic_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/update_user_req_model.dart';
import 'package:socialv/model/repo/update_user_cover_pic_repo.dart';
import 'package:socialv/model/repo/update_user_profile_pic_repo.dart';
import 'package:socialv/model/repo/update_user_profile_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/get_user_profile_repo.dart';

class ProfileViewModel extends GetxController {
  ApiResponse getUserProfileApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateUserProfileApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateUserProfilePicApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateUserCoverPicApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== GET USER VIEW MODEL ================================

  Future<void> getUserProfile() async {
    logs('loading..');
    getUserProfileApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetUserProfileRepo().getUserProfile();
      getUserProfileApiResponse = ApiResponse.complete(response);
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

  Future<void> updateUserCoverPic(UpdateCoverPicReqModel reqModel) async {
    logs('loading..');
    updateUserCoverPicApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await UpdateUserCoverPicRepo().updateUserCoverPic(reqModel);
      updateUserCoverPicApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('updateUserCoverPicApiResponse ERROR :=> $e');
      updateUserCoverPicApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
