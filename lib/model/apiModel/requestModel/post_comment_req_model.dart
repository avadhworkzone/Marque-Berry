class PostCommentReqModel {
  String? comment;
  String? parentId;
  String? postId;

  PostCommentReqModel({this.comment, this.parentId, this.postId});

  PostCommentReqModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    parentId = json['parent_id'];
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['parent_id'] = this.parentId;
    data['post_id'] = this.postId;
    return data;
  }
}
