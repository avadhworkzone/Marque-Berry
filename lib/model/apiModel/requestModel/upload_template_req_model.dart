class UploadTemplateReqModel {
  String? tag;
  String? template;
  String? caption;

  UploadTemplateReqModel({this.tag, this.template, this.caption});

  UploadTemplateReqModel.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    template = json['file'];
    caption = json['caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['file'] = this.template;
    data['caption'] = this.caption;
    return data;
  }
}
