class LikePostResModel {
  int? status;
  String? msg;

  LikePostResModel({
    this.status,
    this.msg,
  });

  factory LikePostResModel.fromJson(Map<String, dynamic> json) {
    return LikePostResModel(
      status: json['status'],
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.status;
    data['msg'] = this.msg;

    return data;
  }
}
