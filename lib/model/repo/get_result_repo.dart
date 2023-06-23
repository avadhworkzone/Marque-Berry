import '../../utils/enum_utils.dart';
import '../apiModel/responseModel/result_res_model.dart';
import '../apiService/api_service.dart';
import '../apiService/base_service.dart';

class ResultRepo extends BaseService {
  Future<ResultResModel> resultRepo() async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$resultCompletedCampaign',
    );
    return ResultResModel.fromJson(response);
  }
}
