import 'package:socialv/model/apiModel/requestModel/user_category_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/pending_request_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import '../apiModel/responseModel/user_category_res_model.dart';

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
