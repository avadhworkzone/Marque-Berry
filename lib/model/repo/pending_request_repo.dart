import 'package:socialv/model/apiModel/responseModel/pending_request_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';

class UserCategoryRepo extends BaseService {
  Future<PendingUserResModel> userCategory() async {
    Map<String, dynamic> body = {};
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      body: body,
      url: '$baseURL$getPendingRequestListURL',
    );

    return PendingUserResModel.fromJson(response);
  }
}
