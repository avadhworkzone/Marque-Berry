class ApplyCampaignResModel {
  int? status;
  String? msg;

  ApplyCampaignResModel({this.status, this.msg});

  ApplyCampaignResModel.fromJson(Map<String, dynamic> json) {
    status = json['campaign_id'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaign_id'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}
