class InventoryResModel {
  String? status;
  int? count;
  List<Data>? data;

  InventoryResModel({this.status, this.count, this.data});

  InventoryResModel.fromJson(Map<String, dynamic> json) {
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
  String? chargeBoxId;
  int? connectorId;
  String? connectorName;
  String? siteOwnerName;

  Data({
    this.chargeBoxId,
    this.connectorId,
    this.connectorName,
    this.siteOwnerName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    chargeBoxId = json['chargeBoxId'];
    connectorId = json['connectorId'];
    connectorName = json['connectorName'];
    siteOwnerName = json['siteOwnerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chargeBoxId'] = chargeBoxId;
    data['connectorId'] = connectorId;
    data['connectorName'] = connectorName;
    data['siteOwnerName'] = siteOwnerName;
    return data;
  }
}
