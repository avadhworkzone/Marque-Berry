class UpdateCoverPicResModel {
  String? status;
  String? message;

  UpdateCoverPicResModel({this.status, this.message});

  UpdateCoverPicResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.message;
    return data;
  }
}
