import 'dart:developer';

import 'package:socialv/model/apiModel/responseModel/get_post_detail_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class GetPostDetailRepo extends BaseService {
  Future<GetPostDetailResModel> getPost(String postId) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$getPostById$postId',
    );
    log('DATA ==>$response');
    // logs('RES ---->${response.runtimeType}');
    // return (response as List).map((e) => CategoryResModel.fromJson(e)).toList();
    return GetPostDetailResModel.fromJson(response);
  }
}
