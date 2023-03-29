class RemoteStopReqModel {
  String? idTag;
  String? chargeBoxId;
  String? transactionId;

  RemoteStopReqModel({this.idTag, this.chargeBoxId, this.transactionId});

  RemoteStopReqModel.fromJson(Map<String, dynamic> json) {
    idTag = json['idTag'];
    chargeBoxId = json['chargeBoxId'];
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTag'] = idTag;
    data['chargeBoxId'] = chargeBoxId;
    data['transactionId'] = transactionId;
    return data;
  }
}
