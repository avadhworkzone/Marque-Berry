import 'package:get/get.dart';
import 'package:socialv/model/apiModel/requestModel/delete_follow_request_req_model.dart';
import 'package:socialv/model/repo/accept_follow_request_repo.dart';
import 'package:socialv/model/repo/delete_follow_request_repo.dart';
import 'package:socialv/model/repo/get_follower_list_repo.dart';
import 'package:socialv/model/repo/get_following_list_repo.dart';
import 'package:socialv/model/repo/get_pending_request_repo.dart';
import 'package:socialv/model/repo/send_follow_request_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';

class FollowFollowingViewModel extends GetxController {
  String _searchUserStr="";

  String get searchUserStr => _searchUserStr;

  set searchUserStr(String value) {
    _searchUserStr = value;
    update();
  }

  ApiResponse getFollowerListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getFollowingListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getPendingRequestApiResponse = ApiResponse.initial('INITIAL');

  ApiResponse sendFollowRequestApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse deleteFollowRequestApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse acceptFollowRequestApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== GET FOLLOWING USER VIEW MODEL ================================

  Future<void> getFollowerList(String userId) async {
    logs('loading..');
    getFollowerListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetFollowerListRepo().getFollowerList(userId);
      getFollowerListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getFollowerListApiResponse ERROR :=> $e');
      getFollowerListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET FOLLOWER VIEW MODEL ================================

  Future<void> getFollowingList(String userId) async {
    logs('loading..');
    getFollowingListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetFollowingListRepo().getFollowingList(userId);
      getFollowingListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getFollowingListApiResponse ERROR :=> $e');
      getFollowingListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET FOLLOWER VIEW MODEL ================================

  Future<void> getPendingRequestList() async {
    logs('loading..');
    getPendingRequestApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetPendingRequestRepo().pendingRequest();
      getPendingRequestApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getPendingRequestApiResponse ERROR :=> $e');
      getPendingRequestApiResponse = ApiResponse.error('ERROR');
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

  /// ======================== ACCEPT FOLLOW REQUEST ===================================

  Future<void> acceptFollowRequest(String requestId) async {
    logs('loading..');
    acceptFollowRequestApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await AcceptFollowRequestRepo().acceptFollowRequest(requestId);
      acceptFollowRequestApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('acceptFollowRequestApiResponse ERROR :=> $e');
      acceptFollowRequestApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
