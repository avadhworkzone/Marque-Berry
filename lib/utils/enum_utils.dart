/// API CALLING METHOD
// ignore_for_file: constant_identifier_names

enum NotificationType{Chatting,Like,Comment,FollowRequest,ConfirmRequest}

enum APIType { aPost, aGet, aDelete, aPut }

/// API HEADER TYPE
enum APIHeaderType {
  fileUploadWithToken,
  fileUploadWithoutToken,
  jsonBodyWithToken,
  jsonBodyWithoutToken,
  onlyToken
}

enum ValidationType { Password, Email, PNumber }

enum FileExt { Image, Video, Doc }

enum OtpType { Regular, Alternate }

enum ProfileBtnStatus {
  Follow,
  FollowBack,
  Following,
  Confirm,
  EditProfile,
  Requested
}
