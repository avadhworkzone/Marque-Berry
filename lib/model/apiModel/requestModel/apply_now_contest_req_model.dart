class ApplyContestReqModel {
  String? campaignId;
  String? media;
  String? mediaType;

  ApplyContestReqModel({this.campaignId, this.media, this.mediaType});

  ApplyContestReqModel.fromJson(Map<String, dynamic> json) {
    campaignId = json['contest_id'];
    media = json['media'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contest_id'] = this.campaignId;
    data['file'] = this.media;
    data['media_type'] = this.mediaType;
    return data;
  }
}
