import 'package:socialv/model/apiModel/requestModel/register_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/register_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class RegisterRepo extends BaseService {
  Future<RegisterResModel> register(RegisterReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$registerURL',
    );
    return RegisterResModel.fromJson(response);
  }
}
