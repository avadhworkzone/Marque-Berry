import 'package:socialv/model/apiModel/requestModel/suppor_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class SupportRepo extends BaseService {
  Future<CommonStatusMsgResModel> supportRepo(
      SupportReqModel supportReqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: supportReqModel.toJson(),
      url: '$baseURL$support',
    );

    return CommonStatusMsgResModel.fromJson(response);
  }
}
