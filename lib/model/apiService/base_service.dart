import 'package:socialv/utils/shared_preference_utils.dart';

abstract class BaseService {
  /// ----------------- BASE URL START -----------------------

  final String baseURL = "http://52.66.136.133:8081/";

  /// ----------------- BASE URL END -----------------------

  /// AUTH
  final String loginURL = 'login';
  final String registerURL = 'signup';
  final String validateOTPURL = 'validateOTP';

  /// WELCOME MEME
  final String userCategoryURL = 'user_category';
  final String memeCategoriesURL = 'meme_categories';

  /// HOME FEED
  final String feedCategoryURL = 'feed?category=';
  final String likeURL = 'like';
  final String dislikeURL = 'deleteLike';
  final String reportPostURL = 'ReportPost';

  final String createPostURL = 'createPost';

  /// EDIT PROFILE
  final String getUserDetails =
      'getUserDetails?userId=${PreferenceUtils.getInt(key: PreferenceUtils.userid)}';
  final String updateUserDetails = 'updateUserDetails';
  final String uploadProfilePicURL = 'upload_profile_pic';
  final String uploadCoverPhotoURL = 'upload_cover_photo';

  /// COMMENTS
  final String postCommentURL = 'postComment';
  final String deleteCommentURL = 'deleteComment';
  final String getAllCommentURL = 'getAllcomments';

  /// CAMPAIGN AND CONTEST
  final String getAllCampaignAndContestAppURL = 'getAllcampaignAndContestApp';
  final String applyCampaignURL = 'applyCampaign';
  final String applyContestURL = 'applyContest';
  final String getCampaignByIdURL = 'getCampaignById';

  /// TEMPLATE
  final String uploadTemplateURL = 'uploadTemplate';
  final String listTemplatesURL = 'listTemplates';
  final String getMyTemplatesURL = 'getMyTemplates';
  final String getTrendingTemplatesURL = 'getTrendingTemplates';

  /// FOLLOWER FOLLOWING PENDING
  final String getFollowerListURL = 'getFollowerList';
  final String getFollowingListURL = 'getFollowingList';
  final String sendFollowRequestURL = 'sendFollowRequest';
  final String acceptFollowRequestURL = 'acceptFollowRequest';
  final String deleteFollowRequestURL = 'deleteFollowRequest';
  final String getPendingRequestListURL = 'getpendingRequestList';
}
