// ignore_for_file: prefer_collection_literals, prefer_void_to_null, unnecessary_question_mark

class ViewCardResModel {
  String? status;
  int? count;
  Data? data;

  ViewCardResModel({this.status, this.count, this.data});

  ViewCardResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? driverId;
  String? parentUserId;
  String? empIdFk;
  String? accountNumber;
  String? internalClientNumber;
  String? statusType;
  String? billingType;
  String? validFromDriver;
  Null? validToDriver;
  Null? companyName;
  int? businessType;
  String? contactTitle;
  String? contactFirstName;
  String? contactLastName;
  Null? jobTitle;
  String? email;
  String? phone;
  Null? cell;
  String? addStreet;
  String? addCity;
  String? addPostalCode;
  String? addState;
  String? addCountry;
  Null? creditCardLookupId;
  String? vin;
  Null? subEmpCode;
  bool? deleted;
  List<Subscriptions>? subscriptions;

  Data(
      {this.driverId,
      this.parentUserId,
      this.empIdFk,
      this.accountNumber,
      this.internalClientNumber,
      this.statusType,
      this.billingType,
      this.validFromDriver,
      this.validToDriver,
      this.companyName,
      this.businessType,
      this.contactTitle,
      this.contactFirstName,
      this.contactLastName,
      this.jobTitle,
      this.email,
      this.phone,
      this.cell,
      this.addStreet,
      this.addCity,
      this.addPostalCode,
      this.addState,
      this.addCountry,
      this.creditCardLookupId,
      this.vin,
      this.subEmpCode,
      this.deleted,
      this.subscriptions});

  Data.fromJson(Map<String, dynamic> json) {
    driverId = json['driverId'];
    parentUserId = json['parentUserId'];
    empIdFk = json['empIdFk'];
    accountNumber = json['accountNumber'];
    internalClientNumber = json['internalClientNumber'];
    statusType = json['statusType'];
    billingType = json['billingType'];
    validFromDriver = json['validFromDriver'];
    validToDriver = json['validToDriver'];
    companyName = json['companyName'];
    businessType = json['businessType'];
    contactTitle = json['contactTitle'];
    contactFirstName = json['contactFirstName'];
    contactLastName = json['contactLastName'];
    jobTitle = json['jobTitle'];
    email = json['email'];
    phone = json['phone'];
    cell = json['cell'];
    addStreet = json['addStreet'];
    addCity = json['addCity'];
    addPostalCode = json['addPostalCode'];
    addState = json['addState'];
    addCountry = json['addCountry'];
    creditCardLookupId = json['creditCardLookupId'];
    vin = json['vin'];
    subEmpCode = json['subEmpCode'];
    deleted = json['deleted'];
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['subscriptions'].forEach((v) {
        subscriptions!.add(Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['driverId'] = driverId;
    data['parentUserId'] = parentUserId;
    data['empIdFk'] = empIdFk;
    data['accountNumber'] = accountNumber;
    data['internalClientNumber'] = internalClientNumber;
    data['statusType'] = statusType;
    data['billingType'] = billingType;
    data['validFromDriver'] = validFromDriver;
    data['validToDriver'] = validToDriver;
    data['companyName'] = companyName;
    data['businessType'] = businessType;
    data['contactTitle'] = contactTitle;
    data['contactFirstName'] = contactFirstName;
    data['contactLastName'] = contactLastName;
    data['jobTitle'] = jobTitle;
    data['email'] = email;
    data['phone'] = phone;
    data['cell'] = cell;
    data['addStreet'] = addStreet;
    data['addCity'] = addCity;
    data['addPostalCode'] = addPostalCode;
    data['addState'] = addState;
    data['addCountry'] = addCountry;
    data['creditCardLookupId'] = creditCardLookupId;
    data['vin'] = vin;
    data['subEmpCode'] = subEmpCode;
    data['deleted'] = deleted;
    if (subscriptions != null) {
      data['subscriptions'] = subscriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subscriptions {
  String? subscriptionId;
  String? pricePlanName;
  String? email;
  String? password;
  String? registrationType;
  String? idTag;
  String? idRfid;
  String? idVin;
  String? serialId;
  String? validFrom;
  String? validTo;
  bool? publicAccessRestricted;
  bool? isPasswordChanged;

  Subscriptions(
      {this.subscriptionId,
      this.pricePlanName,
      this.email,
      this.password,
      this.registrationType,
      this.idTag,
      this.idRfid,
      this.idVin,
      this.serialId,
      this.validFrom,
      this.validTo,
      this.publicAccessRestricted,
      this.isPasswordChanged});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
    pricePlanName = json['pricePlanName'];
    email = json['email'];
    password = json['password'];
    registrationType = json['registrationType'];
    idTag = json['idTag'];
    idRfid = json['idRfid'];
    idVin = json['idVin'];
    serialId = json['serialId'];
    validFrom = json['validFrom'];
    validTo = json['validTo'];
    publicAccessRestricted = json['publicAccessRestricted'];
    isPasswordChanged = json['isPasswordChanged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subscriptionId'] = subscriptionId;
    data['pricePlanName'] = pricePlanName;
    data['email'] = email;
    data['password'] = password;
    data['registrationType'] = registrationType;
    data['idTag'] = idTag;
    data['idRfid'] = idRfid;
    data['idVin'] = idVin;
    data['serialId'] = serialId;
    data['validFrom'] = validFrom;
    data['validTo'] = validTo;
    data['publicAccessRestricted'] = publicAccessRestricted;
    data['isPasswordChanged'] = isPasswordChanged;
    return data;
  }
}
