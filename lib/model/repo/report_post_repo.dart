import 'package:socialv/model/apiModel/requestModel/report_post_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';

import '../../utils/enum_utils.dart';

class ReportPostRepo extends BaseService {
  Future<CommonStatusMsgResModel> reportPost(
      ReportPostReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$reportPostURL',
    );

    return CommonStatusMsgResModel.fromJson(response);
  }
}
