class DriverPostReqModel {
  String? internalClientNumber;
  String? targetEmpId;
  String? statusType;
  String? contactLastName;
  String? validFromDriver;
  String? billingType;
  String? contactFirstName;
  String? email;
  String? addState;
  Null? driverId;
  String? vin;
  bool? deleted;
  String? validToDriver;
  String? companyName;
  String? businessType;
  String? contactTitle;
  String? jobTitle;
  String? phone;
  String? cell;
  String? addStreet;
  String? addCity;
  String? addPostalCode;
  String? addCountry;

  DriverPostReqModel({
    this.internalClientNumber,
    this.targetEmpId,
    this.statusType,
    this.contactLastName,
    this.validFromDriver,
    this.billingType,
    this.contactFirstName,
    this.email,
    this.addState,
    this.driverId,
    this.vin,
    this.deleted,
    this.validToDriver,
    this.companyName,
    this.businessType,
    this.contactTitle,
    this.jobTitle,
    this.phone,
    this.cell,
    this.addStreet,
    this.addCity,
    this.addPostalCode,
    this.addCountry,
  });

  DriverPostReqModel.fromJson(Map<String, dynamic> json) {
    internalClientNumber = json['internalClientNumber'];
    targetEmpId = json['targetEmpId'];
    statusType = json['statusType'];
    contactLastName = json['contactLastName'];
    validFromDriver = json['validFromDriver'];
    billingType = json['billingType'];
    contactFirstName = json['contactFirstName'];
    email = json['email'];
    addState = json['addState'];
    driverId = json['driverId'];
    vin = json['vin'];
    deleted = json['deleted'];
    validToDriver = json['validToDriver'];
    companyName = json['companyName'];
    businessType = json['businessType'];
    contactTitle = json['contactTitle'];
    jobTitle = json['jobTitle'];
    phone = json['phone'];
    cell = json['cell'];
    addStreet = json['addStreet'];
    addCity = json['addCity'];
    addPostalCode = json['addPostalCode'];
    addCountry = json['addCountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['internalClientNumber'] = internalClientNumber;
    data['targetEmpId'] = targetEmpId;
    data['statusType'] = statusType;
    data['contactLastName'] = contactLastName;
    data['validFromDriver'] = validFromDriver;
    data['billingType'] = billingType;
    data['contactFirstName'] = contactFirstName;
    data['email'] = email;
    data['addState'] = addState;
    data['driverId'] = driverId;
    data['vin'] = vin;
    data['deleted'] = deleted;
    data['validToDriver'] = validToDriver;
    data['companyName'] = companyName;
    data['businessType'] = businessType;
    data['contactTitle'] = contactTitle;
    data['jobTitle'] = jobTitle;
    data['phone'] = phone;
    data['cell'] = cell;
    data['addStreet'] = addStreet;
    data['addCity'] = addCity;
    data['addPostalCode'] = addPostalCode;
    data['addCountry'] = addCountry;
    return data;
  }
}
