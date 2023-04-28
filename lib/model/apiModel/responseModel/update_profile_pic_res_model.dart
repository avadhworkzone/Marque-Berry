class UpdateProfilePicResModel {
  int? status;
  String? message;

  UpdateProfilePicResModel({this.status, this.message});

  UpdateProfilePicResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.message;
    return data;
  }
}
