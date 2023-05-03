class UpdateCommentReqModel {
  String? id;
  String? comment;

  UpdateCommentReqModel({this.id, this.comment});

  UpdateCommentReqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    return data;
  }
}
