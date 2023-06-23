import '../../utils/enum_utils.dart';
import '../apiModel/requestModel/post_comment_req_model.dart';
import '../apiModel/responseModel/post_comment_res_model.dart';
import '../apiService/api_service.dart';
import '../apiService/base_service.dart';

class WithdrawnAmountRepo extends BaseService {
  Future<PostCommentResModel> withdrawnAmountRepo() async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$withdrawalAmount',
    );
    return PostCommentResModel.fromJson(response);
  }
}
