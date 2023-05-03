class RegisterReqModel {
  String? mobileNo;
  String? username;
  String? fullName;

  RegisterReqModel({this.mobileNo, this.username, this.fullName});

  RegisterReqModel.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobileNo'];
    username = json['username'];
    fullName = json['full_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNo'] = this.mobileNo;
    data['username'] = this.username;
    data['full_Name'] = this.fullName;
    return data;
  }
}
