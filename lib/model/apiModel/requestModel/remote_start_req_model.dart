class RemoteStartReqModel {
  String? idTag;
  String? chargeBoxId;
  String? connectorId;

  RemoteStartReqModel({this.idTag, this.chargeBoxId, this.connectorId});

  RemoteStartReqModel.fromJson(Map<String, dynamic> json) {
    idTag = json['idTag'];
    chargeBoxId = json['chargeBoxId'];
    connectorId = json['connectorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTag'] = idTag;
    data['chargeBoxId'] = chargeBoxId;
    data['connectorId'] = connectorId;
    return data;
  }
}
