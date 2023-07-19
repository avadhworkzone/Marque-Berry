import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';

import '../../utils/enum_utils.dart';

class ReportPostRepo extends BaseService {
  Future<CommonStatusMsgResModel> reportPost(String postId) async {
    Map<String, dynamic> body = {'post_id': postId};
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: body,
      url: '$baseURL$reportPostURL',
    );

    return CommonStatusMsgResModel.fromJson(response);
  }

  Future<CommonStatusMsgResModel> deletePost(String postId) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: {"post_id": postId},
      url: '$baseURL$deletePostUrl',
    );
    return CommonStatusMsgResModel.fromJson(response);
  }
}
