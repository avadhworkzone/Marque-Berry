import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/requestModel/create_post_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/create_post_res_model.dart';

class CreatePostRepo extends BaseService {
  Future<CreatePostResModel> createPost(CreatePostReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
      url: '$baseURL$createPostURL',
      fileUpload: true,
    );
    return CreatePostResModel.fromJson(response);
  }
}
