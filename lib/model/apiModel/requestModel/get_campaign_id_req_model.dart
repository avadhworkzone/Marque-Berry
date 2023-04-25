class GetCampaignIdReqModel {
  String? campaignId;

  GetCampaignIdReqModel({this.campaignId});

  GetCampaignIdReqModel.fromJson(Map<String, dynamic> json) {
    campaignId = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contest_id'] = this.campaignId;
    return data;
  }
}
