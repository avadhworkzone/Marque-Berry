class RetailPriceResModel {
  String? status;
  int? count;
  Data? data;

  RetailPriceResModel({this.status, this.count, this.data});

  RetailPriceResModel.fromJson(Map<String, dynamic> json) {
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
  String? stationName;
  String? stationBoxId;
  bool? eroaming;
  String? operatorName;
  StationAddress? stationAddress;
  List<Connectors>? connectors;

  Data(
      {this.stationName,
      this.stationBoxId,
      this.eroaming,
      this.operatorName,
      this.stationAddress,
      this.connectors});

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
  String? street;
  String? zip;
  String? city;
  double? gpsLat;
  double? gpsLong;
  String? state;
  String? country;

  StationAddress({
    this.street,
    this.zip,
    this.city,
    this.gpsLat,
    this.gpsLong,
    this.state,
    this.country,
  });

  StationAddress.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    zip = json['zip'];
    city = json['city'];
    gpsLat = json['gpsLat'];
    gpsLong = json['gpsLong'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['zip'] = zip;
    data['city'] = city;
    data['gpsLat'] = gpsLat;
    data['gpsLong'] = gpsLong;
    data['state'] = state;
    data['country'] = country;
    return data;
  }
}

class Connectors {
  String? name;
  int? id;
  String? plugType;
  String? status;
  String? currency;
  String? tariffName;
  double? priceKwh;
  double? priceMinute;
  double? priceFlat;
  double? priceVat;

  Connectors({
    this.name,
    this.id,
    this.plugType,
    this.status,
    this.currency,
    this.tariffName,
    this.priceKwh,
    this.priceMinute,
    this.priceFlat,
    this.priceVat,
  });

  Connectors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    plugType = json['plugType'];
    status = json['status'];
    currency = json['currency'];
    tariffName = json['tariffName'];
    priceKwh = json['priceKwh'];
    priceMinute = json['priceMinute'];
    priceFlat = json['priceFlat'];
    priceVat = json['priceVat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['plugType'] = plugType;
    data['status'] = status;
    data['currency'] = currency;
    data['tariffName'] = tariffName;
    data['priceKwh'] = priceKwh;
    data['priceMinute'] = priceMinute;
    data['priceFlat'] = priceFlat;
    data['priceVat'] = priceVat;
    return data;
  }
}
