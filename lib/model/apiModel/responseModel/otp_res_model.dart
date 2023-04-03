class ValidateOTPResModel {
  int? status;
  String? msg;
  String? token;
  ValidateOTPData? data;

  ValidateOTPResModel({this.status, this.msg, this.token, this.data});

  ValidateOTPResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    token = json['token'];
    data = json['data'] != null
        ? new ValidateOTPData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ValidateOTPData {
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? mobileNo;
  int? otp;
  String? image;
  Null? coverPhoto;
  Null? bankName;
  Null? beneficiaryName;
  Null? accountNumber;
  Null? ifscCode;
  String? isCategorySelected;
  Null? createdOn;

  ValidateOTPData({
    this.id,
    this.username,
    this.fullName,
    this.email,
    this.mobileNo,
    this.otp,
    this.image,
    this.coverPhoto,
    this.bankName,
    this.beneficiaryName,
    this.accountNumber,
    this.ifscCode,
    this.isCategorySelected,
    this.createdOn,
  });

  ValidateOTPData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    otp = json['otp'];
    image = json['image'];
    coverPhoto = json['cover_photo'];
    bankName = json['bankName'];
    beneficiaryName = json['beneficiaryName'];
    accountNumber = json['accountNumber'];
    ifscCode = json['ifscCode'];
    isCategorySelected = json['isCategorySelected'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['otp'] = this.otp;
    data['image'] = this.image;
    data['cover_photo'] = this.coverPhoto;
    data['bankName'] = this.bankName;
    data['beneficiaryName'] = this.beneficiaryName;
    data['accountNumber'] = this.accountNumber;
    data['ifscCode'] = this.ifscCode;
    data['isCategorySelected'] = this.isCategorySelected;
    data['created_on'] = this.createdOn;
    return data;
  }
}
