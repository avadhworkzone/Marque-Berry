import 'package:socialv/model/apiModel/requestModel/update_user_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/update_user_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class UpdateUserProfileRepo extends BaseService {
  Future<UpdateUserResDetail> updateUserProfile(
      UpdateUserReqDetail reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$updateUserDetails',
    );

    return UpdateUserResDetail.fromJson(response);
  }
}
