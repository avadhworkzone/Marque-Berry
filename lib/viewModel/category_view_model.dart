import 'package:get/get.dart';
import 'package:socialv/model/apiModel/requestModel/post_comment_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/report_post_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';
import 'package:socialv/model/repo/Get_all_comment_repo.dart';
import 'package:socialv/model/repo/post_comment_repo.dart';
import 'package:socialv/model/repo/report_post_repo.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/like_post_repo.dart';
import 'package:socialv/model/repo/dislike_post_repo.dart';
import 'package:socialv/model/repo/feed_category_repo.dart';
import 'package:socialv/model/apiModel/requestModel/like_post_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/dislike_post_req_model.dart';

class CategoryFeedViewModel extends GetxController {
  int _pageNumberIndex = 0;

  int get pageNumberIndex => _pageNumberIndex;

  set pageNumberIndex(int value) {
    _pageNumberIndex = value;
    update();
  }

  bool _isPageLoading = false;

  bool get isPageLoading => _isPageLoading;

  set isPageLoading(bool value) {
    _isPageLoading = value;
    update();
  }

  List<CategoryData> categoryPostList = [];

  ApiResponse categoryApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse likeApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse dislikeApiResponse = ApiResponse.initial('INITIAL');

  ApiResponse getAllCommentApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse postCommentApiResponse = ApiResponse.initial('INITIAL');

  ApiResponse reportPostApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== CATEGORY VIEW MODEL ================================
  Map<int, bool> likeUnlink = {};

  changeLikeUnlike(key, value) {
    if (likeUnlink.containsKey(key)) {
      likeUnlink[key] = value;
    } else {
      likeUnlink.addAll({key: value});
    }
    update();
  }

  clearLikeUnlink() {
    likeUnlink.clear();
    update();
  }

  Future<void> categoryTrending(String category) async {
    logs('loading..');

    if (pageNumberIndex == 0) {
      categoryApiResponse = ApiResponse.loading('LOADING');
      _isPageLoading = false;
      pageNumberIndex = 0;
      clearLikeUnlink();
      categoryPostList.clear();
      update();
    } else {
      isPageLoading = true;
    }

    try {
      final response = await FeedCategoryRepo().feedCategory(
          category: category, pageNumber: pageNumberIndex.toString());
      categoryApiResponse = ApiResponse.complete(response);
      if (response.status == 200) {
        pageNumberIndex += 1;

        // if (response.data != null) {
        for (int i = 0; i < (response.data?.length ?? 0); i++) {
          changeLikeUnlike(
            response.data?[i].id,
            response.data?[i].likedByMe ?? false,
          );
        }
        // }

        categoryPostList.addAll(response.data ?? []);
      }
    } catch (e) {
      logs('categoryApiResponse ERROR :=> $e');
      if (pageNumberIndex == 0) {
        categoryApiResponse = ApiResponse.error('ERROR');
      }
    } finally {
      isPageLoading = false;
    }
    update();
  }

  /// ======================== POST LIKE VIEW MODEL ================================
  Future<void> likePost(LikePostReqModel reqModel) async {
    logs('loading..');
    likeApiResponse = ApiResponse.loading('LOADING');
    update();

    try {
      final response = await LikePostRepo().likePost(reqModel);
      likeApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('likeApiResponse ERROR :=> $e');
      likeApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ======================== POST DIS-LIKE VIEW MODEL ================================
  Future<void> dislikePost(DisLikePostReqModel reqModel) async {
    logs('loading..');
    dislikeApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await DisLikePostRepo().dislikePost(reqModel);
      dislikeApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('dislikeApiResponse ERROR :=> $e');
      dislikeApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ===================== GET ALL COMMENTS ========================

  Future<void> getAllComments(String postId) async {
    if (getAllCommentApiResponse.status != Status.COMPLETE) {
      logs('loading..');
      getAllCommentApiResponse = ApiResponse.loading('LOADING');
      update();
    }
    try {
      final response = await GetAllCommentRepo().getAllComment(postId);
      getAllCommentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getAllCommentApiResponse ERROR :=> $e');
      getAllCommentApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ===================== POST COMMENTS ========================

  Future<void> postComments(PostCommentReqModel reqModel) async {
    logs('loading..');
    postCommentApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await PostCommentRepo().postComment(reqModel);
      postCommentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('postCommentApiResponse ERROR :=> $e');
      postCommentApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ===================== REPORT POST ========================

  Future<void> reportPost(ReportPostReqModel reqModel) async {
    logs('loading..');
    reportPostApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ReportPostRepo().reportPost(reqModel);
      reportPostApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('reportPostApiResponse ERROR :=> $e');
      reportPostApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
