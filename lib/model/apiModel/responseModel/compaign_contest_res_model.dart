class CampaignContestResModel {
  int? status;
  String? msg;
  List<Campaign>? campaign;
  List<Contest>? contest;

  CampaignContestResModel({this.status, this.msg, this.campaign, this.contest});

  CampaignContestResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['campaign'] != null) {
      campaign = <Campaign>[];
      json['campaign'].forEach((v) {
        campaign!.add(new Campaign.fromJson(v));
      });
    }
    if (json['contest'] != null) {
      contest = <Contest>[];
      json['contest'].forEach((v) {
        contest!.add(new Contest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.campaign != null) {
      data['campaign'] = this.campaign!.map((v) => v.toJson()).toList();
    }
    if (this.contest != null) {
      data['contest'] = this.contest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Campaign {
  int? id;
  String? description;
  String? image;
  String? firstAward;
  String? secondAward;
  String? thirdAward;
  String? createdOn;
  String? applied;

  Campaign({
    this.id,
    this.description,
    this.image,
    this.firstAward,
    this.secondAward,
    this.thirdAward,
    this.createdOn,
    this.applied,
  });

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    image = json['image'];
    firstAward = json['first_award'];
    secondAward = json['second_award'];
    thirdAward = json['third_award'];
    createdOn = json['created_on'];
    applied = json['applied'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['image'] = this.image;
    data['first_award'] = this.firstAward;
    data['second_award'] = this.secondAward;
    data['third_award'] = this.thirdAward;
    data['created_on'] = this.createdOn;
    data['applied'] = this.applied ?? "false";
    return data;
  }
}

class Contest {
  int? id;
  String? description;
  String? image;
  String? firstAward;
  String? secondAward;
  String? thirdAward;
  String? createdOn;
  String? applied;

  Contest(
      {this.id,
      this.description,
      this.image,
      this.firstAward,
      this.secondAward,
      this.thirdAward,
      this.createdOn,
      this.applied});

  Contest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    image = json['image'];
    firstAward = json['first_award'];
    secondAward = json['second_award'];
    thirdAward = json['third_award'];
    createdOn = json['created_on'];
    applied = json['applied'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['image'] = this.image;
    data['first_award'] = this.firstAward;
    data['second_award'] = this.secondAward;
    data['third_award'] = this.thirdAward;
    data['created_on'] = this.createdOn;
    data['applied'] = this.applied ?? "false";
    return data;
  }
}
