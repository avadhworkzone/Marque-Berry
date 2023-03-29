class DriverPostResModel {
  String? status;
  int? count;
  Data? data;

  DriverPostResModel({this.status, this.count, this.data});

  DriverPostResModel.fromJson(Map<String, dynamic> json) {
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
  String? createdBy;
  String? creationDate;
  String? lastModifiedBy;
  String? lastModifiedDate;
  String? driverId;
  String? parentUserId;
  String? empIdFk;
  String? accountNumber;
  String? internalClientNumber;
  String? statusType;
  String? billingType;
  String? validFromDriver;
  String? validToDriver;
  String? companyName;
  int? businessType;
  String? contactTitle;
  String? contactFirstName;
  String? contactLastName;
  String? jobTitle;
  String? email;
  String? phone;
  String? cell;
  String? addStreet;
  String? addCity;
  String? addPostalCode;
  String? addState;
  String? addDistrict;
  String? addCountry;
  String? creditCardLookupId;
  String? subscriptionArray;
  String? vin;
  String? subEmpCode;
  bool? deleted;
  String? paymentMethod;
  String? paymentGateway;

  Data({
    this.createdBy,
    this.creationDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.driverId,
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
    this.addDistrict,
    this.addCountry,
    this.creditCardLookupId,
    this.subscriptionArray,
    this.vin,
    this.subEmpCode,
    this.deleted,
    this.paymentMethod,
    this.paymentGateway,
  });

  Data.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'] ?? "";
    creationDate = json['creationDate'] ?? "";
    lastModifiedBy = json['lastModifiedBy'] ?? "";
    lastModifiedDate = json['lastModifiedDate'] ?? "";
    driverId = json['driverId'] ?? "";
    parentUserId = json['parentUserId'] ?? "";
    empIdFk = json['empIdFk'] ?? "";
    accountNumber = json['accountNumber'] ?? "";
    internalClientNumber = json['internalClientNumber'] ?? "";
    statusType = json['statusType'] ?? "";
    billingType = json['billingType'] ?? "";
    validFromDriver = json['validFromDriver'] ?? "";
    validToDriver = json['validToDriver'] ?? "";
    companyName = json['companyName'] ?? "";
    businessType = json['businessType'] ?? "";
    contactTitle = json['contactTitle'] ?? "";
    contactFirstName = json['contactFirstName'] ?? "";
    contactLastName = json['contactLastName'] ?? "";
    jobTitle = json['jobTitle'] ?? "";
    email = json['email'] ?? "";
    phone = json['phone'] ?? "";
    cell = json['cell'] ?? "";
    addStreet = json['addStreet'] ?? "";
    addCity = json['addCity'] ?? "";
    addPostalCode = json['addPostalCode'] ?? "";
    addState = json['addState'] ?? "";
    addDistrict = json['addDistrict'] ?? "";
    addCountry = json['addCountry'] ?? "";
    creditCardLookupId = json['creditCardLookupId'] ?? "";
    subscriptionArray = json['subscriptionArray'] ?? "";
    vin = json['vin'] ?? "";
    subEmpCode = json['subEmpCode'] ?? "";
    deleted = json['deleted'] ?? "";
    paymentMethod = json['paymentMethod'] ?? "";
    paymentGateway = json['paymentGateway'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdBy'] = createdBy;
    data['creationDate'] = creationDate;
    data['lastModifiedBy'] = lastModifiedBy;
    data['lastModifiedDate'] = lastModifiedDate;
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
    data['addDistrict'] = addDistrict;
    data['addCountry'] = addCountry;
    data['creditCardLookupId'] = creditCardLookupId;
    data['subscriptionArray'] = subscriptionArray;
    data['vin'] = vin;
    data['subEmpCode'] = subEmpCode;
    data['deleted'] = deleted;
    data['paymentMethod'] = paymentMethod;
    data['paymentGateway'] = paymentGateway;
    return data;
  }
}
