import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiModel/requestModel/driver_post_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/driver_post_res_model.dart';

class DriverPostRepo extends BaseService {
  Future<DriverPostResModel> driverPost(DriverPostReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$driverPostURL',
    );
    return DriverPostResModel.fromJson(response);
  }
}
