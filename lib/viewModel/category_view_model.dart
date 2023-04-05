import 'package:get/get.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/model/repo/feed_category_repo.dart';

class CategoryFeedViewModel extends GetxController {
  ApiResponse categoryApiResponse = ApiResponse.initial('INITIAL');

  /// ======================== CATEGORY VIEW MODEL ================================

  Future<void> categoryTrending(String category) async {
    logs('loading..');
    categoryApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await FeedCategoryRepo().feedCategory(category: category);
      categoryApiResponse = ApiResponse.complete(response);
    } catch (e) {
      logs('categoryApiResponse ERROR :=> $e');
      categoryApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
