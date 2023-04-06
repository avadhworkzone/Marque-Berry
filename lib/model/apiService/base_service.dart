abstract class BaseService {
  /// ----------------- BASE URL START -----------------------

  final String baseURL = "http://52.66.136.133:8081/";

  /// ----------------- BASE URL END -----------------------

  /// DRIVER POST
  final String loginURL = 'login';
  final String registerURL = 'signup';
  final String validateOTPURL = 'validateOTP';
  final String memeCategoriesURL = 'meme_categories';
  final String feedCategoryURL = 'feed?category=';

  final String likeURL = 'like';
  final String dislikeURL = 'deleteLike';
  final String createPostURL = 'createPost';
}
