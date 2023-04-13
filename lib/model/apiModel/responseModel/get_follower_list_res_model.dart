class GetFollowerListResModel {
  int? status;
  String? msg;
  List<Data>? data;

  GetFollowerListResModel({this.status, this.msg, this.data});

  GetFollowerListResModel.fromJson(Map<String, dynamic> json) {
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
  String? username;
  String? fullName;
  String? image;
  String? status;

  Data({this.id, this.username, this.fullName, this.image, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
