import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/requestModel/get_post_like_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/get_post_like_res_model.dart';

class GetPostLikeUserRepo extends BaseService {
  Future<GetPostLikeResModel> getPostLikeUser(
      GetPostLikeReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$getLikeURL',
    );

    return GetPostLikeResModel.fromJson(response);
  }
}
