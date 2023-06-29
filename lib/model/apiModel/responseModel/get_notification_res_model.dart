class NotificationListResModel {
  int? status;
  List<Data>? data;

  NotificationListResModel({this.status, this.data});

  NotificationListResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? message;
  String? userId;
  String? dataId;
  String? isRead;
  String? createdOn;
  String? username;
  String? fullName;
  String? image;

  Data(
      {this.id,
      this.title,
      this.message,
      this.userId,
      this.dataId,
      this.isRead,
      this.createdOn,
      this.username,
      this.fullName,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    userId = json['user_id'];
    dataId = json['data_id'];
    isRead = json['is_read'];
    createdOn = json['created_on'];
    username = json['username'];
    fullName = json['full_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['data_id'] = this.dataId;
    data['is_read'] = this.isRead;
    data['created_on'] = this.createdOn;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    return data;
  }
}
