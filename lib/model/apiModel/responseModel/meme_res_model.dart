class MemeCategoryResModel {
  int? status;
  String? msg;
  List<MemeData>? data;

  MemeCategoryResModel({this.status, this.msg, this.data});

  MemeCategoryResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <MemeData>[];
      json['data'].forEach((v) {
        data!.add(new MemeData.fromJson(v));
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

class MemeData {
  int? id;
  String? title;
  String? imageUrl;

  MemeData({this.id, this.title, this.imageUrl});

  MemeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
