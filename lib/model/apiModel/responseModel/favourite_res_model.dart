class FavouriteResModel {
  String? status;
  int? count;
  List<FavouriteData>? data;

  FavouriteResModel({this.status, this.count, this.data});

  FavouriteResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    if (json['data'] != null) {
      data = <FavouriteData>[];
      json['data'].forEach((v) {
        data!.add(FavouriteData.fromJson(v));
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

class FavouriteData {
  String? chargeBoxName;
  String? chargeBoxId;
  String? online;
  String? connectorImage;
  String? heartbeatTimestamp;
  double? gpsLat;
  double? gpsLng;
  String? street;
  String? city;
  String? zip;
  String? country;
  String? manufacturer;
  Null? model;
  List<Connectors>? connectors;

  FavouriteData({
    this.chargeBoxName,
    this.chargeBoxId,
    this.online,
    this.connectorImage,
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

  FavouriteData.fromJson(Map<String, dynamic> json) {
    chargeBoxName = json['chargeBoxName'];
    chargeBoxId = json['chargeBoxId'];
    online = json['online'] ?? "false";
    connectorImage = json['connectorImage'];
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
    data['connectorImage'] = connectorImage;
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
  String? statusTimestamp;
  String? plugType;

  Connectors({
    this.connectorName,
    this.connectorId,
    this.errorCode,
    this.status,
    this.info,
    this.statusTimestamp,
    this.plugType,
  });

  Connectors.fromJson(Map<String, dynamic> json) {
    connectorName = json['connectorName'];
    connectorId = json['connectorId'];
    errorCode = json['errorCode'];
    status = json['status'];
    info = json['info'];
    statusTimestamp = json['statusTimestamp'];
    plugType = json['plugType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['connectorName'] = connectorName;
    data['connectorId'] = connectorId;
    data['errorCode'] = errorCode;
    data['status'] = status;
    data['info'] = info;
    data['statusTimestamp'] = statusTimestamp;
    data['plugType'] = plugType;
    return data;
  }
}
