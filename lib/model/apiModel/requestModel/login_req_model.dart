class LoginReqModel {
  String? mobileNo;

  LoginReqModel({this.mobileNo});

  LoginReqModel.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNo'] = this.mobileNo;
    return data;
  }
}
