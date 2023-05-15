class GetAllCommentResModel {
  int? status;
  String? msg;
  int? commentCount;
  List<Data>? data;

  GetAllCommentResModel({this.status, this.msg, this.commentCount, this.data});

  GetAllCommentResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    commentCount = json['commentCount'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['commentCount'] = this.commentCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? username;
  int? userid;
  String? fullName;
  String? image;
  int? commentId;
  String? comment;
  String? parentId;
  String? postId;
  String? createdOn;
  int? replyCount;
  List<ChildComment>? childComment;

  Data(
      {this.username,
      this.userid,
      this.fullName,
      this.image,
      this.commentId,
      this.comment,
      this.parentId,
      this.postId,
      this.createdOn,
      this.replyCount,
      this.childComment});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userid = json['user_id'];
    fullName = json['full_name'];
    image = json['image'];
    commentId = json['comment_id'];
    comment = json['comment'];
    parentId = json['parent_id'];
    postId = json['post_id'];
    createdOn = json['created_on'];
    replyCount = json['reply_count'];
    if (json['child_comment'] != null) {
      childComment = <ChildComment>[];
      json['child_comment'].forEach((v) {
        childComment!.add(new ChildComment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['user_id'] = this.userid;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    data['comment_id'] = this.commentId;
    data['comment'] = this.comment;
    data['parent_id'] = this.parentId;
    data['post_id'] = this.postId;
    data['created_on'] = this.createdOn;
    data['reply_count'] = this.replyCount;
    if (this.childComment != null) {
      data['child_comment'] =
          this.childComment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildComment {
  String? username;
  int? userid;
  String? fullName;
  String? image;
  int? commentId;
  String? comment;
  String? parentId;
  String? postId;
  String? createdOn;

  ChildComment(
      {this.username,
      this.userid,
      this.fullName,
      this.image,
      this.commentId,
      this.comment,
      this.parentId,
      this.postId,
      this.createdOn});

  ChildComment.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userid = json['user_id'];
    fullName = json['full_name'];
    image = json['image'];
    commentId = json['comment_id'];
    comment = json['comment'];
    parentId = json['parent_id'];
    postId = json['post_id'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['user_id'] = this.userid;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    data['comment_id'] = this.commentId;
    data['comment'] = this.comment;
    data['parent_id'] = this.parentId;
    data['post_id'] = this.postId;
    data['created_on'] = this.createdOn;
    return data;
  }
}
