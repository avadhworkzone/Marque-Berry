class UserProfileResModel {
  UserProfileResModel({
      this.status, 
      this.message, 
      this.data, 
      this.myProfile,});

  UserProfileResModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(UserProfileData.fromJson(v));
      });
    }
    myProfile = json['my_profile'];
  }
  int? status;
  String? message;
  List<UserProfileData>? data;
  bool? myProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['my_profile'] = myProfile;
    return map;
  }

}

class UserProfileData {
  UserProfileData({
      this.id, 
      this.username, 
      this.fullName, 
      this.image, 
      this.coverPhoto, 
      this.followersCount, 
      this.followingCount, 
      this.postsCount, 
      this.posts, 
      this.mention, 
      this.tag,this.subTag});

  UserProfileData.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    image = json['image'];
    coverPhoto = json['cover_photo'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    postsCount = json['posts_count'];
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts?.add(Posts.fromJson(v));
      });
    }
    // if (json['mention'] != null) {
    //   mention = [];
    //   json['mention'].forEach((v) {
    //     mention?.add(Dynamic.fromJson(v));
    //   });
    // }
    tag = json['tag'];
    subTag = json['sub_tag']??"";
  }
  int? id;
  String? username;
  String? fullName;
  String? image;
  String? coverPhoto;
  int? followersCount;
  int? followingCount;
  int? postsCount;
  List<Posts>? posts;
  List<dynamic>? mention;
  String? tag;
  String? subTag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['full_name'] = fullName;
    map['image'] = image;
    map['cover_photo'] = coverPhoto;
    map['followers_count'] = followersCount;
    map['following_count'] = followingCount;
    map['posts_count'] = postsCount;
    if (posts != null) {
      map['posts'] = posts?.map((v) => v.toJson()).toList();
    }
    if (mention != null) {
      map['mention'] = mention?.map((v) => v.toJson()).toList();
    }
    map['tag'] = tag;
    map['sub_tag'] = subTag;
    return map;
  }

}

class Posts {
  Posts({
      this.id, 
      this.content, 
      this.contentType, 
      this.contentUrl, 
      this.createdOn, 
      this.userId, 
      this.userUsername, 
      this.userFullName, 
      this.userImage, 
      this.userCoverPhoto, 
      this.likesCount, 
      this.commentsCount,});

  Posts.fromJson(dynamic json) {
    id = json['id'];
    content = json['content'];
    contentType = json['content_type'];
    contentUrl = json['content_url'];
    createdOn = json['created_on'];
    userId = json['user_id'];
    userUsername = json['user_username'];
    userFullName = json['user_full_name'];
    userImage = json['user_image'];
    userCoverPhoto = json['user_cover_photo'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
  }
  int? id;
  String? content;
  String? contentType;
  String? contentUrl;
  String? createdOn;
  int? userId;
  String? userUsername;
  String? userFullName;
  String? userImage;
  String? userCoverPhoto;
  int? likesCount;
  int? commentsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['content'] = content;
    map['content_type'] = contentType;
    map['content_url'] = contentUrl;
    map['created_on'] = createdOn;
    map['user_id'] = userId;
    map['user_username'] = userUsername;
    map['user_full_name'] = userFullName;
    map['user_image'] = userImage;
    map['user_cover_photo'] = userCoverPhoto;
    map['likes_count'] = likesCount;
    map['comments_count'] = commentsCount;
    return map;
  }

}