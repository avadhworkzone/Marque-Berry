class RetailPriceReqModel {
  String? idTag;
  String? stationBoxId;
  String? connectorName;

  RetailPriceReqModel({this.idTag, this.stationBoxId, this.connectorName});

  RetailPriceReqModel.fromJson(Map<String, dynamic> json) {
    idTag = json['idTag'];
    stationBoxId = json['stationBoxId'];
    connectorName = json['connectorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTag'] = idTag;
    data['stationBoxId'] = stationBoxId;
    data['connectorName'] = connectorName;
    return data;
  }
}
