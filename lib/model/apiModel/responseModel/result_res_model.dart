class ResultResModel {
  int? status;
  String? msg;
  Data? data;

  ResultResModel({this.status, this.msg, this.data});

  ResultResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Campaigns>? campaigns;
  List<Contests>? contests;

  Data({this.campaigns, this.contests});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['campaigns'] != null) {
      campaigns = <Campaigns>[];
      json['campaigns'].forEach((v) {
        campaigns!.add(new Campaigns.fromJson(v));
      });
    }
    if (json['contests'] != null) {
      contests = <Contests>[];
      json['contests'].forEach((v) {
        contests!.add(new Contests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.campaigns != null) {
      data['campaigns'] = this.campaigns!.map((v) => v.toJson()).toList();
    }
    if (this.contests != null) {
      data['contests'] = this.contests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Campaigns {
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
  String? amount;
  String? totalAmount;
  String? createdOn;

  Campaigns(
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
      this.amount,
      this.totalAmount,
      this.createdOn});

  Campaigns.fromJson(Map<String, dynamic> json) {
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
    amount = json['amount'];
    totalAmount = json['total_amount'];
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
    data['static_meme'] = this.staticMeme;
    data['video_meme'] = this.videoMeme;
    data['gif'] = this.gif;
    data['no_of_meme_needed'] = this.noOfMemeNeeded;
    data['amount'] = this.amount;
    data['total_amount'] = this.totalAmount;
    data['created_on'] = this.createdOn;
    return data;
  }
}

class Contests {
  int? id;
  String? description;
  String? image;
  String? firstAward;
  String? secondAward;
  String? thirdAward;
  String? status;
  String? createdOn;

  Contests(
      {this.id,
      this.description,
      this.image,
      this.firstAward,
      this.secondAward,
      this.thirdAward,
      this.status,
      this.createdOn});

  Contests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    image = json['image'];
    firstAward = json['first_award'];
    secondAward = json['second_award'];
    thirdAward = json['third_award'];
    status = json['status'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['image'] = this.image;
    data['first_award'] = this.firstAward;
    data['second_award'] = this.secondAward;
    data['third_award'] = this.thirdAward;
    data['status'] = this.status;
    data['created_on'] = this.createdOn;
    return data;
  }
}
