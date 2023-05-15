import 'package:get/get.dart';
import 'package:socialv/model/apiModel/requestModel/delete_follow_request_req_model.dart';
import 'package:socialv/model/repo/delete_follow_request_repo.dart';
import 'package:socialv/model/repo/get_follower_list_repo.dart';
import 'package:socialv/model/repo/get_following_list_repo.dart';
import 'package:socialv/model/repo/send_follow_request_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';

class FollowFollowingViewModel extends GetxController {
  ApiResponse getFollowerListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getFollowingListApiResponse = ApiResponse.initial('INITIAL');

  ApiResponse sendFollowRequestApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse deleteFollowRequestApiResponse = ApiResponse.initial('INITIAL');

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

  /// ======================== SEND FOLLOW REQUEST ===================================

  Future<void> sendFollowRequest(String userId) async {
    logs('loading..');
    sendFollowRequestApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await SendFollowRequestRepo().sendFollowRequest(userId);
      sendFollowRequestApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('sendFollowRequestApiResponse ERROR :=> $e');
      sendFollowRequestApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== DELETE FOLLOW REQUEST ===================================

  Future<void> deleteFollowRequest(DeleteFollowReqModel reqModel) async {
    logs('loading..');
    deleteFollowRequestApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await DeleteFollowRequestRepo().deleteFollowRequest(reqModel);
      deleteFollowRequestApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('deleteFollowRequestApiResponse ERROR :=> $e');
      deleteFollowRequestApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
