class UpdateUserReqDetail {
  String? userId;
  String? mobileNumber;
  String? userName;
  String? fullName;
  String? bankName;
  String? beneficiaryName;
  String? accountNumber;
  String? ifscCode;

  UpdateUserReqDetail({
    this.userId,
    this.mobileNumber,
    this.userName,
    this.fullName,
    this.bankName,
    this.beneficiaryName,
    this.accountNumber,
    this.ifscCode,
  });

  UpdateUserReqDetail.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    mobileNumber = json['mobileNumber'];
    userName = json['userName'];
    fullName = json['full_name'];
    bankName = json['bankName'];
    beneficiaryName = json['beneficiaryName'];
    accountNumber = json['accountNumber'];
    ifscCode = json['ifscCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['mobileNumber'] = this.mobileNumber;
    data['userName'] = this.userName;
    data['full_name'] = this.fullName;
    data['bankName'] = this.bankName;
    data['beneficiaryName'] = this.beneficiaryName;
    data['accountNumber'] = this.accountNumber;
    data['ifscCode'] = this.ifscCode;
    return data;
  }
}
