class GetAllCommentResModel {
  int? status;
  String? msg;
  List<Data>? data;

  GetAllCommentResModel({this.status, this.msg, this.data});

  GetAllCommentResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? username;
  String? fullName;
  String? image;
  int? commentId;
  String? comment;
  String? parentId;
  String? postId;

  Data(
      {this.username,
      this.fullName,
      this.image,
      this.commentId,
      this.comment,
      this.parentId,
      this.postId});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullName = json['full_name'];
    image = json['image'];
    commentId = json['comment_id'];
    comment = json['comment'];
    parentId = json['parent_id'];
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    data['comment_id'] = this.commentId;
    data['comment'] = this.comment;
    data['parent_id'] = this.parentId;
    data['post_id'] = this.postId;
    return data;
  }
}
