class TrendingTemplateResModel {
  int? status;
  String? msg;
  List<Data>? data;

  TrendingTemplateResModel({this.status, this.msg, this.data});

  TrendingTemplateResModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? userId;
  String? tag;
  String? templateUrl;
  String? status;
  String? createdOn;

  Data(
      {this.id,
      this.userId,
      this.tag,
      this.templateUrl,
      this.status,
      this.createdOn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tag = json['tag'];
    templateUrl = json['template_url'];
    status = json['status'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['tag'] = this.tag;
    data['template_url'] = this.templateUrl;
    data['status'] = this.status;
    data['created_on'] = this.createdOn;
    return data;
  }
}
