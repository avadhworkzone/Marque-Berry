import 'package:socialv/model/apiModel/requestModel/apply_now_campaign_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/apply_now_contest_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/apply_now_campaign_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import '../apiModel/responseModel/compaign_contest_res_model.dart';

class ApplyCampaignRepo extends BaseService {
  Future<ApplyCampaignResModel> applyCampaign(
      ApplyCampaignReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$applyCampaignURL',
      applyCampaignData: true,
    );

    return ApplyCampaignResModel.fromJson(response);
  }
}
