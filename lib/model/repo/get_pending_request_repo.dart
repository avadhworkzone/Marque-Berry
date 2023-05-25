import 'package:socialv/model/apiModel/responseModel/get_follower_list_res_model.dart';
import 'package:socialv/model/apiModel/responseModel/pending_request_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';

class GetPendingRequestRepo extends BaseService {
  Future<PendingRequestResModel> pendingRequest() async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$getPendingRequestListURL',
    );
    return PendingRequestResModel.fromJson(response);
  }
}
