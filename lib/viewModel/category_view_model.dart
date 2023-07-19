import 'package:get/get.dart';
import 'package:socialv/model/apiModel/requestModel/delete_comment_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/dislike_post_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/get_post_like_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/like_post_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/post_comment_req_model.dart';
import 'package:socialv/model/apiModel/requestModel/update_comment_req_model.dart';
import 'package:socialv/model/apiModel/responseModel/category_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/Get_all_comment_repo.dart';
import 'package:socialv/model/repo/delete_comment_repo.dart';
import 'package:socialv/model/repo/dislike_post_repo.dart';
import 'package:socialv/model/repo/feed_category_repo.dart';
import 'package:socialv/model/repo/like_post_repo.dart';
import 'package:socialv/model/repo/post_comment_repo.dart';
import 'package:socialv/model/repo/post_like_user_repo.dart';
import 'package:socialv/model/repo/report_post_repo.dart';
import 'package:socialv/utils/const_utils.dart';

class CategoryFeedViewModel extends GetxController {
  int _pageNumberIndex = 0;

  int get pageNumberIndex => _pageNumberIndex;

  set pageNumberIndex(int value) {
    _pageNumberIndex = value;
    update();
  }

  void initCall() {
    _pageNumberIndex = 0;
    _isPageLoading = false;
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
  ApiResponse updateCommentApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse deleteCommentApiResponse = ApiResponse.initial('INITIAL');

  ApiResponse reportPostApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse deletePostApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getLikeByUserApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse postLikeInCommentApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== CATEGORY VIEW MODEL ================================
  Map<int, bool> likeUnlink = {};

  /// LIKE UNLIKE
  setLikeUnlike(key, value) {
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

  /// ==================
  Map<int, bool> followUnfollow = {};

  setFollowData(int userId, bool followStatus) {
    if (followUnfollow.containsKey(userId)) {
      followUnfollow[userId] = followStatus;
    } else {
      followUnfollow.addAll({userId: followStatus});
    }
    update();
  }

  clearFollowData() {
    followUnfollow.clear();
    update();
  }

  /// ======================= CATEGORY TRENDING VIEW MODEL ========================

  Future<void> categoryTrending(String category, {bool isReload = true}) async {
    logs('loading..');

    if (pageNumberIndex == 0) {
      _isPageLoading = false;
      pageNumberIndex = 0;

      if (isReload) {
        categoryApiResponse = ApiResponse.loading('LOADING');
        categoryPostList.clear();
        clearLikeUnlink();
        clearFollowData();
      }
      update();
    } else {
      isPageLoading = true;
    }

    try {
      final response = await FeedCategoryRepo().feedCategory(
          category: category, pageNumber: pageNumberIndex.toString());
      categoryApiResponse = ApiResponse.complete(response);
      if (response.status == 200) {
        if (pageNumberIndex == 0) {
          categoryPostList.clear();
        }
        pageNumberIndex += 1;

        // if (response.data != null) {
        for (int i = 0; i < (response.data?.length ?? 0); i++) {
          setLikeUnlike(
            response.data?[i].id,
            response.data?[i].likedByMe ?? false,
          );
          if (response.data?[i].userId != null) {
            setFollowData(
              int.parse(response.data?[i].userId ?? ""),
              response.data?[i].followedByMe ?? false,
            );
          }
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

  /// ======================== POST LIKE VIEW MODEL ===================================
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

  Future<void> deleteComment(DeleteCommentReqModel reqMode) async {
    // if (getAllCommentApiResponse.status != Status.COMPLETE) {
    //   logs('loading..');
    //   getAllCommentApiResponse = ApiResponse.loading('LOADING');
    //   update();
    // }
    try {
      final response = await DeleteCommentRepo().deleteComment(reqMode);
      deleteCommentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('deleteCommentApiResponse ERROR :=> $e');
      deleteCommentApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  Future<void> updateComment(UpdateCommentReqModel reqMode) async {
    // if (getAllCommentApiResponse.status != Status.COMPLETE) {
    //   logs('loading..');
    //   getAllCommentApiResponse = ApiResponse.loading('LOADING');
    //   update();
    // }
    try {
      final response = await UpdateCommentRepo().updateComment(reqMode);
      updateCommentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('updateCommentApiResponse ERROR :=> $e');
      updateCommentApiResponse = ApiResponse.error('ERROR');
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

  Future<void> reportPost(String postId) async {
    logs('loading..');
    reportPostApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ReportPostRepo().reportPost(postId);
      reportPostApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('reportPostApiResponse ERROR :=> $e');
      reportPostApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ===================== DELETE POST ========================

  Future<void> deletePost(String postId) async {
    logs('loading..');
    deletePostApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ReportPostRepo().deletePost(postId);
      deletePostApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('deletePostApiResponse ERROR :=> $e');
      deletePostApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ===================== GET POST LIKE BY USER POST ========================

  Future<void> getLikeByUser(GetPostLikeReqModel reqModel) async {
    logs('loading..');
    getLikeByUserApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetPostLikeUserRepo().getPostLikeUser(reqModel);
      getLikeByUserApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('getLikeByUserApiResponse ERROR :=> $e');
      getLikeByUserApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ===================== POST LIKE IN COMMENT ========================

  Future<void> postLikeInComment(
      {required String commentId,
      required String postId,
      bool isLiked = false}) async {
    logs('loading..');
    postLikeInCommentApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await LikeCommentRepo()
          .likeComment(commentId: commentId, postId: postId, isLiked: isLiked);
      postLikeInCommentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('postLikeInCommentApiResponse ERROR :=> $e');
      postLikeInCommentApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
