import 'package:get/get.dart';
import 'package:socialv/model/apiModel/requestModel/update_profile_pic_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/update_user_req_model.dart';
import 'package:socialv/model/repo/update_user_profile_pic_repo.dart';
import 'package:socialv/model/repo/update_user_profile_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/get_user_profile_repo.dart';

class FollowRequestViewModel extends GetxController {
  ApiResponse followRequestApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== GET USER VIEW MODEL ================================

  Future<void> getUserProfile() async {
    logs('loading..');
    followRequestApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetUserProfileRepo().getUserProfile();
      followRequestApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('followRequestApiResponse ERROR :=> $e');
      followRequestApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
  //
  // /// ======================== VALIDATE OTP VIEW MODEL ================================
  // Future<void> validateOTP(ValidateOTPReqModel reqModel) async {
  //   logs('loading..');
  //   validateOTPApiResponse = ApiResponse.loading('LOADING');
  //   update();
  //   try {
  //     final response = await ValidateOTPRepo().validateOTP(reqModel);
  //     validateOTPApiResponse = ApiResponse.complete(response);
  //   } catch (e) {
  //     logs('validateOTPApiResponse ERROR :=> $e');
  //     validateOTPApiResponse = ApiResponse.error('ERROR');
  //   }
  //   update();
  // }
  //
  // /// ======================== MEME CATEGORY VIEW MODEL ================================
  // Future<void> memeCategory() async {
  //   logs('loading..');
  //   memeCategoryApiResponse = ApiResponse.loading('LOADING');
  //   update();
  //   try {
  //     final response = await MemeCategoryRepo().memeCategory();
  //     memeCategoryApiResponse = ApiResponse.complete(response);
  //   } catch (e) {
  //     logs('memeCategoryApiResponse ERROR :=> $e');
  //     memeCategoryApiResponse = ApiResponse.error('ERROR');
  //   }
  //   update();
  // }
}
