import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/responseModel/get_user_res_model.dart';

class GetUserProfileRepo extends BaseService {
  Future<GetUserResDetail> getUserProfile() async {
    Map<String, dynamic> body = {};

    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      body: body,
      url: '$baseURL$getUserDetails',
    );

    return GetUserResDetail.fromJson(response);
  }
}
