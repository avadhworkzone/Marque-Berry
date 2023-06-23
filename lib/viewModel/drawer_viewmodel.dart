import 'package:get/get.dart';
import 'package:socialv/model/apiModel/requestModel/suppor_req_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/get_note_repo.dart';
import 'package:socialv/model/repo/get_notification_repo.dart';
import 'package:socialv/model/repo/get_wallet_balance_repo.dart';
import 'package:socialv/model/repo/support_repo.dart';
import 'package:socialv/utils/const_utils.dart';

import '../model/repo/get_result_repo.dart';
import '../model/repo/result_campaign_repo.dart';
import '../model/repo/withdrawn_amount_otp_repo.dart';
import '../model/repo/withdrawn_amount_repo.dart';

class DrawerVideModel extends GetxController {
  ApiResponse getNoteApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse postSupportApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getNotificationListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getWalletBalanceApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getWithdrawnAmountApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse postWithdrawnAmountOtpValidateApiResponse =
      ApiResponse.initial('INITIAL');
  ApiResponse getResultApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getResultCampaignResponse = ApiResponse.initial('INITIAL');

  /// ======================== GET NOTE VIEW MODEL ================================
  Future<void> getNote() async {
    logs('loading..');
    getNoteApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetNoteRepo().getNote();
      getNoteApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getNoteApiResponse ERROR :=> $e');
      getNoteApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET NOTE VIEW MODEL ================================
  Future<void> support(SupportReqModel reqModel) async {
    logs('loading..');
    postSupportApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await SupportRepo().supportRepo(reqModel);
      postSupportApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('postSupportApiResponse ERROR :=> $e');
      postSupportApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET NOTIFICATION LIST ================================
  Future<void> getNotificationList() async {
    logs('loading..');
    getNotificationListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetNotificationListRepo().getNotificationRepo();
      getNotificationListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getNotificationListApiResponse ERROR :=> $e');
      getNotificationListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET NOTIFICATION LIST ================================
  Future<void> getWalletBalance() async {
    logs('loading..');
    getWalletBalanceApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetWalletBalanceRepo().getWalletBalanceRepo();
      getWalletBalanceApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getWalletBalanceApiResponse ERROR :=> $e');
      getWalletBalanceApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== Withdrawn Amount ================================

  Future<void> getWithdrawnAmount() async {
    logs('loading..');
    getWithdrawnAmountApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await WithdrawnAmountRepo().withdrawnAmountRepo();
      getWithdrawnAmountApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getWithdrawnAmountApiResponse ERROR :=> $e');
      getWithdrawnAmountApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== Withdrawn Amount Otp Validate ================================

  Future<void> postWithdrawnAmountOtpValidate(String otp, String amount) async {
    logs('loading..');
    postWithdrawnAmountOtpValidateApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await WithdrawnAmountOtpValidateRepo()
          .withdrawnAmountOtpValidateRepo(otp, amount);
      postWithdrawnAmountOtpValidateApiResponse =
          ApiResponse.complete(response);
    } catch (e) {
      logs('getWalletBalanceApiResponse ERROR :=> $e');
      postWithdrawnAmountOtpValidateApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== Campaign And ContestApp ================================

  Future<void> getResult() async {
    logs('loading..');
    getResultApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ResultRepo().resultRepo();
      getResultApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('resultCompletedCampaignApiResponse ERROR :=> $e');
      getResultApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== Result Campaign ================================

  Future<void> getResultDetail(String id, String tag) async {
    logs('loading..');
    getResultCampaignResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ResultCampaignRepo().resultCampaignRepo(id, tag);
      getResultCampaignResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getResultCampaignApiResponse ERROR :=> $e');
      getResultCampaignResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
