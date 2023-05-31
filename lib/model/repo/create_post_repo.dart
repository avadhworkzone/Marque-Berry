import 'dart:convert';

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
      body['tag']=jsonEncode([]);
      // body.removeWhere((key, value) => key == 'tag');
    }
    // logs("IF PACHI ----------->    $body");

    if (reqModel.contentType == 'template') {
      body['content_type'] = getContentType(body['content_type']);
      body.addAll({'url':body['file']});
      body.removeWhere((key, value) => key == 'file');
      var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        body: body,
        url: '$baseURL$createPostByChooseTemplate',
      );
      return CreatePostResModel.fromJson(response);
    } else {
      var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        body: body,
        url: '$baseURL$createPostURL',
        createPostData: true,
      );
      return CreatePostResModel.fromJson(response);
    }
  }
}

String getContentType(String link) {
  String type = 'image';
  if (link.contains('.mp4') ||
      link.contains('.mov') ||
      link.contains('.wmv') ||
      link.contains('.avi') ||
      link.contains('.mpg') ||
      link.contains('.3gp') ||
      link.contains('.mkv')) {
    type = 'video';
  } else if (link.contains('.gif')) {
    type = 'gif';
  }
  return type;
}
