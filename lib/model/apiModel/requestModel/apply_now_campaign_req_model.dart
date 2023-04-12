class ApplyCampaignReqModel {
  String? contestId;
  String? media;

  ApplyCampaignReqModel({this.contestId, this.media});

  ApplyCampaignReqModel.fromJson(Map<String, dynamic> json) {
    contestId = json['campaign_id'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaign_id'] = this.contestId;
    data['file'] = this.media;
    return data;
  }
}
