class GetFollowingListResModel {
  int? status;
  String? msg;
  List<FollowingData>? data;

  GetFollowingListResModel({this.status, this.msg, this.data});

  GetFollowingListResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <FollowingData>[];
      json['data'].forEach((v) {
        data!.add(new FollowingData.fromJson(v));
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

class FollowingData {
  int? id;
  String? username;
  String? fullName;
  String? image;
  String? status;
  DateTime? lastMsgTime;

  FollowingData(
      {this.id,
      this.username,
      this.fullName,
      this.image,
      this.status,
      this.lastMsgTime});

  FollowingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    image = json['image'];
    status = json['status'];
    lastMsgTime = json['last_message_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    data['status'] = this.status;
    data['last_message_time'] = this.lastMsgTime;

    return data;
  }
}
