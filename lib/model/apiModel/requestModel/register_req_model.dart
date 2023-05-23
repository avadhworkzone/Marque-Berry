class RegisterReqModel {
  String? mobileNo;
  String? username;
  String? fullName;
  String? deviceToken;

  RegisterReqModel({this.mobileNo, this.username, this.fullName,this.deviceToken});

  RegisterReqModel.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobileNo'];
    username = json['username'];
    fullName = json['full_name'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNo'] = this.mobileNo;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['device_token'] = this.deviceToken;
    return data;
  }
}
