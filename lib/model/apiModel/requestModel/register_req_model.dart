class RegisterReqModel {
  String? mobileNo;
  String? username;
  String? fullName;
  String? deviceToken;
  String? referId;

  RegisterReqModel(
      {this.mobileNo,
      this.username,
      this.fullName,
      this.deviceToken,
      this.referId});

  RegisterReqModel.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobileNo'];
    username = json['username'];
    fullName = json['full_name'];
    deviceToken = json['device_token'];
    referId = json['referred_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNo'] = this.mobileNo;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['device_token'] = this.deviceToken;
    data['referred_by'] = this.referId ?? "";
    return data;
  }
}
