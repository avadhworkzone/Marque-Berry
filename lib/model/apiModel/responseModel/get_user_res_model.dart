class GetUserResDetail {
  int? status;
  String? msg;
  List<Data>? data;

  GetUserResDetail({this.status, this.msg, this.data});

  GetUserResDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? mobileNo;
  int? otp;
  String? image;
  Null? coverPhoto;
  String? bankName;
  String? beneficiaryName;
  String? accountNumber;
  String? ifscCode;
  String? isCategorySelected;
  Null? createdOn;

  Data(
      {this.id,
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
      this.createdOn});

  Data.fromJson(Map<String, dynamic> json) {
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
