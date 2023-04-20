class UploadTemplateReqModel {
  String? tag;
  String? template;

  UploadTemplateReqModel({this.tag, this.template});

  UploadTemplateReqModel.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    template = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['file'] = this.template;
    return data;
  }
}
