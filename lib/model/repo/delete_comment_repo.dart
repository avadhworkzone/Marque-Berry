import 'package:socialv/model/apiModel/requestModel/update_comment_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/common_status_msg_res_model.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/requestModel/delete_comment_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/delete_comment_res_model.dart';

class DeleteCommentRepo extends BaseService {
  Future<CommonStatusMsgResModel> deleteComment(
      DeleteCommentReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$deleteCommentURL',
    );
    return CommonStatusMsgResModel.fromJson(response);
  }
}

class UpdateCommentRepo extends BaseService {
  Future<CommonStatusMsgResModel> updateComment(
    UpdateCommentReqModel reqModel,
  ) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$updateCommentURL',
    );
    return CommonStatusMsgResModel.fromJson(response);
  }
}
