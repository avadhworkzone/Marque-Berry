import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/responseModel/get_all_comment_res_model.dart';

class GetAllCommentRepo extends BaseService {
  Future<GetAllCommentResModel> getAllComment(String postId) async {
    Map<String, dynamic> body = {};
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      body: body,
      url: '$baseURL$getAllCommentURL?post_id=$postId',
    );
    return GetAllCommentResModel.fromJson(response);
  }
}
