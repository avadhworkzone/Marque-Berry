class GetSearchUsersResModel {
  GetSearchUsersResModel({
      this.status, 
      this.msg, 
      this.data,});

  GetSearchUsersResModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SearchUserData.fromJson(v));
      });
    }
  }
  int? status;
  String? msg;
  List<SearchUserData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SearchUserData {
  SearchUserData({
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
      this.deviceToken, 
      this.referId, 
      this.createdOn,});

  SearchUserData.fromJson(dynamic json) {
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
    deviceToken = json['device_token'];
    referId = json['refer_id'];
    createdOn = json['created_on'];
  }
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? mobileNo;
  int? otp;
  String? image;
  dynamic coverPhoto;
  String? bankName;
  String? beneficiaryName;
  String? accountNumber;
  String? ifscCode;
  String? isCategorySelected;
  String? deviceToken;
  String? referId;
  dynamic createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['full_name'] = fullName;
    map['email'] = email;
    map['mobileNo'] = mobileNo;
    map['otp'] = otp;
    map['image'] = image;
    map['cover_photo'] = coverPhoto;
    map['bankName'] = bankName;
    map['beneficiaryName'] = beneficiaryName;
    map['accountNumber'] = accountNumber;
    map['ifscCode'] = ifscCode;
    map['isCategorySelected'] = isCategorySelected;
    map['device_token'] = deviceToken;
    map['refer_id'] = referId;
    map['created_on'] = createdOn;
    return map;
  }

}