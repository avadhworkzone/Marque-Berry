class ValidateOTPReqModel {
  String? mobileNo;
  String? otp;

  ValidateOTPReqModel({this.mobileNo, this.otp});

  ValidateOTPReqModel.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobileNo'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNo'] = this.mobileNo;
    data['otp'] = this.otp;
    return data;
  }
}
