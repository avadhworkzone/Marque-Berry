class ResultCampaignResModel {
  int? status;
  String? msg;
  List<Data>? data;

  ResultCampaignResModel({this.status, this.msg, this.data});

  ResultCampaignResModel.fromJson(Map<String, dynamic> json) {
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
  String? mediaType;
  int? wonAmount;

  Data(
      {this.username,
      this.fullName,
      this.image,
      this.mediaType,
      this.wonAmount});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullName = json['full_name'];
    image = json['image'];
    mediaType = json['media_type'];
    wonAmount = json['won_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    data['media_type'] = this.mediaType;
    data['won_amount'] = this.wonAmount;
    return data;
  }
}
