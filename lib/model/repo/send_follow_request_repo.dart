import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class SendFollowRequestRepo extends BaseService {
  Future<CommonStatusMsgResModel> sendFollowRequest(String userId) async {
    Map<String, dynamic> body = {'user_id': userId};
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: body,
      url: '$baseURL$sendFollowRequestURL',
    );

    return CommonStatusMsgResModel.fromJson(response);
  }
}
