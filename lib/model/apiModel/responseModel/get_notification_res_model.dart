class GetNotificationListResModel {
  GetNotificationListResModel({
      this.status, 
      this.msg, 
      this.data,});

  GetNotificationListResModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NotificationData.fromJson(v));
      });
    }
  }
  int? status;
  String? msg;
  List<NotificationData>? data;

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

class NotificationData {
  NotificationData({
      this.id, 
      this.title, 
      this.message, 
      this.userId, 
      this.createdOn,});

  NotificationData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    userId = json['user_id'];
    createdOn = json['created_on'];
  }
  int? id;
  String? title;
  String? message;
  String? userId;
  String? createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['message'] = message;
    map['user_id'] = userId;
    map['created_on'] = createdOn;
    return map;
  }

}