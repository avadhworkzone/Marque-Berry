class AcceptFollowReqModel {
  String? requestId;

  AcceptFollowReqModel({this.requestId});

  AcceptFollowReqModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    return data;
  }
}
