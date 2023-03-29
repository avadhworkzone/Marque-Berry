class ChargingDetailsResModel {
  String? status;
  Data? data;

  ChargingDetailsResModel({this.status, this.data});

  ChargingDetailsResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? stationName;
  String? stationBoxId;
  String? eroaming;
  String? operatorName;
  StationAddress? stationAddress;
  List<Connectors>? connectors;

  Data({
    this.stationName,
    this.stationBoxId,
    this.eroaming,
    this.operatorName,
    this.stationAddress,
    this.connectors,
  });

  Data.fromJson(Map<String, dynamic> json) {
    stationName = json['stationName'];
    stationBoxId = json['stationBoxId'];
    eroaming = json['eroaming'];
    operatorName = json['operatorName'];
    stationAddress = json['stationAddress'] != null
        ? StationAddress.fromJson(json['stationAddress'])
        : null;
    if (json['connectors'] != null) {
      connectors = <Connectors>[];
      json['connectors'].forEach((v) {
        connectors!.add(Connectors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stationName'] = stationName;
    data['stationBoxId'] = stationBoxId;
    data['eroaming'] = eroaming;
    data['operatorName'] = operatorName;
    if (stationAddress != null) {
      data['stationAddress'] = stationAddress!.toJson();
    }
    if (connectors != null) {
      data['connectors'] = connectors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StationAddress {
  String? stationStreet;
  String? stationCity;
  String? stationState;
  String? stationCountry;
  String? stationZip;

  StationAddress({
    this.stationStreet,
    this.stationCity,
    this.stationState,
    this.stationCountry,
    this.stationZip,
  });

  StationAddress.fromJson(Map<String, dynamic> json) {
    stationStreet = json['stationStreet'];
    stationCity = json['stationCity'];
    stationState = json['stationState'];
    stationCountry = json['stationCountry'];
    stationZip = json['stationZip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stationStreet'] = stationStreet;
    data['stationCity'] = stationCity;
    data['stationState'] = stationState;
    data['stationCountry'] = stationCountry;
    data['stationZip'] = stationZip;
    return data;
  }
}

class Connectors {
  String? name;
  int? id;
  String? status;
  String? plugType;
  String? power;
  double? priceKwh;
  double? priceMinute;
  double? priceVat;
  String? currency;
  String? tariffName;

  Connectors({
    this.name,
    this.id,
    this.status,
    this.plugType,
    this.power,
    this.priceKwh,
    this.priceMinute,
    this.priceVat,
    this.currency,
    this.tariffName,
  });

  Connectors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    status = json['status'];
    plugType = json['plugType'];
    power = json['power'];
    priceKwh = json['priceKwh'];
    priceMinute = json['priceMinute'];
    priceVat = json['priceVat'];
    currency = json['currency'];
    tariffName = json['tariffName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['status'] = status;
    data['plugType'] = plugType;
    data['power'] = power;
    data['priceKwh'] = priceKwh;
    data['priceMinute'] = priceMinute;
    data['priceVat'] = priceVat;
    data['currency'] = currency;
    data['tariffName'] = tariffName;
    return data;
  }
}
