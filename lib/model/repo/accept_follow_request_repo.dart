import 'package:socialv/model/apiModel/requestModel/delete_follow_request_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';

class AcceptFollowRequestRepo extends BaseService {
  Future<CommonStatusMsgResModel> acceptFollowRequest(String requestId) async {
    Map<String, dynamic> body = {'requestId': requestId};
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: body,
      url: '$baseURL$acceptFollowRequestURL',
    );

    return CommonStatusMsgResModel.fromJson(response);
  }
}
