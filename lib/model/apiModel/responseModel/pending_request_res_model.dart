class PendingRequestResModel {
  PendingRequestResModel({
      this.status, 
      this.msg, 
      this.data,});

  PendingRequestResModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PendingData.fromJson(v));
      });
    }
  }
  int? status;
  String? msg;
  List<PendingData>? data;

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

class PendingData {
  PendingData({
      this.requestId, 
      this.id, 
      this.username, 
      this.fullName, 
      this.image, 
      this.status,});

  PendingData.fromJson(dynamic json) {
    requestId = json['requestId'];
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    image = json['image'];
    status = json['status'];
  }
  int? requestId;
  int? id;
  String? username;
  String? fullName;
  String? image;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestId'] = requestId;
    map['id'] = id;
    map['username'] = username;
    map['full_name'] = fullName;
    map['image'] = image;
    map['status'] = status;
    return map;
  }

}