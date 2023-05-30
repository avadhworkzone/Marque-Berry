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
  String? coverPhoto;
  String? bankName;
  String? beneficiaryName;
  String? accountNumber;
  String? ifscCode;
  String? isCategorySelected;
  String? createdOn;
  String? deviceToken;
  String? referId;

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
    this.deviceToken,
    this.referId,
  });

  ValidateOTPData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'] ?? "";
    email = json['email'] ?? "";
    mobileNo = json['mobileNo'];
    otp = json['otp'];
    image = json['image'] ?? "";
    coverPhoto = json['cover_photo'] ?? "";
    bankName = json['bankName'] ?? "";
    beneficiaryName = json['beneficiaryName'] ?? "";
    accountNumber = json['accountNumber'] ?? "";
    ifscCode = json['ifscCode'] ?? "";
    isCategorySelected = json['isCategorySelected'] ?? "";
    createdOn = json['created_on'] ?? "";
    deviceToken = json['device_token'] ?? "";
    referId = json['refer_id'] ?? "";
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
    data['device_token'] = this.deviceToken;
    data['refer_id'] = this.referId;
    return data;
  }
}
