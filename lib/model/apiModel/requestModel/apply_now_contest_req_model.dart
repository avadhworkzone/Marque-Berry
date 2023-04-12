class ApplyContestReqModel {
  String? campaignId;
  String? media;

  ApplyContestReqModel({this.campaignId, this.media});

  ApplyContestReqModel.fromJson(Map<String, dynamic> json) {
    campaignId = json['contest_id'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contest_id'] = this.campaignId;
    data['file'] = this.media;
    return data;
  }
}
