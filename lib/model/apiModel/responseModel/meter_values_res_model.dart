class MeterValuesResModel {
  String? status;
  int? count;
  List<Data>? data;

  MeterValuesResModel({this.status, this.count, this.data});

  MeterValuesResModel.fromJson(Map<String, dynamic> json) {
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
  String? timestamp;
  int? transactionPk;
  int? connectorId;
  String? chargeBoxId;
  double? value;
  String? measurand;
  String? unit;
  String? location;
  String? phase;
  String? context;
  String? chargeBoxName;

  Data(
      {this.timestamp,
      this.transactionPk,
      this.connectorId,
      this.chargeBoxId,
      this.value,
      this.measurand,
      this.unit,
      this.location,
      this.phase,
      this.context,
      this.chargeBoxName});

  Data.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    transactionPk = json['transactionPk'];
    connectorId = json['connectorId'];
    chargeBoxId = json['chargeBoxId'];
    value = json['value'];
    measurand = json['measurand'];
    unit = json['unit'];
    location = json['location'];
    phase = json['phase'];
    context = json['context'];
    chargeBoxName = json['chargeBoxName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['transactionPk'] = transactionPk;
    data['connectorId'] = connectorId;
    data['chargeBoxId'] = chargeBoxId;
    data['value'] = value;
    data['measurand'] = measurand;
    data['unit'] = unit;
    data['location'] = location;
    data['phase'] = phase;
    data['context'] = context;
    data['chargeBoxName'] = chargeBoxName;
    return data;
  }
}
