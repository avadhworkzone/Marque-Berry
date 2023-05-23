import 'package:get/get.dart';
import 'package:socialv/model/repo/get_post_detail_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/create_post_repo.dart';
import 'package:socialv/model/apiModel/requestModel/create_post_req_model.dart';

class CreatePostViewModel extends GetxController {
  ApiResponse createPostApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getPostDetailApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== CREATE POST VIEW MODEL ================================

  Future<void> createPost(CreatePostReqModel reqModel) async {
    logs('loading..');
    createPostApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await CreatePostRepo().createPost(reqModel);
      createPostApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('createPostApiResponse ERROR :=> $e');
      createPostApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== GET POST DETAIL ================================

  Future<void> getPostDetail(String postId) async {
    logs('loading..');
    getPostDetailApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetPostDetailRepo().getPost(postId);
      getPostDetailApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getPostDetailApiResponse ERROR :=> $e');
      getPostDetailApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
