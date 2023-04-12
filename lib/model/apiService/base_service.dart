import 'package:socialv/utils/shared_preference_utils.dart';

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
  final String getUserDetails =
      'getUserDetails?userId=${PreferenceUtils.getInt(key: PreferenceUtils.userid)}';
  final String updateUserDetails = 'updateUserDetails';
  final String uploadProfilePicURL = 'upload_profile_pic';

  final String postCommentURL = 'postComment';
  final String deleteCommentURL = 'deleteComment';
  final String getAllCommentURL = 'getAllcomments';

  final String userCategoryURL = 'user_category';
  final String getPendingRequestListURL = 'getpendingRequestList';

  final String getFollowerListURL = 'getFollowerList';
  final String getAllCampaignAndContestAppURL = 'getAllcampaignAndContestApp';

  final String applyCampaignURL = 'applyCampaign';
  final String applyContestURL = 'applyContest';
  final String getCampaignByIdURL = 'sgetCampaignById?id=2';
}
