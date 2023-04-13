import 'package:get/get.dart';
import 'package:socialv/model/apiModel/requestModel/get_campaign_id_req_model.dart';
import 'package:socialv/model/repo/apply_campaign_repo.dart';
import 'package:socialv/model/repo/apply_contest_repo.dart';
import 'package:socialv/model/repo/campaign_contest_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import '../model/apiModel/requestModel/apply_now_campaign_req_model.dart';
import '../model/apiModel/requestModel/apply_now_contest_req_model.dart';
import '../model/repo/get_campaign_id_repo.dart';

class CampaignContestViewModel extends GetxController {
  ApiResponse getCampaignContestApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse applyCampaignApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse applyContestApiResponse = ApiResponse.initial('INITIAL');

  ApiResponse getCampaignIdApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== GET CAMPAIGN CONTEST VIEW MODEL ================================

  Future<void> getCampaignContest() async {
    logs('loading..');
    getCampaignContestApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await CampaignContestRepo().campaignContest();
      getCampaignContestApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getCampaignContestApiResponse ERROR :=> $e');
      getCampaignContestApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET CAMPAIGN CONTEST VIEW MODEL ================================

  Future<void> applyCampaign(ApplyCampaignReqModel reqModel) async {
    logs('loading..');
    applyCampaignApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ApplyCampaignRepo().applyCampaign(reqModel);
      applyCampaignApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('applyCampaignApiResponse ERROR :=> $e');
      applyCampaignApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET CAMPAIGN CONTEST VIEW MODEL ================================

  Future<void> applyContest(ApplyContestReqModel reqModel) async {
    logs('loading..');
    applyContestApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ApplyContestRepo().applyContest(reqModel);
      applyContestApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('applyContestApiResponse ERROR :=> $e');
      applyContestApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET CAMPAIGN CONTEST VIEW MODEL ================================

  Future<void> getCampaignId(GetCampaignIdReqModel reqModel) async {
    logs('loading..');
    getCampaignIdApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetCampaignIdRepo().getCampaign(reqModel);
      getCampaignIdApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getCampaignIdApiResponse ERROR :=> $e');
      getCampaignIdApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
