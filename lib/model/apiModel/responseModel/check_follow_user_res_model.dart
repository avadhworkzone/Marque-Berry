class CheckFollowUserResModel {
  CheckFollowUserResModel({
      this.status, 
      this.msg, 
      this.data,});

  CheckFollowUserResModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FollowUser.fromJson(v));
      });
    }
  }
  int? status;
  String? msg;
  List<FollowUser>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class FollowUser {
  FollowUser({
      this.followStatus,});

  FollowUser.fromJson(dynamic json) {
    followStatus = json['follow_status'];
  }
  String? followStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['follow_status'] = followStatus;
    return map;
  }

}