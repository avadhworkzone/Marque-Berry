class ReportPostReqModel {
  String? postId;

  ReportPostReqModel({this.postId});

  ReportPostReqModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    return data;
  }
}
