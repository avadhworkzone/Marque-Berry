class CreatePostReqModel {
  int? categoryId;
  String? content;
  String? contentType;
  String? contentUrl;

  CreatePostReqModel({
    this.categoryId,
    this.content,
    this.contentType,
    this.contentUrl,
  });

  CreatePostReqModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    content = json['content'];
    contentType = json['content_type'];
    contentUrl = json['content_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId.toString();
    data['content'] = this.content;
    data['content_type'] = this.contentType;
    data['file'] = this.contentUrl;
    return data;
  }
}
