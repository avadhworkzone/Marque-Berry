import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/requestModel/dislike_post_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/dislike_post_res_model.dart';

class DisLikePostRepo extends BaseService {
  Future<DisLikePostResModel> dislikePost(DisLikePostReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$dislikeURL',
    );
    return DisLikePostResModel.fromJson(response);
  }
}
