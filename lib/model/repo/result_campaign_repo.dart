import '../../utils/enum_utils.dart';
import '../apiModel/responseModel/result_campaign_res_model.dart';
import '../apiService/api_service.dart';
import '../apiService/base_service.dart';

class ResultCampaignRepo extends BaseService {
  Future<ResultCampaignResModel> resultCampaignRepo(
      String id, String tag) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: {"id": id, "tag": tag},
      url: '$baseURL$getResults',
    );
    return ResultCampaignResModel.fromJson(response);
  }
}
