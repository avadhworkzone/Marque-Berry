import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/requestModel/delete_comment_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/delete_comment_res_model.dart';

class DeleteCommentRepo extends BaseService {
  Future<DeleteCommentResModel> deleteComment(
      DeleteCommentReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$deleteCommentURL',
    );
    return DeleteCommentResModel.fromJson(response);
  }
}