class LoginReqModel {
  String? mobileNo;
  String? deviceToken;

  LoginReqModel({this.mobileNo, this.deviceToken});

  LoginReqModel.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobileNo'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNo'] = this.mobileNo;
    data['device_token'] = this.deviceToken;

    return data;
  }
}
