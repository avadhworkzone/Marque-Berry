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
  final String getLikeURL = 'getPostLikesUsers';
  final String likeURL = 'like';
  final String dislikeURL = 'deleteLike';
  final String reportPostURL = 'ReportPost';
  final String createPostURL = 'createPost';
  final String createPostByChooseTemplate = 'createPostByChooseTemplate';
  final String getPostById = 'getPostById?post_id=';
  final String postLikesInComments = 'postLikesInComments';
  final String deleteLikesInComments = 'deleteLikesInComments';

  /// DRAWER
  final String noteFromAdoro = 'noteFromAdoro';
  final String support = 'support';
  final String getNotification = 'getNotification';
  final String getWalletBalance = 'getWalletBalance';
  final String changeNotificationStatus = 'changeNotificationStatus';

  /// EDIT PROFILE
  final String getUserDetails = 'getUserDetails?userId=';
  final String getProfileDetails = 'getProfileById?userId=';
  final String updateUserDetails = 'updateUserDetails';
  final String uploadProfilePicURL = 'upload_profile_pic';
  final String uploadCoverPhotoURL = 'upload_cover_photo';

  /// COMMENTS
  final String postCommentURL = 'postComment';
  final String deleteCommentURL = 'deleteComment';
  final String getAllCommentURL = 'getAllcomments';
  final String updateCommentURL = 'updateComment';
  final String searchUsers = 'search?content=';

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
  final String getFollowerListURL = 'getFollowerList?user_id=';
  final String getFollowingListURL = 'getFollowingList?user_id=';
  final String sendFollowRequestURL = 'sendFollowRequest';
  final String acceptFollowRequestURL = 'acceptFollowRequest';
  final String deleteFollowRequestURL = 'deleteFollowRequest';
  final String getPendingRequestListURL = 'getpendingRequestList';
  final String checkUserFollowedByMe = 'checkUserFollowedByMe?user_id=';

  final String withdrawalAmount = 'send_withdrawal_otp';
  final String withdrawalAmountOtpValidate = 'validateWithdrawOTP';
  final String resultCompletedCampaign = 'getCompletedCampaign';
  final String getResults = 'getResults';
}
