import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/requestModel/like_post_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/like_post_res_model.dart';

class LikePostRepo extends BaseService {
  Future<LikePostResModel> likePost(LikePostReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$likeURL',
    );
    return LikePostResModel.fromJson(response);
  }
}
