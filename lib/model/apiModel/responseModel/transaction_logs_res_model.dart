class TransactionLogsResModel {
  String? status;
  int? count;
  List<Data>? data;

  TransactionLogsResModel({this.status, this.count, this.data});

  TransactionLogsResModel.fromJson(Map<String, dynamic> json) {
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
  int? transactionPk;
  String? startTransactionTs;
  String? endTransactionTs;
  double? meterValueStart;
  double? meterValueStop;
  String? idTag;
  String? state;
  String? chargeBoxId;
  int? connectorId;
  String? roamingType;
  double? calculatedPrice;
  String? connectorName;
  String? vendorErrorCode;
  PriceComponents? priceComponents;

  Data({
    this.transactionPk,
    this.startTransactionTs,
    this.endTransactionTs,
    this.meterValueStart,
    this.meterValueStop,
    this.idTag,
    this.state,
    this.chargeBoxId,
    this.connectorId,
    this.roamingType,
    this.calculatedPrice,
    this.connectorName,
    this.vendorErrorCode,
    this.priceComponents,
  });

  Data.fromJson(Map<String, dynamic> json) {
    transactionPk = json['transactionPk'] ?? 0;
    startTransactionTs = json['startTransactionTs'];
    endTransactionTs = json['endTransactionTs'] ?? "";
    meterValueStart = json['meterValueStart'] ?? 0.0;
    meterValueStop = json['meterValueStop'] ?? 0.0;
    idTag = json['idTag'];
    state = json['state'];
    chargeBoxId = json['chargeBoxId'];
    connectorId = json['connectorId'];
    roamingType = json['roamingType'];
    calculatedPrice = json['calculatedPrice'];
    connectorName = json['connectorName'];
    vendorErrorCode = json['vendorErrorCode'] ?? "";
    priceComponents = PriceComponents.fromJson(json['priceComponents']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transactionPk'] = transactionPk;
    data['startTransactionTs'] = startTransactionTs;
    data['endTransactionTs'] = endTransactionTs;
    data['meterValueStart'] = meterValueStart;
    data['meterValueStop'] = meterValueStop;
    data['idTag'] = idTag;
    data['state'] = state;
    data['chargeBoxId'] = chargeBoxId;
    data['connectorId'] = connectorId;
    data['roamingType'] = roamingType;
    data['calculatedPrice'] = calculatedPrice;
    data['connectorName'] = connectorName;
    data['vendorErrorCode'] = vendorErrorCode;
    if (priceComponents != null) {
      data['priceComponents'] = priceComponents!.toJson();
    }
    return data;
  }
}

class PriceComponents {
  double? pricePerKwh;
  double? pricePerMinute;
  double? priceFlatFee;
  double? pricePercentFee;
  bool? vatIncluded;
  String? currency;

  PriceComponents({
    this.pricePerKwh,
    this.pricePerMinute,
    this.priceFlatFee,
    this.pricePercentFee,
    this.vatIncluded,
    this.currency,
  });

  PriceComponents.fromJson(Map<String, dynamic> json) {
    pricePerKwh = json['pricePerKwh'] ?? 0.0;
    pricePerMinute = json['pricePerMinute'] ?? 0.0;
    priceFlatFee = json['priceFlatFee'] ?? 0.0;
    pricePercentFee = json['pricePercentFee'] ?? 0.0;
    vatIncluded = json['vatIncluded'] ?? false;
    currency = json['currency'] ?? "USD";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pricePerKwh'] = pricePerKwh;
    data['pricePerMinute'] = pricePerMinute;
    data['priceFlatFee'] = priceFlatFee;
    data['pricePercentFee'] = pricePercentFee;
    data['vatIncluded'] = vatIncluded;
    data['currency'] = currency;
    return data;
  }
}
