import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/model/apiModel/requestModel/create_post_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/create_post_res_model.dart';

class CreatePostRepo extends BaseService {
  Future<CreatePostResModel> createPost(CreatePostReqModel reqModel) async {
    Map<String, dynamic> body = reqModel.toJson();

    // logs("IF PAHELA ----------->    $body");

    if (reqModel.tag == '' || reqModel.tag == null) {
      body.removeWhere((key, value) => key == 'tag');
    }
    // logs("IF PACHI ----------->    $body");

    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: body,
      url: '$baseURL$createPostURL',
      createPostData: true,
    );
    return CreatePostResModel.fromJson(response);
  }
}
