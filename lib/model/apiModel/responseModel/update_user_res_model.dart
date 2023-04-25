class UpdateUserResDetail {
  int? status;
  String? msg;
  String? userId;

  UpdateUserResDetail({this.status, this.msg, this.userId});

  UpdateUserResDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['userId'] = this.userId;
    return data;
  }
}
