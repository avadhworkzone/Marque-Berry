class ApplyCampaignReqModel {
  String? contestId;
  String? media;
  String? mediaType;

  ApplyCampaignReqModel({this.contestId, this.media, this.mediaType});

  ApplyCampaignReqModel.fromJson(Map<String, dynamic> json) {
    contestId = json['campaign_id'];
    media = json['media'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaign_id'] = this.contestId;
    data['file'] = this.media;
    data['media_type'] = this.mediaType;
    return data;
  }
}
