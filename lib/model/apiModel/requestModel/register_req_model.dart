class RegisterReqModel {
  String? mobileNo;
  String? username;

  RegisterReqModel({this.mobileNo, this.username});

  RegisterReqModel.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobileNo'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNo'] = this.mobileNo;
    data['username'] = this.username;
    return data;
  }
}
