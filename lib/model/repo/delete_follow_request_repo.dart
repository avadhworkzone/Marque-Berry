import 'package:socialv/model/apiModel/requestModel/delete_follow_request_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class DeleteFollowRequestRepo extends BaseService {
  Future<CommonStatusMsgResModel> deleteFollowRequest(
      DeleteFollowReqModel reqBody) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqBody.toJson(),
      url: '$baseURL$deleteFollowRequestURL',
    );

    return CommonStatusMsgResModel.fromJson(response);
  }
}
