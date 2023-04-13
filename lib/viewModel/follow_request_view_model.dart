import 'package:get/get.dart';
import 'package:socialv/model/repo/get_follower_list_repo.dart';
import 'package:socialv/model/repo/get_following_list_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';

class FollowRequestViewModel extends GetxController {
  ApiResponse getFollowerListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getFollowingListApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== GET FOLLOWING USER VIEW MODEL ================================

  Future<void> getFollowerList() async {
    logs('loading..');
    getFollowerListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetFollowerListRepo().getFollowerList();
      getFollowerListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getFollowerListApiResponse ERROR :=> $e');
      getFollowerListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET FOLLOWER VIEW MODEL ================================

  Future<void> getFollowingList() async {
    logs('loading..');
    getFollowingListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetFollowingListRepo().getFollowingList();
      getFollowingListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getFollowingListApiResponse ERROR :=> $e');
      getFollowingListApiResponse = ApiResponse.error('ERROR');
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
