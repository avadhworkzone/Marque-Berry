class ConnectorStatusResModel {
  String? status;
  int? count;
  List<Data>? data;

  ConnectorStatusResModel({this.status, this.count, this.data});

  ConnectorStatusResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? chargeBoxName;
  String? chargeBoxId;
  String? connectorName;
  int? connectorId;
  String? errorCode;
  String? status;
  String? vendorId;
  String? vendorErrorCode;
  String? statusTimestamp;
  bool? online;
  String? heartbeatTimestamp;
  String? info;

  Data({
    this.chargeBoxName,
    this.chargeBoxId,
    this.connectorName,
    this.connectorId,
    this.errorCode,
    this.status,
    this.vendorId,
    this.vendorErrorCode,
    this.statusTimestamp,
    this.online,
    this.heartbeatTimestamp,
    this.info,
  });

  Data.fromJson(Map<String, dynamic> json) {
    chargeBoxName = json['chargeBoxName'];
    chargeBoxId = json['chargeBoxId'];
    connectorName = json['connectorName'];
    connectorId = json['connectorId'];
    errorCode = json['errorCode'];
    status = json['status'];
    vendorId = json['vendorId'];
    vendorErrorCode = json['vendorErrorCode'];
    statusTimestamp = json['statusTimestamp'];
    online = json['online'];
    heartbeatTimestamp = json['heartbeatTimestamp'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chargeBoxName'] = chargeBoxName;
    data['chargeBoxId'] = chargeBoxId;
    data['connectorName'] = connectorName;
    data['connectorId'] = connectorId;
    data['errorCode'] = errorCode;
    data['status'] = status;
    data['vendorId'] = vendorId;
    data['vendorErrorCode'] = vendorErrorCode;
    data['statusTimestamp'] = statusTimestamp;
    data['online'] = online;
    data['heartbeatTimestamp'] = heartbeatTimestamp;
    data['info'] = info;
    return data;
  }
}
