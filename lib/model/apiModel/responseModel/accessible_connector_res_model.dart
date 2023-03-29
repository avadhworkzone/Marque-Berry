class AccessibleConnectorsResModel {
  String? status;
  int? count;
  Data? data;

  AccessibleConnectorsResModel({this.status, this.count, this.data});

  AccessibleConnectorsResModel.fromJson(Map<String, dynamic> json) {
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
  String? accessType;
  List<ChargeBoxes>? chargeBoxes;

  Data({this.accessType, this.chargeBoxes});

  Data.fromJson(Map<String, dynamic> json) {
    accessType = json['accessType'];
    if (json['chargeBoxes'] != null) {
      chargeBoxes = <ChargeBoxes>[];
      json['chargeBoxes'].forEach((v) {
        chargeBoxes!.add(ChargeBoxes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessType'] = accessType;
    if (chargeBoxes != null) {
      data['chargeBoxes'] = chargeBoxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChargeBoxes {
  String? chargeBoxName;
  String? chargeBoxId;
  bool? online;
  String? heartbeatTimestamp;
  double? gpsLat;
  double? gpsLng;
  String? street;
  String? city;
  String? zip;
  String? country;
  String? manufacturer;
  String? model;
  List<Connectors>? connectors;

  ChargeBoxes({
    this.chargeBoxName,
    this.chargeBoxId,
    this.online,
    this.heartbeatTimestamp,
    this.gpsLat,
    this.gpsLng,
    this.street,
    this.city,
    this.zip,
    this.country,
    this.manufacturer,
    this.model,
    this.connectors,
  });

  ChargeBoxes.fromJson(Map<String, dynamic> json) {
    chargeBoxName = json['chargeBoxName'];
    chargeBoxId = json['chargeBoxId'];
    online = json['online'] ?? false;
    heartbeatTimestamp = json['heartbeatTimestamp'];
    gpsLat = json['gpsLat'];
    gpsLng = json['gpsLng'];
    street = json['street'];
    city = json['city'];
    zip = json['zip'];
    country = json['country'];
    manufacturer = json['manufacturer'];
    model = json['model'];
    if (json['connectors'] != null) {
      connectors = <Connectors>[];
      json['connectors'].forEach((v) {
        connectors!.add(Connectors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chargeBoxName'] = chargeBoxName;
    data['chargeBoxId'] = chargeBoxId;
    data['online'] = online;
    data['heartbeatTimestamp'] = heartbeatTimestamp;
    data['gpsLat'] = gpsLat;
    data['gpsLng'] = gpsLng;
    data['street'] = street;
    data['city'] = city;
    data['zip'] = zip;
    data['country'] = country;
    data['manufacturer'] = manufacturer;
    data['model'] = model;
    if (connectors != null) {
      data['connectors'] = connectors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Connectors {
  String? connectorName;
  int? connectorId;
  String? errorCode;
  String? status;
  String? info;
  String? plugType;
  String? statusTimestamp;

  Connectors({
    this.connectorName,
    this.connectorId,
    this.errorCode,
    this.status,
    this.info,
    this.plugType,
    this.statusTimestamp,
  });

  Connectors.fromJson(Map<String, dynamic> json) {
    connectorName = json['connectorName'];
    connectorId = json['connectorId'];
    errorCode = json['errorCode'];
    status = json['status'];
    info = json['info'];
    plugType = json['plugType'];
    statusTimestamp = json['statusTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['connectorName'] = connectorName;
    data['connectorId'] = connectorId;
    data['errorCode'] = errorCode;
    data['status'] = status;
    data['info'] = info;
    data['plugType'] = plugType;
    data['statusTimestamp'] = statusTimestamp;
    return data;
  }
}
