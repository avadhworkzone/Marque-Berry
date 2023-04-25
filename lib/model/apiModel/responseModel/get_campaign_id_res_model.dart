class GetCampaignIdResModel {
  int? status;
  String? msg;
  List<Data>? data;

  GetCampaignIdResModel({this.status, this.msg, this.data});

  GetCampaignIdResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? brandName;
  String? campaignName;
  String? logo;
  String? timeLimit;
  String? description;
  String? status;
  String? staticMeme;
  String? videoMeme;
  String? gif;
  String? noOfMemeNeeded;
  String? createdOn;

  Data(
      {this.id,
      this.userId,
      this.brandName,
      this.campaignName,
      this.logo,
      this.timeLimit,
      this.description,
      this.status,
      this.staticMeme,
      this.videoMeme,
      this.gif,
      this.noOfMemeNeeded,
      this.createdOn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    brandName = json['brand_name'];
    campaignName = json['campaign_name'];
    logo = json['logo'];
    timeLimit = json['time_limit'];
    description = json['description'];
    status = json['status'];
    staticMeme = json['static_meme'];
    videoMeme = json['video_meme'];
    gif = json['gif'];
    noOfMemeNeeded = json['no_of_meme_needed'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['brand_name'] = this.brandName;
    data['campaign_name'] = this.campaignName;
    data['logo'] = this.logo;
    data['time_limit'] = this.timeLimit;
    data['description'] = this.description;
    data['status'] = this.status;
    data['static_meme'] = this.staticMeme ?? "";
    data['video_meme'] = this.videoMeme ?? "";
    data['gif'] = this.gif ?? "";
    data['no_of_meme_needed'] = this.noOfMemeNeeded;
    data['created_on'] = this.createdOn;
    return data;
  }
}
