import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import '../apiModel/responseModel/compaign_contest_res_model.dart';

class CampaignContestRepo extends BaseService {
  Future<CampaignContestResModel> campaignContest() async {
    Map<String, dynamic> body = {};

    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      body: body,
      url: '$baseURL$getAllCampaignAndContestAppURL',
    );

    return CampaignContestResModel.fromJson(response);
  }
}
