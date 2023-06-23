import 'package:socialv/model/apiModel/requestModel/user_category_req_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

import '../apiModel/responseModel/user_category_res_model.dart';

class UserCategoryRepo extends BaseService {
  Future<UserCategoryResModel> userCategory(
      UserCategoryReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$userCategoryURL',
    );

    return UserCategoryResModel.fromJson(response);
  }
}
